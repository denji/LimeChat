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

#import "IRCChannelMode.h"
#import "SheetBase.h"
#import <Foundation/Foundation.h>

@interface ModeSheet : SheetBase

@property ( nonatomic ) IRCChannelMode *mode;
@property ( nonatomic ) NSString *channelName;
@property ( nonatomic ) int uid;
@property ( nonatomic ) int cid;

@property ( nonatomic ) IBOutlet NSButton *sCheck;
@property ( nonatomic ) IBOutlet NSButton *pCheck;
@property ( nonatomic ) IBOutlet NSButton *nCheck;
@property ( nonatomic ) IBOutlet NSButton *tCheck;
@property ( nonatomic ) IBOutlet NSButton *iCheck;
@property ( nonatomic ) IBOutlet NSButton *mCheck;
@property ( nonatomic ) IBOutlet NSButton *aCheck;
@property ( nonatomic ) IBOutlet NSButton *rCheck;
@property ( nonatomic ) IBOutlet NSButton *kCheck;
@property ( nonatomic ) IBOutlet NSButton *lCheck;
@property ( nonatomic ) IBOutlet NSTextField *kText;
@property ( nonatomic ) IBOutlet NSTextField *lText;

- (void)start;

- (void)onChangeCheck:(id)sender;

@end

@interface NSObject ( ModeSheetDelegate )
- (void)modeSheetOnOK:(ModeSheet *)sender;
- (void)modeSheetWillClose:(ModeSheet *)sender;
@end
