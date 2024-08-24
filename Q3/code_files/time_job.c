#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <time.h>
#include <sys/wait.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <signal.h>

void alarm_handler(int _)
{
    puts("TLE");
    exit(0);
}

int main(int argc, char** argv){
    int proc = fork();
    int in_file = open(argv[3], O_RDONLY);
    int out_file = open(argv[4], O_WRONLY | O_TRUNC | O_CREAT, S_IRWXU);
    if (proc != 0){
        int x;
        struct timeval value1, value2;
        gettimeofday(&value1, NULL);
        long long start_time = value1.tv_sec*1000*1000 + value1.tv_usec;
        // int time_limit = 15;
        // while((waitpid(proc, &x, WNOHANG) == 0) && (time_limit-- > 0)){
        //     sleep(1);
        // }  
        // if (time_limit < 0){
        //     kill(proc, SIGKILL);
        //     return -1;
        // }
        signal(SIGALRM, alarm_handler);
        alarm(20);
        waitpid(proc, &x, 0);
        gettimeofday(&value2, NULL);
        long long end_time = value2.tv_sec*1000*1000 + value2.tv_usec;
        printf("%f\n", (end_time-start_time)/1000.0);
        fsync(out_file);
        close(in_file);
        close(out_file);
        return x;
    }
    else{
        if (dup2(in_file, 0) < 0 || dup2(out_file, 1) < 0 || dup2(out_file, 2) < 0){
            printf("DUP failed\n");
            return 1;
        }
        argv[3] = 0;
        execvp(argv[1], argv + 1);
    }
}