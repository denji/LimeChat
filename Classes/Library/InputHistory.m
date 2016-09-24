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

#import "InputHistory.h"

#define INPUT_HISTORY_MAX 50

@implementation InputHistory {
    NSMutableArray *_buf;
    int _pos;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _buf = [NSMutableArray new];
    }
    return self;
}

- (void)add:(NSString *)s
{
    _pos = _buf.count;
    if( s.length == 0 ) return;
    if( [[_buf lastObject] isEqualToString:s] ) return;

    [_buf addObject:s];

    if( _buf.count > INPUT_HISTORY_MAX ) {
        [_buf removeObjectAtIndex:0];
    }
    _pos = _buf.count;
}

- (NSString *)up:(NSString *)s
{
    if( s && s.length > 0 ) {
        NSString *cur = nil;
        if( 0 <= _pos && _pos < _buf.count ) {
            cur = [_buf objectAtIndex:_pos];
        }

        if( !cur || ![cur isEqualToString:s] ) {
            // if the text was modified, add it
            [_buf addObject:s];
            if( _buf.count > INPUT_HISTORY_MAX ) {
                [_buf removeObjectAtIndex:0];
                --_pos;
            }
        }
    }

    --_pos;
    if( _pos < 0 ) {
        _pos = 0;
        return nil;
    }
    else if( 0 <= _pos && _pos < _buf.count ) {
        return [_buf objectAtIndex:_pos];
    }
    else {
        return @"";
    }
}

- (NSString *)down:(NSString *)s
{
    if( !s || s.length == 0 ) {
        _pos = _buf.count;
        return nil;
    }

    NSString *cur = nil;
    if( 0 <= _pos && _pos < _buf.count ) {
        cur = [_buf objectAtIndex:_pos];
    }

    if( !cur || ![cur isEqualToString:s] ) {
        // if the text was modified, add it
        [self add:s];
        return @"";
    }
    else {
        ++_pos;
        if( 0 <= _pos && _pos < _buf.count ) {
            return [_buf objectAtIndex:_pos];
        }
        return @"";
    }
}

@end
