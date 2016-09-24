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

#import "HostResolver.h"

@implementation HostResolver

- (id)initWithDelegate:(id)aDelegate
{
    self = [super init];
    if( self ) {
        _delegate = aDelegate;
    }
    return self;
}

- (void)resolve:(NSString *)hostname
{
    if( hostname.length ) {
        [NSThread detachNewThreadSelector:@selector( resolveInternal: ) toTarget:self withObject:hostname];
    }
}

- (void)resolveInternal:(NSString *)hostname
{
    @autoreleasepool {
        NSHost *host = [NSHost hostWithName:hostname];
        NSArray *info = [NSArray arrayWithObjects:hostname, host, nil];
        [self performSelectorOnMainThread:@selector( hostResolved: ) withObject:info waitUntilDone:YES];
    }
}

- (void)hostResolved:(NSArray *)info
{
    if( !_delegate ) return;

    if( [info count] == 2 ) {
        NSHost *host = [info objectAtIndex:1];
        if( [_delegate respondsToSelector:@selector( hostResolver:didResolve: )] ) {
            [_delegate hostResolver:self didResolve:host];
        }
    }
    else {
        NSString *hostname = [info objectAtIndex:0];
        if( [_delegate respondsToSelector:@selector( hostResolver:didNotResolve: )] ) {
            [_delegate hostResolver:self didNotResolve:hostname];
        }
    }
}

@end
