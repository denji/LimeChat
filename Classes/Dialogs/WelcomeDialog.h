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

#import "ListView.h"
#import <Foundation/Foundation.h>

@interface WelcomeDialog : NSWindowController

@property ( nonatomic, weak ) id delegate;

@property ( nonatomic ) IBOutlet NSTextField *nickText;
@property ( nonatomic ) IBOutlet NSComboBox *hostCombo;
@property ( nonatomic ) IBOutlet ListView *channelTable;
@property ( nonatomic ) IBOutlet NSButton *autoConnectCheck;
@property ( nonatomic ) IBOutlet NSButton *addChannelButton;
@property ( nonatomic ) IBOutlet NSButton *deleteChannelButton;
@property ( nonatomic ) IBOutlet NSButton *okButton;

- (void)show;
- (void)close;

- (void)onOK:(id)sender;
- (void)onCancel:(id)sender;
- (void)onAddChannel:(id)sender;
- (void)onDeleteChannel:(id)sender;

- (void)onHostComboChanged:(id)sender;

@end

@interface NSObject ( WelcomeDialogDelegate )
- (void)welcomeDialog:(WelcomeDialog *)sender onOK:(NSDictionary *)config;
- (void)welcomeDialogWillClose:(WelcomeDialog *)sender;
@end
