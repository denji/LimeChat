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

#import "IRCUserMode.h"

@implementation IRCUserMode

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

- (void)clear
{
    _a = _i = _r = _s = _w = _o = _O = NO;
}

- (void)update:(NSString *)str
{
    int len = str.length;
    BOOL plus = NO;

    for( int index = 0; index < len; ++index ) {
        UniChar uc = [str characterAtIndex:index];
        switch( uc ) {
        case '+':
            plus = YES;
            break;
        case '-':
            plus = NO;
            break;
        case 'a':
            _a = plus;
            break;
        case 'i':
            _i = plus;
            break;
        case 'r':
            _r = plus;
            break;
        case 's':
            _s = plus;
            break;
        case 'w':
            _w = plus;
            break;
        case 'o':
            _o = plus;
            break;
        case 'O':
            _O = plus;
            break;
        }
    }
}

- (NSString *)string
{
    NSMutableString *str = [NSMutableString string];

    if( _a ) [str appendString:@"a"];
    if( _i ) [str appendString:@"i"];
    if( _r ) [str appendString:@"r"];
    if( _s ) [str appendString:@"s"];
    if( _w ) [str appendString:@"w"];
    if( _o ) [str appendString:@"o"];
    if( _O ) [str appendString:@"O"];

    if( str.length ) [str insertString:@"+" atIndex:0];
    return str;
}

@end
