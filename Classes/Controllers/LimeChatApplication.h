// LimeChat is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the terms of the GPL version 2 (see the file GPL.txt).

#import "HotKeyManager.h"
#import <Cocoa/Cocoa.h>

@interface LimeChatApplication : NSApplication

- (void)registerHotKey:(int)keyCode modifierFlags:(NSUInteger)modFlags;
- (void)unregisterHotKey;

@end

@interface NSObject ( LimeChatApplicationDelegate )
- (void)applicationDidReceiveHotKey:(id)sender;
@end
