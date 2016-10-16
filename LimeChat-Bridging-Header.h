//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

//#ifdef __OBJC__
#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>
#import <Carbon/Carbon.h>
//#endif

#import "IRCChannelMode.h"
#import "IRCISupportInfo.h"
#import "DialogWindow.h"
#import "SheetBase.h"
#import "GistClient.h"
#import "NSStringHelper.h"
#import "ListDialog.h"
#import "NSDictionaryHelper.h"
#import "Preferences.h"

#ifdef DEBUG_BUILD
#define LOG(...) NSLog(__VA_ARGS__);
#define LOG_METHOD NSLog(@"%s", __func__);
#else
#define LOG(...) ;
#define LOG_METHOD ;
#endif
