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

#import "TwitterAvatarURLManager.h"
#import "TwitterImageURLClient.h"

@implementation TwitterAvatarURLManager {
    NSMutableDictionary *_connections;
    NSMutableDictionary *_imageUrls;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _connections = [NSMutableDictionary new];
        _imageUrls = [NSMutableDictionary new];
    }
    return self;
}

+ (TwitterAvatarURLManager *)instance
{
    static TwitterAvatarURLManager *instance = nil;
    if( !instance ) {
        instance = [self new];
    }
    return instance;
}

- (void)dealloc
{
    for( TwitterImageURLClient *c in _connections ) {
        [c cancel];
    }
}

- (NSString *)imageURLForTwitterScreenName:(NSString *)screenName
{
    return [_imageUrls objectForKey:screenName];
}

- (BOOL)fetchImageURLForTwitterScreenName:(NSString *)screenName
{
    if( !screenName.length ) {
        return NO;
    }

    NSString *url = [_imageUrls objectForKey:screenName];
    if( url ) {
        return NO;
    }

    if( [_connections objectForKey:screenName] ) {
        return NO;
    }

    TwitterImageURLClient *client = [TwitterImageURLClient new];
    client.delegate = self;
    client.screenName = screenName;
    [_connections setObject:client forKey:screenName];
    [client getImageURL];

    return YES;
}

#pragma mark - TwitterImageURLClientDelegate

- (void)twitterImageURLClient:(TwitterImageURLClient *)sender didGetImageURL:(NSString *)imageUrl
{
    [_connections removeObjectForKey:sender];

    NSString *screenName = sender.screenName;
    if( screenName.length && imageUrl.length ) {
        [_imageUrls setObject:imageUrl forKey:screenName];
        [[NSNotificationCenter defaultCenter] postNotificationName:TwitterAvatarURLManagerDidGetImageURLNotification object:screenName];
    }
}

- (void)twitterImageURLClientDidReceiveBadURL:(TwitterImageURLClient *)sender
{
    [_connections removeObjectForKey:sender];
}

- (void)twitterImageURLClient:(TwitterImageURLClient *)sender didFailWithError:(NSString *)error
{
    [_connections removeObjectForKey:sender];
}

@end
