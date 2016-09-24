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

#import "IRCPrefix.h"

@implementation IRCPrefix

- (id)init
{
    self = [super init];
    if( self ) {
        _raw = @"";
        _nick = @"";
        _user = @"";
        _address = @"";
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.raw forKey:@"raw"];
    [aCoder encodeObject:self.nick forKey:@"nick"];
    [aCoder encodeObject:self.user forKey:@"user"];
    [aCoder encodeObject:self.address forKey:@"address"];
    [aCoder encodeObject:@( self.isServer ) forKey:@"isServer"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if( self ) {
        self.raw = [aDecoder decodeObjectForKey:@"raw"];
        self.nick = [aDecoder decodeObjectForKey:@"nick"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
        self.address = [aDecoder decodeObjectForKey:@"address"];
        self.isServer = [[aDecoder decodeObjectForKey:@"isServer"] boolValue];
    }
    return self;
}
@end
