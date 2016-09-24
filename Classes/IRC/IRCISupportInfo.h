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

#import <Foundation/Foundation.h>

#define MODES_SIZE 52
#define INVALID_MODE_CHAR ' '
#define INVALID_MARK_CHAR ' '

@interface IRCISupportInfo : NSObject

@property ( nonatomic, readonly ) int nickLen;
@property ( nonatomic, readonly ) int modesCount;
@property ( nonatomic, readonly ) NSMutableDictionary *markMap;
@property ( nonatomic, readonly ) NSMutableDictionary *modeMap;

- (void)reset;
- (void)update:(NSString *)s;
- (NSArray *)parseMode:(NSString *)s;
- (char)modeForMark:(char)mark;
- (char)markForMode:(char)mode;

@end

@interface IRCModeInfo : NSObject

@property ( nonatomic ) unsigned char mode;
@property ( nonatomic ) BOOL plus;
@property ( nonatomic ) BOOL op;
@property ( nonatomic ) BOOL simpleMode;
@property ( nonatomic ) NSString *param;

+ (IRCModeInfo *)modeInfo;

@end
