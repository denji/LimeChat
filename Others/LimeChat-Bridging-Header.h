//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

//#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>
//#endif

#ifdef DEBUG_BUILD
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...) ;
#define LOG_METHOD ;
#endif
