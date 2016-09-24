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

#import "LogTheme.h"

@implementation LogTheme

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

- (void)setFileName:(NSString *)value
{
    if( _fileName != value ) {
        _fileName = value;
        _baseUrl = nil;

        if( _fileName ) {
            _baseUrl = [NSURL fileURLWithPath:[_fileName stringByDeletingLastPathComponent]];
        }
    }

    [self reload];
}

- (void)reload
{
    _content = nil;

    if( _fileName ) {
        _content = [NSString stringWithContentsOfFile:_fileName encoding:NSUTF8StringEncoding error:NULL];
    }
}

@end
