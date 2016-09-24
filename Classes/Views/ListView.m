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

@implementation ListView

- (int)countSelectedRows
{
    return [[self selectedRowIndexes] count];
}

- (void)selectItemAtIndex:(int)index
{
    [self selectRowIndexes:[NSIndexSet indexSetWithIndex:index] byExtendingSelection:NO];
    [self scrollRowToVisible:index];
}

- (void)selectRows:(NSArray *)indices
{
    [self selectRows:indices extendSelection:NO];
}

- (void)selectRows:(NSArray *)indices extendSelection:(BOOL)extend
{
    NSMutableIndexSet *set = [NSMutableIndexSet indexSet];
    for( NSNumber *n in indices ) {
        [set addIndex:[n intValue]];
    }

    [self selectRowIndexes:set byExtendingSelection:extend];
}

- (void)rightMouseDown:(NSEvent *)e
{
    NSPoint p = [self convertPoint:[e locationInWindow] fromView:nil];
    int i = [self rowAtPoint:p];
    if( i >= 0 ) {
        if( ![[self selectedRowIndexes] containsIndex:i] ) {
            [self selectItemAtIndex:i];
        }
    }

    [super rightMouseDown:e];
}

- (void)setFont:(NSFont *)font
{
    for( NSTableColumn *column in [self tableColumns] ) {
        [[column dataCell] setFont:font];
    }

    NSRect f = [self frame];
    f.size.height = 1e+37;
    CGFloat height = ceil( [[[[self tableColumns] objectAtIndex:0] dataCell] cellSizeForBounds:f].height );
    [self setRowHeight:height];
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
        case 51:
        case 117: // delete
            if( [self countSelectedRows] > 0 ) {
                if( [_keyDelegate respondsToSelector:@selector( listViewDelete )] ) {
                    [_keyDelegate listViewDelete];
                    return;
                }
            }
            break;
        case 126: // up
        {
            NSIndexSet *set = [self selectedRowIndexes];
            if( [set count] > 0 && [set containsIndex:0] ) {
                if( [_keyDelegate respondsToSelector:@selector( listViewMoveUp )] ) {
                    [_keyDelegate listViewMoveUp];
                    return;
                }
            }
            break;
        }
        case 116: // page up
        case 121: // page down
        case 123 ... 125: // cursor keys
            break;
        default:
            if( [_keyDelegate respondsToSelector:@selector( listViewKeyDown: )] ) {
                [_keyDelegate listViewKeyDown:e];
            }
            break;
        }
    }

    [super keyDown:e];
}

- (void)textDidEndEditing:(NSNotification *)note
{
    if( [_textDelegate respondsToSelector:@selector( textDidEndEditing: )] ) {
        [_textDelegate textDidEndEditing:note];
    }
    [super textDidEndEditing:note];
}

@end
