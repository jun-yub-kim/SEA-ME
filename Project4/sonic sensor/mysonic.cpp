#include <iostream>
#include <cstdlib>
#include <linux/i2c-dev.h>
#include <fcntl.h>
#include <cstring>
#include <sys/ioctl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <ctime>

using namespace std;

void Mysleep(int a)
{
    clock_t start_clk = clock();
    
    a--;
    while(1) {
        if ((clock() - start_clk) / CLOCKS_PER_SEC > a) break;
        }

}

int main(int argc, char **argv)
{
    cout <<"초음파 센서 프로그램 가동" << endl;    
    
    while(1){
    
    int address = 0x70;
    unsigned char buf[10];
    int fd = open("/dev/i2c-1", O_RDWR); // O_RDWR = open for reading and writing
    ioctl(fd, I2C_SLAVE, address);
        
    buf[0] = 0;
    buf[1] = 81;
    
    write(fd, buf, 2);
    
    usleep(750000);
    
    write(fd, buf, 1);
    
    read(fd, buf, 4);
    
    
    buf[0] = 0;
    
    unsigned char highByte = buf[2];
    unsigned char lowByte = buf[3];
    unsigned int result = (highByte <<8) + lowByte;			// Calculate range
    cout <<"Range was: " << result << endl;
    
    
    	Mysleep(0.1);
    }

}
