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

#import "DialogWindow.h"

@implementation DialogWindow {
    BOOL _isSheet;
}

- (void)startSheetModalForWindow:(NSWindow *)parentWindow
{
    _isSheet = YES;
    [NSApp beginSheet:self modalForWindow:parentWindow modalDelegate:self didEndSelector:@selector( sheetDidEnd:returnCode:contextInfo: ) contextInfo:nil];
}

- (void)endSheet
{
    [NSApp endSheet:self];
}

- (void)sheetDidEnd:(NSWindow *)sender returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo
{
    [self close];
}

- (void)closeWindowOrSheet
{
    if( _isSheet ) {
        [self endSheet];
    }
    else {
        [self close];
    }
}

- (void)sendEvent:(NSEvent *)e
{
    if( [e type] == NSKeyDown ) {
        NSInputManager *im = [NSInputManager currentInputManager];
        if( !im || !im.markedRange.length ) {
            int k = [e keyCode];
            NSUInteger m = [e modifierFlags];
            BOOL shift = ( m & NSShiftKeyMask ) != 0;
            BOOL ctrl = ( m & NSControlKeyMask ) != 0;
            BOOL alt = ( m & NSAlternateKeyMask ) != 0;
            BOOL cmd = ( m & NSCommandKeyMask ) != 0;

            if( !( shift || ctrl || alt || cmd ) ) {
                // no mods
                switch( k ) {
                case 0x35: // esc
                    [self closeWindowOrSheet];
                    return;
                }
            }
        }
    }

    [super sendEvent:e];
}

@end
