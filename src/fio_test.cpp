#include <fstream>
#include <iostream>
#include <unistd.h>
#include <cstring>
#include <sys/file.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <vector>
#include <mutex>
#include <algorithm>
#include "boost/filesystem.hpp"

#include "fio_mine.h"

#define _USE_GNU 1
#define _GNU_SOURCE

namespace fio_test
{
    int logger_start(const std::string &log_file_name)
    {
        log_file_.open(log_file_name, std::ios::out);
        return 0;
    }

    int logger_logging(size_t io_num, size_t start_times[], size_t stop_times[])
    {
        std::unique_lock<std::mutex> lock(log_file_lock_);
        log_file_ << io_num << std::endl;
        for (int i = 0; i < io_num; i++)
        {
            log_file_ << start_times[i] << "," << stop_times[i] << std::endl;
        }
        return 0;
    }
    int logger_stop()
    {
        log_file_.flush();
        log_file_.close();
        return 0;
    }

    std::atomic<size_t> IOTest::thread_count_(0);

    IOTest::IOTest(IOMode io_mode, IOEngine io_engine, RorW ioro, std::string &test_path, size_t slot_size, size_t io_size, size_t io_num, size_t iter_num, int fd, void *data_file_mmaped) : io_mode_(io_mode), io_engine_(io_engine), slot_size_(slot_size), io_size_(io_size), io_num_(io_num), iter_num_(iter_num), exit_flag_(false)
    {
        thread_id_ = thread_count_.fetch_add(1);
        if (fd == -1)
        {
            data_file_ = open(GetFilePath(ioro, test_path).c_str(), FILE_OPEN_FLAGS | O_CREAT);
            file_offset_ = 0;
            private_file_ = true;
        }
        else
        {
            data_file_ = fd;
            data_file_mmaped_ = data_file_mmaped;
            file_offset_ = 1024LU * 1024LU * 1024LU * 8LU * thread_id_;
            private_file_ = false;
        }

        if (data_file_ == -1)
        {
            std::cout << "Open file failed!!!" << std::endl;
        }

        start_time_ = (size_t *)calloc(io_num_ * iter_num_, sizeof(size_t));
        stop_time_ = (size_t *)calloc(io_num_ * iter_num_, sizeof(size_t));

        std::vector<int> order_output(io_num_);
        std::iota(order_output.begin(), order_output.end(), 0);
        if (io_mode_ == IOMode::RANDOM)
        {
            logger::shuffle_mine(order_output);
        }
        order_ = std::move(order_output);

        switch (ioro)
        {
        case RorW::RO:
            operator_ = std::thread([this]()
                                    { ReadFile(); });
            break;
        case RorW::WO:
            operator_ = std::thread([this]()
                                    { WriteFile(); });
            break;
        case RorW::RW:
            std::cout << "Not defined Operation!!!" << std::endl;
            break;
        default:
            std::cout << "I wont do anything!!!" << std::endl;
        }
    }

    IOTest::~IOTest()
    {
        if (operator_.joinable())
        {
            operator_.join();
        }

        logger_logging(io_num_, start_time_, stop_time_);
        free(start_time_);
        free(stop_time_);
        if (private_file_)
        {
            close(data_file_);
        }
        // munmap(data_file_mmaped_, file_size_inByte);
    }

    int IOTest::ReadFile()
    {
        switch (io_engine_)
        {
        case IOEngine::MMAP:
            if (private_file_)
            {
                size_t file_size_inByte = slot_size_ * io_num_;
                data_file_mmaped_ = mmap(NULL, file_size_inByte, PROT_READ | PROT_WRITE, MAP_SHARED, data_file_, 0);
                madvise(data_file_mmaped_, file_size_inByte, MMAP_ADVICE); // Turn off readahead
            }
            return MRead();
        case IOEngine::PRW:
            return PRead();
        }
    }

    int IOTest::WriteFile()
    {

        switch (io_engine_)
        {
        case IOEngine::MMAP:
            if (private_file_)
            {
                size_t file_size_inByte = slot_size_ * io_num_;

                ftruncate(data_file_, file_size_inByte);

                data_file_mmaped_ = mmap(NULL, file_size_inByte, PROT_READ | PROT_WRITE, MAP_SHARED, data_file_, 0);

                madvise(data_file_mmaped_, file_size_inByte, MMAP_ADVICE); // Turn off readahead
            }
            return MWrite();
        case IOEngine::PRW:
            return PWrite();
        }
    }

