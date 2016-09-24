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

#define CHATBOX_SPACE 3

@implementation ChatBox

- (NSView *)logBase
{
    return [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:0];
}

- (NSTextField *)inputText
{
    return [[[[self subviews] objectAtIndex:0] subviews] objectAtIndex:1];
}

- (void)setInputTextFont:(NSFont *)font
{
    NSTextField *text = [self inputText];
    [text setFont:font];

    // calculate height of the text field
    NSRect f = [text frame];
    f.size.height = 1e+37;
    f.size.height = ceil( [[text cell] cellSizeForBounds:f].height ) + 2;
    [text setFrameSize:f.size];

    // apply the current font to text
    NSRange range;
    NSText *e = [text currentEditor];
    if( e ) range = [e selectedRange];
    NSString *s = [text stringValue];
    [text setAttributedStringValue:[NSAttributedString new]];
    [text setStringValue:s];
    if( e ) [e setSelectedRange:range];

    [self setFrame:[self frame]];
}

- (void)setFrame:(NSRect)rect
{
    if( [self subviews].count > 0 ) {
        NSRect f = rect;
        NSView *box = [self logBase];
        NSTextField *text = [self inputText];
        NSRect boxFrame = [box frame];
        NSRect textFrame = [text frame];

        boxFrame.origin.x = 0;
        boxFrame.origin.y = textFrame.size.height + CHATBOX_SPACE;
        boxFrame.size.width = f.size.width;
        boxFrame.size.height = f.size.height - textFrame.size.height - CHATBOX_SPACE;
        [box setFrame:boxFrame];

        textFrame.origin = NSMakePoint( 0, 0 );
        textFrame.size.width = f.size.width;
        [text setFrame:textFrame];
    }

    [super setFrame:rect];
}

@end
