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

#import "ChannelDialog.h"
#import "FileLogger.h"
#import "IRCChannelConfig.h"
#import "IRCChannelMode.h"
#import "IRCTreeItem.h"
#import "IRCUser.h"
#import "LogController.h"
#import <Cocoa/Cocoa.h>

@class IRCClient;

@interface IRCChannel : IRCTreeItem

@property ( nonatomic, weak ) IRCClient *client;
@property ( nonatomic, readonly ) IRCChannelConfig *config;
@property ( nonatomic ) NSString *name;
@property ( nonatomic, readonly ) NSString *password;
@property ( nonatomic, readonly ) IRCChannelMode *mode;
@property ( nonatomic, readonly ) NSMutableArray *members;
@property ( nonatomic, readonly ) NSString *channelTypeString;
@property ( nonatomic ) NSString *topic;
@property ( nonatomic ) NSString *storedTopic;
@property ( nonatomic ) BOOL isActive;
@property ( nonatomic ) BOOL isOp;
@property ( nonatomic ) BOOL isModeInit;
@property ( nonatomic ) BOOL isNamesInit;
@property ( nonatomic ) BOOL isWhoInit;
@property ( nonatomic, readonly ) BOOL isChannel;
@property ( nonatomic, readonly ) BOOL isTalk;

@property ( nonatomic ) ChannelDialog *propertyDialog;

- (void)setup:(IRCChannelConfig *)seed;
- (void)updateConfig:(IRCChannelConfig *)seed;
- (void)updateAutoOp:(IRCChannelConfig *)seed;
- (NSMutableDictionary *)dictionaryValue;

- (void)terminate;
- (void)closeDialogs;
- (void)preferencesChanged;

- (void)activate;
- (void)deactivate;

- (BOOL)print:(LogLine *)line;

- (void)addMember:(IRCUser *)user;
- (void)addMember:(IRCUser *)user reload:(BOOL)reload;
- (void)removeMember:(NSString *)nick;
- (void)removeMember:(NSString *)nick reload:(BOOL)reload;
- (void)renameMember:(NSString *)fromNick to:(NSString *)toNick;
- (void)updateOrAddMember:(IRCUser *)user;
- (void)changeMember:(NSString *)nick mode:(char)mode value:(BOOL)value;
- (void)clearMembers;
- (int)indexOfMember:(NSString *)nick;
- (IRCUser *)memberAtIndex:(int)index;
- (IRCUser *)findMember:(NSString *)nick;
- (int)numberOfMembers;
- (void)reloadMemberList;

@end
