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

#import "InputTextField.h"
#import "MainWindow.h"
#import "MemberListView.h"
#import "PasteSheet.h"
#import "PreferencesController.h"
#import "ServerTreeView.h"
#import "TopicSheet.h"
#import <LimeChat-Swift.h>
#import <Cocoa/Cocoa.h>

@class AppController;
@class IRCWorld;
@class IRCClient;

@interface MenuController : NSObject

@property ( nonatomic, weak ) AppController *app;
@property ( nonatomic, weak ) IRCWorld *world;
@property ( nonatomic, weak ) MainWindow *window;
@property ( nonatomic, weak ) InputTextField *text;
@property ( nonatomic, weak ) ServerTreeView *tree;
@property ( nonatomic, weak ) MemberListView *memberList;

@property ( nonatomic ) NSString *pointedUrl;
@property ( nonatomic ) NSString *pointedAddress;
@property ( nonatomic ) NSString *pointedNick;
@property ( nonatomic ) NSString *pointedChannelName;

@property ( nonatomic ) IBOutlet NSMenuItem *closeWindowItem;
@property ( nonatomic ) IBOutlet NSMenuItem *closeCurrentPanelItem;
@property ( nonatomic ) IBOutlet NSMenuItem *checkForUpdateItem;
@property ( nonatomic ) IBOutlet NSMenuItem *toggleMuteSounds;

- (void)setUp;
- (void)terminate;
- (void)startPasteSheetWithContent:(NSString *)content nick:(NSString *)nick uid:(int)uid cid:(int)cid editMode:(BOOL)editMode;
- (void)showServerPropertyDialog:(IRCClient *)client ignore:(BOOL)ignore;

- (void)onPreferences:(id)sender;
- (void)onMute:(id)sender;
- (void)onAutoOp:(id)sender;
- (void)onDcc:(id)sender;
- (void)onMainWindow:(id)sender;
- (void)onHelp:(id)sender;

- (void)onCloseWindow:(id)sender;
- (void)onCloseCurrentPanel:(id)sender;

- (void)onPaste:(id)sender;
- (void)onPasteDialog:(id)sender;
- (void)onUseSelectionForFind:(id)sender;
- (void)onPasteMyAddress:(id)sender;
- (void)onSearchWeb:(id)sender;
- (void)onCopyLogAsHtml:(id)sender;
- (void)onCopyConsoleLogAsHtml:(id)sender;

- (void)onMarkScrollback:(id)sender;
- (void)onClearMark:(id)sender;
- (void)onGoToMark:(id)sender;
- (void)onMarkAllAsRead:(id)sender;
- (void)onMarkAllAsReadAndMarkAllScrollbacks:(id)sender;
- (void)onMakeTextBigger:(id)sender;
- (void)onMakeTextSmaller:(id)sender;
- (void)onReloadTheme:(id)sender;

- (void)onConnect:(id)sender;
- (void)onDisconnect:(id)sender;
- (void)onCancelReconnecting:(id)sender;
- (void)onNick:(id)sender;
- (void)onChannelList:(id)sender;
- (void)onAddServer:(id)sender;
- (void)onCopyServer:(id)sender;
- (void)onDeleteServer:(id)sender;
- (void)onServerProperties:(id)sender;
- (void)onServerAutoOp:(id)sender;

- (void)onJoin:(id)sender;
- (void)onLeave:(id)sender;
- (void)onTopic:(id)sender;
- (void)onMode:(id)sender;
- (void)onAddChannel:(id)sender;
- (void)onDeleteChannel:(id)sender;
- (void)onChannelProperties:(id)sender;
- (void)onChannelAutoOp:(id)sender;

- (void)memberListDoubleClicked:(id)sender;
- (void)onMemberWhois:(id)sender;
- (void)onMemberTalk:(id)sender;
- (void)onMemberGiveOp:(id)sender;
- (void)onMemberDeop:(id)sender;
- (void)onMemberInvite:(id)sender;
- (void)onMemberKick:(id)sender;
- (void)onMemberBan:(id)sender;
- (void)onMemberKickBan:(id)sender;
- (void)onMemberGiveVoice:(id)sender;
- (void)onMemberDevoice:(id)sender;
- (void)onMemberSendFile:(id)sender;
- (void)onMemberPing:(id)sender;
- (void)onMemberTime:(id)sender;
- (void)onMemberVersion:(id)sender;
- (void)onMemberUserInfo:(id)sender;
- (void)onMemberClientInfo:(id)sender;
- (void)onMemberAutoOp:(id)sender;

- (void)onCopyUrl:(id)sender;
- (void)onJoinChannel:(id)sender;
- (void)onCopyAddress:(id)sender;

@end
