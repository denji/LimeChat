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

#import "TCPServer.h"
#import "AsyncSocket.h"

@implementation TCPServer {
    AsyncSocket *_conn;
    NSMutableArray *_clients;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _clients = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc
{
    [_conn disconnect];
}

- (BOOL)open
{
    if( _conn ) {
        [self close];
    }

    _conn = [[AsyncSocket alloc] initWithDelegate:self];
    _isActive = [_conn acceptOnPort:_port error:NULL];
    if( !_isActive ) {
        [self close];
    }
    return _isActive;
}

- (void)close
{
    [_conn disconnect];
    _conn = nil;
    _isActive = NO;
}

- (void)closeClient:(TCPClient *)client
{
    [client close];
    [_clients removeObjectIdenticalTo:client];
}

- (void)closeAllClients
{
    for( TCPClient *c in _clients ) {
        [c close];
    }
    [_clients removeAllObjects];
}

- (void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket
{
    TCPClient *c = [[TCPClient alloc] initWithExistingConnection:newSocket];
    c.delegate = self;
    [_clients addObject:c];

    if( [_delegate respondsToSelector:@selector( tcpServer:didAccept: )] ) {
        [_delegate tcpServer:self didAccept:c];
    }
}

- (void)tcpClientDidConnect:(TCPClient *)sender
{
    if( [_delegate respondsToSelector:@selector( tcpServer:didConnect: )] ) {
        [_delegate tcpServer:self didConnect:sender];
    }
}

- (void)tcpClientDidDisconnect:(TCPClient *)sender
{
    if( [_delegate respondsToSelector:@selector( tcpServer:didDisconnect: )] ) {
        [_delegate tcpServer:self didDisconnect:sender];
    }
    [self closeClient:sender];
}

- (void)tcpClient:(TCPClient *)sender error:(NSString *)error
{
    if( [_delegate respondsToSelector:@selector( tcpServer:client:error: )] ) {
        [_delegate tcpServer:self client:sender error:error];
    }
}

- (void)tcpClientDidReceiveData:(TCPClient *)sender
{
    if( [_delegate respondsToSelector:@selector( tcpServer:didReceiveData: )] ) {
        [_delegate tcpServer:self didReceiveData:sender];
    }
}

- (void)tcpClientDidSendData:(TCPClient *)sender
{
    if( [_delegate respondsToSelector:@selector( tcpServer:didSendData: )] ) {
        [_delegate tcpServer:self didSendData:sender];
    }
}

@end
