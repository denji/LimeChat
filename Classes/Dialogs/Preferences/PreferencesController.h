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

#import "KeyRecorder.h"
#import <Cocoa/Cocoa.h>

#define ThemeDidChangeNotification @"ThemeDidChangeNotification"

@interface PreferencesController : NSWindowController

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) NSString *fontDisplayName;
@property ( nonatomic ) CGFloat fontPointSize;
@property ( nonatomic ) NSString *inputFontDisplayName;
@property ( nonatomic ) CGFloat inputFontPointSize;
@property ( nonatomic, readonly ) NSArray *availableSounds;
@property ( nonatomic, readonly ) NSMutableArray *sounds;

@property ( nonatomic ) IBOutlet KeyRecorder *hotKey;
@property ( nonatomic ) IBOutlet NSTableView *keywordsTable;
@property ( nonatomic ) IBOutlet NSTableView *excludeWordsTable;
@property ( nonatomic ) IBOutlet NSArrayController *keywordsArrayController;
@property ( nonatomic ) IBOutlet NSArrayController *excludeWordsArrayController;
@property ( nonatomic ) IBOutlet NSPopUpButton *transcriptFolderButton;
@property ( nonatomic ) IBOutlet NSPopUpButton *themeButton;
@property ( nonatomic ) IBOutlet NSTableView *soundsTable;
@property ( weak ) IBOutlet NSTextField *savedMessagesLabel;
@property ( weak ) IBOutlet NSStepper *savedMessagesStepper;

- (void)show;

- (void)onAddKeyword:(id)sender;
- (void)onAddExcludeWord:(id)sender;

- (void)onTranscriptFolderChanged:(id)sender;
- (void)onLayoutChanged:(id)sender;
- (void)onChangedTheme:(id)sender;
- (void)onOpenThemePath:(id)sender;
- (void)onSelectFont:(id)sender;
- (void)onInputSelectFont:(id)sender;
- (void)onOverrideFontChanged:(id)sender;
- (void)onChangedTransparency:(id)sender;
- (IBAction)changeNumberOfMessages:(NSSlider *)sender;

@end

@interface NSObject ( PreferencesControllerDelegate )
- (void)preferencesDialogWillClose:(PreferencesController *)sender;
@end
