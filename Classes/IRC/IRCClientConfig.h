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
    PROXY_NONE = 0,
    PROXY_SOCKS_SYSTEM = 1,
    PROXY_SOCKS4 = 4,
    PROXY_SOCKS5 = 5,
} ProxyType;

@interface IRCClientConfig : NSObject <NSMutableCopying>

@property ( nonatomic ) NSString *name;

@property ( nonatomic ) NSString *host;
@property ( nonatomic ) int port;
@property ( nonatomic ) BOOL useSSL;

@property ( nonatomic ) NSString *nick;
@property ( nonatomic ) NSString *password;
@property ( nonatomic ) NSString *username;
@property ( nonatomic ) NSString *realName;
@property ( nonatomic ) NSString *nickPassword;
@property ( nonatomic ) BOOL useSASL;
@property ( nonatomic, readonly ) NSMutableArray *altNicks;

@property ( nonatomic ) ProxyType proxyType;
@property ( nonatomic ) NSString *proxyHost;
@property ( nonatomic ) int proxyPort;
@property ( nonatomic ) NSString *proxyUser;
@property ( nonatomic ) NSString *proxyPassword;

@property ( nonatomic ) BOOL autoConnect;
@property ( nonatomic ) NSStringEncoding encoding;
@property ( nonatomic ) NSStringEncoding fallbackEncoding;
@property ( nonatomic ) NSString *leavingComment;
@property ( nonatomic ) NSString *userInfo;
@property ( nonatomic ) BOOL invisibleMode;
@property ( nonatomic, readonly ) NSMutableArray *loginCommands;
@property ( nonatomic, readonly ) NSMutableArray *channels;
@property ( nonatomic, readonly ) NSMutableArray *autoOp;
@property ( nonatomic, readonly ) NSMutableArray *ignores;

@property ( nonatomic ) int uid;

- (id)initWithDictionary:(NSDictionary *)dic;
- (NSMutableDictionary *)dictionaryValueSavingToKeychain:(BOOL)saveToKeychain includingChildren:(BOOL)includingChildren;

- (void)deletePasswordsFromKeychain;

@end
