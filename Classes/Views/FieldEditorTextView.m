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

#import "FieldEditorTextView.h"

@implementation FieldEditorTextView {
    KeyEventHandler *_keyHandler;
}

- (id)initWithFrame:(NSRect)frameRect textContainer:(NSTextContainer *)aTextContainer
{
    self = [super initWithFrame:frameRect textContainer:aTextContainer];
    if( self ) {
        _keyHandler = [KeyEventHandler new];
    }
    return self;
}

- (void)paste:(id)sender
{
    if( _pasteDelegate ) {
        BOOL result = [_pasteDelegate fieldEditorTextViewPaste:self];
        if( result ) {
            return;
        }
    }

    [super paste:sender];
}

- (void)setKeyHandlerTarget:(id)target
{
    [_keyHandler setTarget:target];
}

- (void)registerKeyHandler:(SEL)selector key:(int)code modifiers:(NSUInteger)mods
{
    [_keyHandler registerSelector:selector key:code modifiers:mods];
}

- (void)registerKeyHandler:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods
{
    [_keyHandler registerSelector:selector character:c modifiers:mods];
}

- (void)keyDown:(NSEvent *)e
{
    if( [_keyHandler processKeyEvent:e] ) {
        return;
    }

    [super keyDown:e];
}

@end
