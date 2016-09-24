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

@interface WhoisDialog : NSWindowController

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) BOOL isOperator;
@property ( nonatomic ) NSString *nick;

@property ( nonatomic ) IBOutlet NSTextField *nickText;
@property ( nonatomic ) IBOutlet NSTextField *logInText;
@property ( nonatomic ) IBOutlet NSTextField *realnameText;
@property ( nonatomic ) IBOutlet NSTextField *addressText;
@property ( nonatomic ) IBOutlet NSTextField *serverText;
@property ( nonatomic ) IBOutlet NSTextField *serverInfoText;
@property ( nonatomic ) IBOutlet NSPopUpButton *channelsCombo;
@property ( nonatomic ) IBOutlet NSTextField *awayText;
@property ( nonatomic ) IBOutlet NSTextField *idleText;
@property ( nonatomic ) IBOutlet NSTextField *signOnText;
@property ( nonatomic ) IBOutlet NSButton *joinButton;
@property ( nonatomic ) IBOutlet NSButton *closeButton;

- (void)show;
- (void)close;

- (void)startWithNick:(NSString *)nick username:(NSString *)username address:(NSString *)address realname:(NSString *)realname;

- (void)setNick:(NSString *)nick username:(NSString *)username address:(NSString *)address realname:(NSString *)realname;
- (void)setChannels:(NSArray *)channels;
- (void)setServer:(NSString *)server serverInfo:(NSString *)info;
- (void)setAwayMessage:(NSString *)value;
- (void)setIdle:(NSString *)idle signOn:(NSString *)signOn;

- (void)onClose:(id)sender;
- (void)onTalk:(id)sender;
- (void)onUpdate:(id)sender;
- (void)onJoin:(id)sender;

@end

@interface NSObject ( WhoisDialogDelegate )
- (void)whoisDialogOnTalk:(WhoisDialog *)sender;
- (void)whoisDialogOnUpdate:(WhoisDialog *)sender;
- (void)whoisDialogOnJoin:(WhoisDialog *)sender channel:(NSString *)channel;
- (void)whoisDialogWillClose:(WhoisDialog *)sender;
@end
