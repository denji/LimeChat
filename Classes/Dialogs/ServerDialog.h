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

#import "ChannelDialog.h"
#import "IRCClientConfig.h"
#import "IgnoreItemSheet.h"
#import "ListView.h"
#import <Foundation/Foundation.h>

@interface ServerDialog : NSWindowController

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic, weak ) NSWindow *parentWindow;
@property ( nonatomic ) int uid;
@property ( nonatomic ) IRCClientConfig *config;

@property ( nonatomic ) IBOutlet NSTabView *tab;

@property ( nonatomic ) IBOutlet NSTextField *nameText;
@property ( nonatomic ) IBOutlet NSButton *autoConnectCheck;

@property ( nonatomic ) IBOutlet NSComboBox *hostCombo;
@property ( nonatomic ) IBOutlet NSButton *sslCheck;
@property ( nonatomic ) IBOutlet NSTextField *portText;

@property ( nonatomic ) IBOutlet NSTextField *nickText;
@property ( nonatomic ) IBOutlet NSTextField *passwordText;
@property ( nonatomic ) IBOutlet NSTextField *usernameText;
@property ( nonatomic ) IBOutlet NSTextField *realNameText;
@property ( nonatomic ) IBOutlet NSTextField *nickPasswordText;
@property ( nonatomic ) IBOutlet NSButton *saslCheck;
@property ( nonatomic ) IBOutlet NSTextField *altNicksText;

@property ( nonatomic ) IBOutlet NSTextField *leavingCommentText;
@property ( nonatomic ) IBOutlet NSTextField *userInfoText;

@property ( nonatomic ) IBOutlet NSPopUpButton *encodingCombo;
@property ( nonatomic ) IBOutlet NSPopUpButton *fallbackEncodingCombo;

@property ( nonatomic ) IBOutlet NSPopUpButton *proxyCombo;
@property ( nonatomic ) IBOutlet NSTextField *proxyHostText;
@property ( nonatomic ) IBOutlet NSTextField *proxyPortText;
@property ( nonatomic ) IBOutlet NSTextField *proxyUserText;
@property ( nonatomic ) IBOutlet NSTextField *proxyPasswordText;

@property ( nonatomic ) IBOutlet ListView *channelTable;
@property ( nonatomic ) IBOutlet NSButton *addChannelButton;
@property ( nonatomic ) IBOutlet NSButton *editChannelButton;
@property ( nonatomic ) IBOutlet NSButton *deleteChannelButton;

@property ( nonatomic ) IBOutlet NSTextView *loginCommandsText;
@property ( nonatomic ) IBOutlet NSButton *invisibleCheck;

@property ( nonatomic ) IBOutlet ListView *ignoreTable;
@property ( nonatomic ) IBOutlet NSButton *addIgnoreButton;
@property ( nonatomic ) IBOutlet NSButton *editIgnoreButton;
@property ( nonatomic ) IBOutlet NSButton *deleteIgnoreButton;

@property ( nonatomic ) IBOutlet NSButton *okButton;

- (void)startWithIgnoreTab:(BOOL)ignoreTab;
- (void)show;
- (void)close;

- (void)ok:(id)sender;
- (void)cancel:(id)sender;

- (void)hostComboChanged:(id)sender;

- (void)encodingChanged:(id)sender;
- (void)proxyChanged:(id)sender;

- (void)addChannel:(id)sender;
- (void)editChannel:(id)sender;
- (void)deleteChannel:(id)sender;

- (void)addIgnore:(id)sender;
- (void)editIgnore:(id)sender;
- (void)deleteIgnore:(id)sender;

+ (NSArray *)availableServers;

@end

@interface NSObject ( ServerDialogDelegate )
- (void)serverDialogOnOK:(ServerDialog *)sender;
- (void)serverDialogWillClose:(ServerDialog *)sender;
@end
