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

#import "InputTextField.h"

@implementation InputTextField

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    [[self backgroundColor] set];
    NSFrameRectWithWidth( [self bounds], 3 );
}

- (void)awakeFromNib
{
    [self registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
}

- (NSString *)draggedString:(id<NSDraggingInfo>)sender
{
    return [[sender draggingPasteboard] stringForType:NSStringPboardType];
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender
{
    NSString *s = [self draggedString:sender];
    if( s.length ) {
        return NSDragOperationCopy;
    }
    else {
        return NSDragOperationNone;
    }
}

- (NSDragOperation)draggingUpdated:(id<NSDraggingInfo>)sender
{
    return NSDragOperationCopy;
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender
{
}

- (void)draggingExited:(id<NSDraggingInfo>)sender
{
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender
{
    NSString *s = [self draggedString:sender];
    return s.length > 0;
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender
{
    NSString *s = [self draggedString:sender];
    if( s.length ) {
        [self setStringValue:[[self stringValue] stringByAppendingString:s]];
        return YES;
    }
    return NO;
}

- (void)concludeDragOperation:(id<NSDraggingInfo>)sender
{
}

@end
