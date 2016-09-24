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

#import "GistClient.h"
#import "SheetBase.h"
#import <Foundation/Foundation.h>

@interface PasteSheet : SheetBase

@property ( nonatomic ) NSString *nick;
@property ( nonatomic ) int uid;
@property ( nonatomic ) int cid;
@property ( nonatomic ) NSString *originalText;
@property ( nonatomic ) NSString *syntax;
@property ( nonatomic ) NSString *command;
@property ( nonatomic ) NSSize size;
@property ( nonatomic ) BOOL editMode;
@property ( nonatomic, readonly ) BOOL isShortText;

@property ( nonatomic ) IBOutlet NSTextView *bodyText;
@property ( nonatomic ) IBOutlet NSButton *pasteOnlineButton;
@property ( nonatomic ) IBOutlet NSButton *sendInChannelButton;
@property ( nonatomic ) IBOutlet NSPopUpButton *syntaxPopup;
@property ( nonatomic ) IBOutlet NSPopUpButton *commandPopup;
@property ( nonatomic ) IBOutlet NSProgressIndicator *uploadIndicator;
@property ( nonatomic ) IBOutlet NSTextField *errorLabel;

- (void)start;

- (void)pasteOnline:(id)sender;
- (void)sendInChannel:(id)sender;

@end

@interface NSObject ( PasteSheetDelegate )
- (void)pasteSheet:(PasteSheet *)sender onPasteText:(NSString *)text;
- (void)pasteSheet:(PasteSheet *)sender onPasteURL:(NSString *)url;
- (void)pasteSheetOnCancel:(PasteSheet *)sender;
- (void)pasteSheetWillClose:(PasteSheet *)sender;
@end
