#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <syslog.h>
#include <stdbool.h>
#include <string.h>

int myOpen (const char *filePath);
bool myWrite (int fileID, const char *stringMessage);

int main (int argc, char *argv[]) {

    char *filePath, *stringMessage;

    filePath = argv[1];
    stringMessage = argv[2];

    openlog ("", LOG_CONS, LOG_USER);

    if (argc != 3) {
        syslog (LOG_ERR, "%s", "You need to pass two args!");
	return 1;
    }
    
    int fileID;
    fileID = myOpen (filePath);
  
    if(myWrite (fileID, stringMessage))
	syslog (LOG_DEBUG, "Writing %s to %s", stringMessage, filePath);
    
    fsync(fileID);
    close(fileID);
    closelog();
    return 0;
}

int myOpen (const char *filePath) {

    int fileID;

    fileID = creat (filePath, 0644);
    if (fileID == -1)
	syslog (LOG_ERR, "%s", "ERROR: can't open file");
	
    return fileID;
} 

bool myWrite (int fileID, const char *stringMessage) {

    size_t stringBytes;
    ssize_t writeBytes;

    stringBytes = strlen (stringMessage);
    writeBytes = write (fileID, stringMessage, stringBytes);
    if (writeBytes == -1) {
        syslog (LOG_ERR, "%s", "ERROR: can't write to file");
	return false;
    }
    else if (writeBytes != stringBytes) {
	syslog (LOG_ERR, "%s", "ERROR: wrote less than expected");
	return false;
    }
    return true;	
}
