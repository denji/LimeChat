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

#import "LogLine.h"
#import "LogPolicy.h"
#import "LogScriptEventSink.h"
#import "LogView.h"
#import "MarkedScroller.h"
#import "ViewTheme.h"
#import "WebViewAutoScroll.h"
#import <Cocoa/Cocoa.h>

@class IRCWorld;
@class IRCClient;
@class IRCChannel;

@interface LogController : NSObject

@property ( nonatomic, readonly ) LogView *view;
@property ( nonatomic, weak ) IRCWorld *world;
@property ( nonatomic, weak ) IRCClient *client;
@property ( nonatomic, weak ) IRCChannel *channel;
@property ( nonatomic ) NSMenu *menu;
@property ( nonatomic ) NSMenu *urlMenu;
@property ( nonatomic ) NSMenu *addrMenu;
@property ( nonatomic ) NSMenu *chanMenu;
@property ( nonatomic ) NSMenu *memberMenu;
@property ( nonatomic ) ViewTheme *theme;
@property ( nonatomic ) BOOL console;
@property ( nonatomic ) NSColor *initialBackgroundColor;
@property ( nonatomic ) int maxLines;
@property ( nonatomic, readonly ) BOOL viewingBottom;

- (void)setUp;
- (void)notifyDidBecomeVisible;

- (void)moveToTop;
- (void)moveToBottom;

- (void)mark;
- (void)unmark;
- (void)goToMark;
- (void)reloadTheme;
- (void)clear;
- (void)changeTextSize:(BOOL)bigger;
- (void)expandImage:(NSString *)url lineNumber:(int)aLineNumber imageIndex:(int)imageIndex contentLength:(long long)contentLength contentType:(NSString *)contentType;

- (BOOL)print:(LogLine *)line;

- (void)logViewOnDoubleClick:(NSString *)e;

@end
