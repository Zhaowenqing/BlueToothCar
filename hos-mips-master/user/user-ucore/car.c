#include <syscall.h>
#define printf(...)                     fprintf(1, __VA_ARGS__)
void forward(int speed)
{
	syscall(144,0x9C,speed|(speed<<4)|(speed<<8)|(speed<<12));
}

void backward(int speed)
{
	syscall(144,0x63,speed|(speed<<4)|(speed<<8)|(speed<<12));
}

void turn_left(int speed){
    syscall(144,0x2E,speed|(speed<<4)|(speed<<8)|(speed<<12));
}

void turn_right(int speed)
{
	syscall(144,0xD1,speed|(speed<<4)|(speed<<8)|(speed<<12));
}


int main(int argc, char **argv){
    int sts=0;
    syscall(143);
    hello();
	while(1){
        unsigned int rxData=syscall(145);
        unsigned char ch=(unsigned char )rxData;
        switch(rxData){
 			case 'w'://forward
			{
				if(sts!=1)
				{
					sts=1;
					forward(15);	
				}
				else
				{

					forward(0);	
					sts=0;
				}
				break;
			}
			case 'a'://turn left
			{
				if(sts!=2)
				{
					sts=2;
					turn_left(15);

				}
				else
				{
					forward(0);	
					sts=0;
				}
				//内侧轮即13号轮方向取反。内侧速度小 外侧速度大
				break;
			}			
			case 'd'://turn right
			{
				if(sts!=4)
				{
					sts=4;
					turn_right(15);
				}
				else
				{
					forward(0);
					sts=0;
				}
				break;				
			}

			case 's'://backward
			{
				if(sts!=3)
				{
					sts=3;
					backward(15);
				}
				else
				{
					forward(0);
					sts=0;
				}
				break;
			}
			default:
			{
				forward(0);
				sts=0;
				
			}	           
        }

    }
}