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
#import <Foundation/Foundation.h>

@interface TCPServer : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic, readonly ) NSArray *clients;
@property ( nonatomic, readonly ) BOOL isActive;
@property ( nonatomic ) int port;

- (BOOL)open;
- (void)close;

- (void)closeClient:(TCPClient *)client;
- (void)closeAllClients;

@end

@interface NSObject ( TCPServerDelegate )
- (void)tcpServer:(TCPServer *)sender didAccept:(TCPClient *)client;
- (void)tcpServer:(TCPServer *)sender didConnect:(TCPClient *)client;
- (void)tcpServer:(TCPServer *)sender client:(TCPClient *)client error:(NSString *)error;
- (void)tcpServer:(TCPServer *)sender didDisconnect:(TCPClient *)client;
- (void)tcpServer:(TCPServer *)sender didReceiveData:(TCPClient *)client;
- (void)tcpServer:(TCPServer *)sender didSendData:(TCPClient *)client;
@end
