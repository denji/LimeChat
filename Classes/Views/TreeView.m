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

#import "TreeView.h"

@implementation TreeView

- (int)countSelectedRows
{
    return [[self selectedRowIndexes] count];
}

- (void)selectItemAtIndex:(int)index
{
    [self selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
    [self scrollRowToVisible:index];
}

- (NSMenu *)menuForEvent:(NSEvent *)e
{
    NSPoint p = [self convertPoint:[e locationInWindow] fromView:nil];
    int i = [self rowAtPoint:p];
    if( i >= 0 ) {
        [self selectItemAtIndex:i];
    }
    return [self menu];
}

- (void)setFont:(NSFont *)font
{
    for( NSTableColumn *column in [self tableColumns] ) {
        [[column dataCell] setFont:font];
    }

    NSRect frame = self.frame;
    frame.size.height = 1e+37;
    CGFloat height = [[[[self tableColumns] objectAtIndex:0] dataCell] cellSizeForBounds:frame].height;
    [self setRowHeight:ceil( height )];
    [self setNeedsDisplay:YES];
}

- (NSFont *)font
{
    return [[[[self tableColumns] objectAtIndex:0] dataCell] font];
}

- (void)keyDown:(NSEvent *)e
{
    if( _keyDelegate ) {
        switch( [e keyCode] ) {
        case 123 ... 126:
        case 116:
        case 121:
            break;
        default:
            if( [_keyDelegate respondsToSelector:@selector( treeViewKeyDown: )] ) {
                [_keyDelegate treeViewKeyDown:e];
            }
            break;
        }
    }

    [super keyDown:e];
}

@end
