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

#import "LogScriptEventSink.h"
#import "GTMNSString+HTML.h"
#import "LogController.h"
#import "LogPolicy.h"

#define DOUBLE_CLICK_RADIUS 3

@implementation LogScriptEventSink {
    int _x;
    int _y;
    CFAbsoluteTime _lastClickTime;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _x = -10000;
        _y = -10000;
    }
    return self;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel
{
    if( sel == @selector( onDblClick: )
        || sel == @selector( shouldStopDoubleClick: )
        || sel == @selector( setUrl: )
        || sel == @selector( setAddr: )
        || sel == @selector( setNick: )
        || sel == @selector( setChan: )
        || sel == @selector( print: ) ) {
        return NO;
    }
    return YES;
}

+ (NSString *)webScriptNameForSelector:(SEL)sel
{
    NSString *s = NSStringFromSelector( sel );
    if( [s hasSuffix:@":"] ) {
        return [s substringToIndex:s.length - 1];
    }
    return nil;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char *)name
{
    return YES;
}

+ (NSString *)webScriptNameForKey:(const char *)name
{
    return nil;
}

- (void)onDblClick:(id)e
{
    [_owner logViewOnDoubleClick:e];
}

- (BOOL)shouldStopDoubleClick:(id)e
{
    int d = DOUBLE_CLICK_RADIUS;
    int cx = [[e valueForKey:@"clientX"] intValue];
    int cy = [[e valueForKey:@"clientY"] intValue];

    BOOL res = NO;
    CFAbsoluteTime doubleClickThreshold = [NSEvent doubleClickInterval];
    CFAbsoluteTime now = CFAbsoluteTimeGetCurrent();
    if( _x - d <= cx && cx <= _x + d && _y - d <= cy && cy <= _y + d ) {
        if( now < _lastClickTime + doubleClickThreshold ) {
            res = YES;
        }
    }

    _lastClickTime = now;
    _x = cx;
    _y = cy;

    return res;
}

- (void)setUrl:(NSString *)s
{
    [_policy setUrl:[s gtm_stringByUnescapingFromHTML]];
}

- (void)setAddr:(NSString *)s
{
    [_policy setAddr:[s gtm_stringByUnescapingFromHTML]];
}

- (void)setNick:(NSString *)s
{
    [_policy setNick:[s gtm_stringByUnescapingFromHTML]];
}

- (void)setChan:(NSString *)s
{
    [_policy setChan:[s gtm_stringByUnescapingFromHTML]];
}

- (void)print:(NSString *)s
{
    NSLog( @"%@", s );
}

@end
