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

#import <Foundation/Foundation.h>

typedef enum {
    DCC_INIT,
    DCC_ERROR,
    DCC_STOP,
    DCC_CONNECTING,
    DCC_LISTENING,
    DCC_RECEIVING,
    DCC_SENDING,
    DCC_COMPLETE,
} DCCFileTransferStatus;

@interface DCCFileTransferCell : NSCell

@property ( nonatomic ) NSString *peerNick;
@property ( nonatomic ) long long processedSize;
@property ( nonatomic ) long long size;
@property ( nonatomic ) long long speed;
@property ( nonatomic ) long long timeRemaining;
@property ( nonatomic ) DCCFileTransferStatus status;
@property ( nonatomic ) NSString *error;
@property ( nonatomic ) NSProgressIndicator *progressBar;
@property ( nonatomic ) NSImage *icon;
@property ( nonatomic ) BOOL sendingItem;

@end
