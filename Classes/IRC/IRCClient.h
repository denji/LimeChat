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

#import "HostResolver.h"
#import "IRCChannel.h"
#import "IRCClientConfig.h"
#import "IRCConnection.h"
#import "IRCISupportInfo.h"
#import "IRCMessage.h"
#import "IRCTreeItem.h"
#import "IRCUserMode.h"
#import "ListDialog.h"
#import "LogController.h"
#import "Preferences.h"
#import "ServerDialog.h"
#import "Timer.h"
#import <Cocoa/Cocoa.h>

@class IRCWorld;

typedef enum {
    CONNECT_NORMAL,
    CONNECT_RECONNECT,
    CONNECT_RETRY,
} ConnectMode;

@interface IRCClient : IRCTreeItem

@property ( nonatomic, weak ) IRCWorld *world;
@property ( nonatomic, readonly ) NSString *name;
@property ( nonatomic, readonly ) IRCClientConfig *config;
@property ( nonatomic, readonly ) IRCISupportInfo *isupport;
@property ( nonatomic, readonly ) IRCUserMode *myMode;
@property ( nonatomic, readonly ) NSMutableArray *channels;
@property ( nonatomic, readonly ) BOOL isConnecting;
@property ( nonatomic, readonly ) BOOL isConnected;
@property ( nonatomic, readonly ) BOOL isReconnecting;
@property ( nonatomic, readonly ) BOOL isLoggedIn;
@property ( nonatomic, readonly ) NSString *myNick;
@property ( nonatomic, readonly ) NSString *myAddress;
@property ( nonatomic ) IRCChannel *lastSelectedChannel;
@property ( nonatomic ) ServerDialog *propertyDialog;

- (void)setup:(IRCClientConfig *)seed;
- (void)updateConfig:(IRCClientConfig *)seed;
- (IRCClientConfig *)storedConfig;
- (NSMutableDictionary *)dictionaryValue;

- (void)autoConnect:(int)delay;
- (void)onTimer;
- (void)terminate;
- (void)closeDialogs;
- (void)preferencesChanged;

- (void)connect;
- (void)connect:(ConnectMode)mode;
- (void)disconnect;
- (void)quit;
- (void)quit:(NSString *)comment;
- (void)cancelReconnect;

- (void)changeNick:(NSString *)newNick;
- (void)joinChannel:(IRCChannel *)channel;
- (void)joinChannel:(IRCChannel *)channel password:(NSString *)password;
- (void)partChannel:(IRCChannel *)channel;
- (void)sendWhois:(NSString *)nick;
- (void)changeOp:(IRCChannel *)channel users:(NSArray *)users mode:(char)mode value:(BOOL)value;
- (void)kick:(IRCChannel *)channel target:(NSString *)nick;
- (void)sendFile:(NSString *)nick port:(int)port fileName:(NSString *)fileName size:(long long)size;
- (void)sendCTCPQuery:(NSString *)target command:(NSString *)command text:(NSString *)text;
- (void)sendCTCPReply:(NSString *)target command:(NSString *)command text:(NSString *)text;
- (void)sendCTCPPing:(NSString *)target;

- (BOOL)inputText:(NSString *)s command:(NSString *)command;
- (void)sendText:(NSString *)s command:(NSString *)command channel:(IRCChannel *)channel;
- (void)sendJoinAndSelect:(NSString *)channelName;
- (BOOL)sendCommand:(NSString *)s;
- (BOOL)sendCommand:(NSString *)s completeTarget:(BOOL)completeTarget target:(NSString *)target;

- (void)sendLine:(NSString *)str;
- (void)send:(NSString *)str, ...;

- (IRCChannel *)findChannel:(NSString *)name;
- (int)indexOfTalkChannel;

- (void)createChannelListDialog;

//Make the function public, so that it can be called from IRCChannel
- (void)receivePrivmsgAndNotice:(IRCMessage *)m;

@end
