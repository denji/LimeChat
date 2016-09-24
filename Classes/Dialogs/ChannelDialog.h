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

#import "IRCChannelConfig.h"
#import <Foundation/Foundation.h>

@interface ChannelDialog : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic, weak ) NSWindow *parentWindow;
@property ( nonatomic ) int uid;
@property ( nonatomic ) int cid;
@property ( nonatomic ) IRCChannelConfig *config;

@property ( nonatomic ) IBOutlet NSWindow *window;
@property ( nonatomic ) IBOutlet NSTextField *nameText;
@property ( nonatomic ) IBOutlet NSTextField *passwordText;
@property ( nonatomic ) IBOutlet NSTextField *modeText;
@property ( nonatomic ) IBOutlet NSTextField *topicText;
@property ( nonatomic ) IBOutlet NSButton *autoJoinCheck;
@property ( nonatomic ) IBOutlet NSButton *consoleCheck;
@property ( nonatomic ) IBOutlet NSButton *notifyCheck;
@property ( nonatomic ) IBOutlet NSButton *okButton;

- (void)start;
- (void)startSheet;
- (void)show;
- (void)close;

- (void)ok:(id)sender;
- (void)cancel:(id)sender;

@end

@interface NSObject ( ChannelDialogDelegate )
- (void)channelDialogOnOK:(ChannelDialog *)sender;
- (void)channelDialogWillClose:(ChannelDialog *)sender;
@end