    int IOTest::PRead()
    {
        char *in_buf = (char *)aligned_alloc(512 * 8, io_size_);
        char *tmp_buf = (char *)malloc(1);
        size_t start = 0, end = 0;
        size_t latency = 0;
        volatile int a = 0;
        int ret = -1;
        size_t curr_io_fileoffset;
        for (int j = 0; j < iter_num_; j++)
        {
            for (auto i : order_)
            {
                size_t index = i + j * io_num_;
                curr_io_fileoffset = file_offset_ + slot_size_ * i + io_size_ * j;
                start_time_[index] = logger::Profl::GetSystemTime();
                ret = pread(data_file_, in_buf, io_size_, curr_io_fileoffset);
                memcpy(tmp_buf, in_buf, 1);
                stop_time_[index] = logger::Profl::GetSystemTime();
                // Prevent this code section from compiler optimization
                if (ret != io_size_)
                {
                    std::cout << "Function pread failed!!!" << std::endl;
                    return -1;
                }
                if (strcmp(tmp_buf, "a") == 0)
                {
                    a = 0;
                }
                else
                {
                    a = 1;
                    std::cout << "pread content error!!!" << std::endl;
                    return -1;
                }
                tmp_buf[0] = ' ';
            }
        }

        free(in_buf);
        free(tmp_buf);
        return 0;
    }

    int IOTest::PWrite()
    {
        /** Pre-allocate SSD storage space */
        size_t file_size_inByte = slot_size_ * io_num_;
        ftruncate(data_file_, file_size_inByte);

        char *str = "abcdefgh";
        char *out_buf = (char *)aligned_alloc(512 * 8, io_size_);

        size_t buf_size = 0;
        while (buf_size < io_size_)
        {
            buf_size += sprintf(out_buf + buf_size, "%s", str);
        }

        volatile int ret = 0;
        size_t curr_io_fileoffset;
        for (int j = 0; j < iter_num_; j++)
        {
            for (auto i : order_)
            {
                size_t index = i + j * io_num_;
                curr_io_fileoffset = file_offset_ + slot_size_ * i + io_size_ * j;
                start_time_[index] = logger::Profl::GetSystemTime();
                ret = pwrite(data_file_, out_buf, io_size_, curr_io_fileoffset);
                fsync(data_file_);
                stop_time_[index] = logger::Profl::GetSystemTime();
                if (ret == -1)
                {
                    std::cout << "Function pwrite failed!!!" << std::endl;
                    return -1;
                }
            }
        }
        free(out_buf);
        fsync(data_file_);
        return 0;
    }

    int IOTest::MRead()
    {
        char *in_buf = (char *)calloc(1, 1);
        size_t start = 0;
        size_t latency = 0;
        volatile int a = 0;

        size_t curr_io_fileoffset =0;
        for (int j = 0; j < iter_num_; j++)
        {
            for (auto i : order_)
            {
                size_t index = i + j * io_num_;
                curr_io_fileoffset = file_offset_ + slot_size_ * i + io_size_ * j;
                start_time_[index] = logger::Profl::GetSystemTime();
                // Create one page fault
                memcpy(in_buf, (char *)data_file_mmaped_ + curr_io_fileoffset, 1);
                stop_time_[index] = logger::Profl::GetSystemTime();
                // Prevent this code section from compiler optimization
                if (strcmp(in_buf, "a") == 0)
                {
                    a = 0;
                }
                else
                {
                    a = 1;
                    std::cout << "pread content error!!!" << std::endl;
                    return -1;
                }
                in_buf[0] = ' ';
            }
        }
        free(in_buf);
        return 0;
    }

    int IOTest::MWrite()
    {
        char *str = "abcdefgh";
        char *out_buf = (char *)aligned_alloc(512 * 8, io_size_);

        size_t buf_size = 0;
        while (buf_size < io_size_)
        {
            buf_size += sprintf(out_buf + buf_size, "%s", str);
        }
        size_t curr_io_fileoffset = 0;
        for (int j = 0; j < iter_num_; j++)
        {
            for (auto i : order_)
            {
                size_t index = i + j * io_num_;
                curr_io_fileoffset = file_offset_ + slot_size_ * i+ io_size_ * j;
                start_time_[index] = logger::Profl::GetSystemTime();
                memcpy((char *)data_file_mmaped_ + file_offset_ + slot_size_ * i, out_buf, io_size_);
                fsync(data_file_);
                stop_time_[index] = logger::Profl::GetSystemTime();
            }
        }
        free(out_buf);
        return 0;
    }

    inline std::string IOTest::GetFilePath(RorW ioro, std::string &file_name)
    {
        std::string file_path;
        if (ioro != RorW::RO)
        {
            file_path = file_name + "/W_test" + "/data-" + std::to_string(thread_id_) + ".fio";
        }
        else
        {
            file_path = file_name + "/RO_test" + "/data-" + std::to_string(thread_id_) + ".fio";
        }

        // std::cout << file_path << std::endl;
        return file_path;
    }
}