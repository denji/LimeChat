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

@interface ListDialog : NSWindowController

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic, readonly ) int sortKey;
@property ( nonatomic, readonly ) NSComparisonResult sortOrder;

@property ( nonatomic ) IBOutlet ListView *table;
@property ( nonatomic ) IBOutlet NSSearchField *filterText;
@property ( nonatomic ) IBOutlet NSButton *updateButton;

- (void)start;
- (void)show;
- (void)close;
- (void)clear;

- (void)addChannel:(NSString *)channel count:(int)count topic:(NSString *)topic;

- (void)onClose:(id)sender;
- (void)onUpdate:(id)sender;
- (void)onJoin:(id)sender;
- (void)onSearchFieldChange:(id)sender;

@end

@interface NSObject ( ListDialogDelegate )
- (void)listDialogOnUpdate:(ListDialog *)sender;
- (void)listDialogOnJoin:(ListDialog *)sender channel:(NSString *)channel;
- (void)listDialogWillClose:(ListDialog *)sender;
@end
