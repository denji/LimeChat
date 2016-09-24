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

#import "TCPClient.h"
#import "Timer.h"
#import <Cocoa/Cocoa.h>

@interface IRCConnection : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) NSString *host;
@property ( nonatomic ) int port;
@property ( nonatomic ) BOOL useSSL;
@property ( nonatomic ) NSStringEncoding encoding;

@property ( nonatomic ) BOOL useSystemSocks;
@property ( nonatomic ) BOOL useSocks;
@property ( nonatomic ) int socksVersion;
@property ( nonatomic ) NSString *proxyHost;
@property ( nonatomic ) int proxyPort;
@property ( nonatomic ) NSString *proxyUser;
@property ( nonatomic ) NSString *proxyPassword;

@property ( nonatomic, readonly ) BOOL active;
@property ( nonatomic, readonly ) BOOL connecting;
@property ( nonatomic, readonly ) BOOL connected;
@property ( nonatomic, readonly ) BOOL readyToSend;
@property ( nonatomic ) BOOL loggedIn;

- (void)open;
- (void)close;
- (void)clearSendQueue;
- (void)sendLine:(NSString *)line;

- (NSData *)convertToCommonEncoding:(NSString *)s;

@end

@interface NSObject ( IRCConnectionDelegate )
- (void)ircConnectionDidConnect:(IRCConnection *)sender;
- (void)ircConnectionDidDisconnect:(IRCConnection *)sender;
- (void)ircConnectionDidError:(NSString *)error;
- (void)ircConnectionDidReceive:(NSData *)data;
- (void)ircConnectionWillSend:(NSString *)line;
@end
