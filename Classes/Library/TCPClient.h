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

#import "AsyncSocket.h"
#import <Cocoa/Cocoa.h>

@interface TCPClient : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) NSString *host;
@property ( nonatomic ) int port;
@property ( nonatomic ) BOOL useSSL;

@property ( nonatomic ) BOOL useSystemSocks;
@property ( nonatomic ) BOOL useSocks;
@property ( nonatomic ) int socksVersion;
@property ( nonatomic ) NSString *proxyHost;
@property ( nonatomic ) int proxyPort;
@property ( nonatomic ) NSString *proxyUser;
@property ( nonatomic ) NSString *proxyPassword;
@property ( nonatomic, readonly ) int sendQueueSize;

@property ( nonatomic, readonly ) BOOL active;
@property ( nonatomic, readonly ) BOOL connecting;
@property ( nonatomic, readonly ) BOOL connected;

- (id)initWithExistingConnection:(AsyncSocket *)socket;

- (void)open;
- (void)close;

- (NSData *)read;
- (NSData *)readLine;
- (void)write:(NSData *)data;

@end

@interface NSObject ( TCPClientDelegate )
- (void)tcpClientDidConnect:(TCPClient *)sender;
- (void)tcpClientDidDisconnect:(TCPClient *)sender;
- (void)tcpClient:(TCPClient *)sender error:(NSString *)error;
- (void)tcpClientDidReceiveData:(TCPClient *)sender;
- (void)tcpClientDidSendData:(TCPClient *)sender;
@end
