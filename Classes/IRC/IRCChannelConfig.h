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

#import <Cocoa/Cocoa.h>

typedef enum {
    CHANNEL_TYPE_CHANNEL,
    CHANNEL_TYPE_TALK,
} ChannelType;

@interface IRCChannelConfig : NSObject <NSMutableCopying>

@property ( nonatomic ) ChannelType type;

@property ( nonatomic ) NSString *name;
@property ( nonatomic ) NSString *password;

@property ( nonatomic ) BOOL autoJoin;
@property ( nonatomic ) BOOL logToConsole;
@property ( nonatomic ) BOOL notify;

@property ( nonatomic ) NSString *mode;
@property ( nonatomic ) NSString *topic;

@property ( nonatomic, readonly ) NSMutableArray *autoOp;

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSMutableDictionary *)dictionaryValueSavingToKeychain:(BOOL)saveToKeychain;

- (void)deletePasswordsFromKeychain;

@end
