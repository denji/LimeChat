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

#import "DCCFileTransferCell.h"
#import "TCPServer.h"
#import <Foundation/Foundation.h>

@interface DCCSender : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) int uid;
@property ( nonatomic ) NSString *peerNick;
@property ( nonatomic, readonly ) int port;
@property ( nonatomic, readonly ) NSString *fileName;
@property ( nonatomic ) NSString *fullFileName;
@property ( nonatomic, readonly ) long long size;
@property ( nonatomic, readonly ) long long processedSize;
@property ( nonatomic, readonly ) DCCFileTransferStatus status;
@property ( nonatomic, readonly ) NSString *error;
@property ( nonatomic, readonly ) NSImage *icon;
@property ( nonatomic ) NSProgressIndicator *progressBar;
@property ( nonatomic, readonly ) double speed;

- (BOOL)open;
- (void)close;
- (void)onTimer;
- (void)setAddressError;

@end

@interface NSObject ( DCCSenderDelegate )
- (void)dccSenderOnListen:(DCCSender *)sender;
- (void)dccSenderOnConnect:(DCCSender *)sender;
- (void)dccSenderOnClose:(DCCSender *)sender;
- (void)dccSenderOnError:(DCCSender *)sender;
- (void)dccSenderOnComplete:(DCCSender *)sender;
@end
