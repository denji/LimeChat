// Copyright (C) 2007-2014 Satoshi Nakagawa <psychs AT limechat DOT net>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

#import "ImageDownloadManager.h"
#import "IRCWorld.h"
#import "ImageSizeCheckClient.h"

static ImageDownloadManager *_instance;

@implementation ImageDownloadManager {
    NSMutableSet *_checkers;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _checkers = [NSMutableSet new];
    }
    return self;
}

- (void)dealloc
{
    [_checkers makeObjectsPerformSelector:@selector( cancel )];
}

+ (ImageDownloadManager *)instance
{
    if( !_instance ) {
        _instance = [ImageDownloadManager new];
    }
    return _instance;
}

+ (void)disposeInstance
{
    _instance = nil;
}

- (void)checkImageSize:(NSString *)url client:(IRCClient *)client channel:(IRCChannel *)channel lineNumber:(int)lineNumber imageIndex:(int)imageIndex
{
    ImageSizeCheckClient *c = [ImageSizeCheckClient new];
    c.delegate = self;
    c.url = url;
    c.uid = client.uid;
    c.cid = channel.uid;
    c.lineNumber = lineNumber;
    c.imageIndex = imageIndex;
    [c checkSize];
    [_checkers addObject:c];
}

#pragma mark - ImageSizeCheckClient Delegate

- (void)imageSizeCheckClient:(ImageSizeCheckClient *)sender didReceiveContentLength:(long long)contentLength andType:(NSString *)contentType
{
    [_checkers removeObject:sender];

    int uid = sender.uid;
    int cid = sender.cid;
    LogController *log = nil;

    if( cid ) {
        IRCChannel *channel = [_world findChannelByClientId:uid channelId:cid];
        if( channel ) {
            log = channel.log;
        }
    }
    else {
        IRCClient *client = [_world findClientById:uid];
        if( client ) {
            log = client.log;
        }
    }

    if( log ) {
        [log expandImage:sender.url lineNumber:sender.lineNumber imageIndex:sender.imageIndex contentLength:contentLength contentType:contentType];
    }
}

- (void)imageSizeCheckClient:(ImageSizeCheckClient *)sender didFailWithError:(NSError *)error statusCode:(int)statusCode
{
    [_checkers removeObject:sender];
}

@end
