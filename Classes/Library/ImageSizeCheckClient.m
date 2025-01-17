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

#import "ImageSizeCheckClient.h"

#define IMAGE_SIZE_CHECK_TIMEOUT 30

@implementation ImageSizeCheckClient {
    NSURLConnection *_conn;
    NSHTTPURLResponse *_response;
}

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

- (void)dealloc
{
    [self cancel];
}

- (void)cancel
{
    [_conn cancel];
    _conn = nil;
    _response = nil;
}

- (void)checkSize
{
    [self cancel];

    NSURL *u = [NSURL URLWithString:_url];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:u cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:IMAGE_SIZE_CHECK_TIMEOUT];
    [req setHTTPMethod:@"HEAD"];

    if( [[u host] hasSuffix:@"pixiv.net"] ) {
        [req setValue:@"http://www.pixiv.net" forHTTPHeaderField:@"Referer"];
    }

    _conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

#pragma mark - NSURLConnection Delegate

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
    return nil;
}

- (void)connection:(NSURLConnection *)sender didReceiveResponse:(NSHTTPURLResponse *)aResponse
{
    if( _conn != sender ) return;

    _response = aResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)sender
{
    if( _conn != sender ) return;

    /* If a user clicks a link that redirects to a data image, then
	 this value will not be NSHTTPURLResponse which results in a crash
	 when trying to make a call to -allHeaderFields */
    if( [_response isKindOfClass:[NSHTTPURLResponse class]] == NO ) {
        return;
    }

    long long contentLength = 0;
    NSString *contentType;
    int statusCode = [_response statusCode];

    if( 200 <= statusCode && statusCode < 300 ) {
        NSDictionary *header = [_response allHeaderFields];
        NSNumber *contentLengthNum = [header objectForKey:@"Content-Length"];
        if( [contentLengthNum respondsToSelector:@selector( longLongValue )] ) {
            contentLength = [contentLengthNum longLongValue];
        }
        contentType = [header objectForKey:@"Content-Type"];
    }

    if( contentLength ) {
        if( [_delegate respondsToSelector:@selector( imageSizeCheckClient:didReceiveContentLength:andType: )] ) {
            [_delegate imageSizeCheckClient:self didReceiveContentLength:contentLength andType:contentType];
        }
    }
    else {
        if( [_delegate respondsToSelector:@selector( imageSizeCheckClient:didFailWithError:statusCode: )] ) {
            [_delegate imageSizeCheckClient:self didFailWithError:nil statusCode:statusCode];
        }
    }
}

- (void)connection:(NSURLConnection *)sender didFailWithError:(NSError *)error
{
    if( _conn != sender ) return;

    [self cancel];

    if( [_delegate respondsToSelector:@selector( imageSizeCheckClient:didFailWithError:statusCode: )] ) {
        [_delegate imageSizeCheckClient:self didFailWithError:error statusCode:0];
    }
}

@end
