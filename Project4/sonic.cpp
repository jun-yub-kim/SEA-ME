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
    while(1){
    
	cout <<"**** SRF08 test program ****\n";
	
	int fd;														// File descrition
	// For older raspberry pi modules use "/dev/i2c-0" instead of "/dev/i2c-1" for the i2c port
									// Name of the port we will be using
	int  address = 0x70;										// Address of the SRF08 shifted right 1 bit
	unsigned char buf[10];										// Buffer for data being read/ written on the i2c bus
	
	if ((fd = open("/dev/i2c-1", O_RDWR)) < 0) {					// Open port for reading and writing
		cout << "Failed to open i2c port\n";
		exit(1);
	}
	
	if (ioctl(fd, I2C_SLAVE, address) < 0) {					// Set the port options and set the address of the device we wish to speak to
		cout << "Unable to get bus access to talk to slave\n";
		exit(1);
	}
	
	buf[0] = 0;													// Commands for performing a ranging on the SRF08
	buf[1] = 81;
	
	if ((write(fd, buf, 2)) != 2) {								// Write commands to the i2c port
		cout << "Error writing to i2c slave\n";
		exit(1);
	}
	
	usleep(750000);												// this sleep waits for the ping to come back
	
	buf[0] = 0;													// This is the register we wish to read from
	
	if ((write(fd, buf, 1)) != 1) {								// Send register to read from
		cout << "Error writing to i2c slave\n";
		exit(1);
	}
	
	if (read(fd, buf, 4) != 4) {								// Read back data into buf[]
		cout << "Unable to read from slave\n";
		exit(1);
	}
	else {
		unsigned char highByte = buf[2];
		unsigned char lowByte = buf[3];
		unsigned int result = (highByte <<8) + lowByte;			// Calculate range
		cout << "Software v: " << buf[0] << endl;
		cout << "Light: %u " << buf[1] << endl;
		cout << "Range was: " << result << endl;
	}
	Mysleep(1);
	}
	return 0;
}

