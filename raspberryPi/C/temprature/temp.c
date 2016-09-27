#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
//Intended for the Raspberry Pi, but without the GPIO calls, may work with other linux distros
int getTemp(){
	 
	FILE *temperatureFile;
	int T;
	temperatureFile = fopen ("/sys/class/thermal/thermal_zone0/temp", "r");
	fscanf (temperatureFile, "%d", &T);
	T /= 1000;
	//printf ("%d\n", T);
	fclose (temperatureFile);
	return T;
	}

void ledStat(int temp){
	//RGB Swich statements for colour change R=hot G=good B=cool
	//temps 25C-80C 
	switch(temp){
		case 0 ... 30:
			printf("Blue\n");
			break;
		case 31 ... 60:
			printf("Green\n");
			break;
		case 61 ... 80:
			printf("Red Hot\n");
			break;
		default:
			printf("WTF Happend?\n");
		}
}

int main(){
	while (1){
		  printf ("%d\n", getTemp()); //display
		  ledStat(getTemp());         //Do something with it.
		  usleep(50000);
		  system("clear");
		  }
return 0;
}
