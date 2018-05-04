#if defined(__gnu_linux__)
#include <sys/types.h> /* ssize_t */
#endif
#define OPENSSL_NO_DEPRECATED
#define OPENSSL_NO_FILENAMES
#include <openssl/md5.h>
#include <openssl/sha.h>
#undef OPENSSL_NO_DEPRECATED
#undef OPENSSL_NO_FILENAMES
