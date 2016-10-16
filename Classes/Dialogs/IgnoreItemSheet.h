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

#import "IgnoreItem.h"
#import "ListView.h"
#import "SheetBase.h"
#import <LimeChat-Swift.h>
#import <Foundation/Foundation.h>

@interface IgnoreItemSheet : SheetBase

@property ( nonatomic ) IgnoreItem *ignore;
@property ( nonatomic ) BOOL newItem;

@property ( nonatomic ) IBOutlet NSButton *nickCheck;
@property ( nonatomic ) IBOutlet NSPopUpButton *nickPopup;
@property ( nonatomic ) IBOutlet NSTextField *nickText;
@property ( nonatomic ) IBOutlet NSButton *messageCheck;
@property ( nonatomic ) IBOutlet NSPopUpButton *messagePopup;
@property ( nonatomic ) IBOutlet NSTextField *messageText;
@property ( nonatomic ) IBOutlet ListView *channelTable;
@property ( nonatomic ) IBOutlet NSButton *deleteChannelButton;

- (void)start;

- (void)addChannel:(id)sender;
- (void)deleteChannel:(id)sender;

@end

@interface NSObject ( IgnoreItemSheetDelegate )
- (void)ignoreItemSheetOnOK:(IgnoreItemSheet *)sender;
- (void)ignoreItemSheetWillClose:(IgnoreItemSheet *)sender;
@end
