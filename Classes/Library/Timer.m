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

#import "Timer.h"

@implementation Timer {
    NSTimer *_timer;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _reqeat = YES;
        _selector = @selector( timerOnTimer: );
    }
    return self;
}

- (BOOL)isActive
{
    return _timer != nil;
}

- (void)start:(NSTimeInterval)interval
{
    [self stop];

    _timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector( onTimer: ) userInfo:nil repeats:_reqeat];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSEventTrackingRunLoopMode];
}

- (void)stop
{
    [_timer invalidate];
    _timer = nil;
}

- (void)onTimer:(id)sender
{
    if( !self.isActive ) return;

    if( !_reqeat ) {
        [self stop];
    }

    if( [_delegate respondsToSelector:_selector] ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_delegate performSelector:_selector
                        withObject:self];
#pragma clang diagnostic pop
    }
}

@end
