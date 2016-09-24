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

@interface IRCUser : NSObject

@property ( nonatomic ) NSString *nick;
@property ( nonatomic, readonly ) NSString *canonicalNick;
@property ( nonatomic ) NSString *username;
@property ( nonatomic ) NSString *address;
@property ( nonatomic ) BOOL q;
@property ( nonatomic ) BOOL a;
@property ( nonatomic ) BOOL o;
@property ( nonatomic ) BOOL h;
@property ( nonatomic ) BOOL v;
@property ( nonatomic ) BOOL isMyself;
@property ( nonatomic, readonly ) char mark;
@property ( nonatomic, readonly ) BOOL isOp;
@property ( nonatomic, readonly ) int colorNumber;
@property ( nonatomic, readonly ) CGFloat weight;
@property ( nonatomic, readonly ) CGFloat incomingWeight;
@property ( nonatomic, readonly ) CGFloat outgoingWeight;
@property ( nonatomic ) IRCISupportInfo *isupport;

- (BOOL)hasMode:(char)mode;

- (void)outgoingConversation;
- (void)incomingConversation;
- (void)conversation;

- (NSComparisonResult)compare:(IRCUser *)other;
- (NSComparisonResult)compareUsingWeights:(IRCUser *)other;

@end
