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

#import "ChatBox.h"
#import "DCCController.h"
#import "FieldEditorTextView.h"
#import "IRCWorld.h"
#import "InputHistory.h"
#import "InputTextField.h"
#import "MainWindow.h"
#import "MemberListView.h"
#import "MenuController.h"
#import "NickCompletinStatus.h"
#import "NotificationController.h"
#import "ServerTreeView.h"
#import "ThinSplitView.h"
#import "ViewTheme.h"
#import "WelcomeDialog.h"
#import <Cocoa/Cocoa.h>

@interface AppController : NSObject

@property ( nonatomic ) IBOutlet MainWindow *window;
@property ( nonatomic ) IBOutlet ServerTreeView *tree;
@property ( nonatomic ) IBOutlet NSBox *logBase;
@property ( nonatomic ) IBOutlet NSBox *consoleBase;
@property ( nonatomic ) IBOutlet MemberListView *memberList;
@property ( nonatomic ) IBOutlet InputTextField *text;
@property ( nonatomic ) IBOutlet ChatBox *chatBox;
@property ( nonatomic ) IBOutlet NSScrollView *treeScrollView;
@property ( nonatomic ) IBOutlet NSView *leftTreeBase;
@property ( nonatomic ) IBOutlet NSView *rightTreeBase;
@property ( nonatomic ) IBOutlet ThinSplitView *rootSplitter;
@property ( nonatomic ) IBOutlet ThinSplitView *logSplitter;
@property ( nonatomic ) IBOutlet ThinSplitView *infoSplitter;
@property ( nonatomic ) IBOutlet ThinSplitView *treeSplitter;
@property ( nonatomic ) IBOutlet MenuController *menu;
@property ( nonatomic ) IBOutlet NSMenuItem *serverMenu;
@property ( nonatomic ) IBOutlet NSMenuItem *channelMenu;
@property ( nonatomic ) IBOutlet NSMenu *memberMenu;
@property ( nonatomic ) IBOutlet NSMenu *treeMenu;
@property ( nonatomic ) IBOutlet NSMenu *logMenu;
@property ( nonatomic ) IBOutlet NSMenu *consoleMenu;
@property ( nonatomic ) IBOutlet NSMenu *urlMenu;
@property ( nonatomic ) IBOutlet NSMenu *addrMenu;
@property ( nonatomic ) IBOutlet NSMenu *chanMenu;

@end
