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

#import "IRCISupportInfo.h"
#import <Foundation/Foundation.h>

@interface IRCChannelMode : NSObject <NSMutableCopying>

@property ( nonatomic ) IRCISupportInfo *isupport;
@property ( nonatomic ) BOOL a;
@property ( nonatomic ) BOOL i;
@property ( nonatomic ) BOOL m;
@property ( nonatomic ) BOOL n;
@property ( nonatomic ) BOOL p;
@property ( nonatomic ) BOOL q;
@property ( nonatomic ) BOOL r;
@property ( nonatomic ) BOOL s;
@property ( nonatomic ) BOOL t;
@property ( nonatomic ) int l;
@property ( nonatomic ) NSString *k;

- (void)clear;
- (NSArray *)update:(NSString *)str;

- (NSString *)getChangeCommand:(IRCChannelMode *)mode;

- (NSString *)string;
- (NSString *)titleString;

@end
