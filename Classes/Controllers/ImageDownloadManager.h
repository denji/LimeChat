// LimeChat is copyrighted free software by Satoshi Nakagawa <psychs AT limechat DOT net>.
// You can redistribute it and/or modify it under the terms of the GPL version 2 (see the file GPL.txt).

#import "IRCChannel.h"
#import "IRCClient.h"
#import <Cocoa/Cocoa.h>

@interface ImageDownloadManager : NSObject

@property ( nonatomic, weak ) IRCWorld *world;

+ (ImageDownloadManager *)instance;
+ (void)disposeInstance;

- (void)checkImageSize:(NSString *)url client:(IRCClient *)client channel:(IRCChannel *)channel lineNumber:(int)lineNumber imageIndex:(int)imageIndex;

@end
