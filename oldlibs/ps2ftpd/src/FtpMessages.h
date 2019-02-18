#ifndef __FTPMESSAGES_H__
#define __FTPMESSAGES_H__

enum {
	FTPMSG_SERVER_READY,
	FTPMSG_GOODBYE,
	FTPMSG_USER_LOGGED_IN,
	FTPMSG_PASSWORD_REQUIRED_FOR_USER,
	FTPMSG_LOGIN_INCORRECT,
	FTPMSG_LOGIN_WITH_USER_FIRST,
	FTPMSG_ALREADY_AUTHENTICATED,
	FTPMSG_ENTERING_PASSIVE_MODE,
	FTPMSG_COULD_NOT_ENTER_PASSIVE_MODE,
	FTPMSG_COMMAND_SUCCESSFUL,
	FTPMSG_COMMAND_FAILED,
	FTPMSG_ILLEGAL_COMMAND,
	FTPMSG_UNABLE_TO_OPEN_DIRECTORY,
	FTPMSG_FILE_NOT_FOUND,
	FTPMSG_COULD_NOT_CREATE_FILE,
	FTPMSG_COULD_NOT_GET_FILESIZE,
	FTPMSG_REQUIRES_PARAMETERS,
	FTPMSG_NOT_SUPPORTED,
	FTPMSG_NOT_UNDERSTOOD,
	FTPMSG_OPENING_ASCII_CONNECTION,
	FTPMSG_OPENING_BINARY_CONNECTION,
	FTPMSG_UNABLE_TO_BUILD_DATA_CONNECTION,
	FTPMSG_TRANSFER_FAILED,
	FTPMSG_LOCAL_WRITE_FAILED,
	FTPMSG_FAILED_READING_DATA,
	FTPMSG_PREMATURE_CLIENT_DISCONNECT,
	FTPMSG_INVALID_RESTART_MARKER,
	FTPMSG_RESTART_MARKER_SET,
};

extern const char *FtpMessage[];

#endif
