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

#import "MarkedScroller.h"

const static int INSET = 3;

@implementation MarkedScroller

+ (BOOL)isCompatibleWithOverlayScrollers
{
    return self == [MarkedScroller class];
}

- (void)updateScroller
{
    self.markData = [_dataSource markedScrollerPositions:self];
}

- (void)drawContentInMarkedScroller
{
    if( !_dataSource ) return;
    if( ![_dataSource respondsToSelector:@selector( markedScrollerPositions: )] ) return;
    if( ![_dataSource respondsToSelector:@selector( markedScrollerColor: )] ) return;

    NSScrollView *scrollView = (NSScrollView *)[self superview];
    int contentHeight = [[scrollView contentView] documentRect].size.height;
    if( !_markData || !_markData.count ) return;

    //
    // prepare transform
    //
    NSAffineTransform *transform = [NSAffineTransform transform];
    int width = [self rectForPart:NSScrollerKnobSlot].size.width - INSET * 2;
    CGFloat scale = [self rectForPart:NSScrollerKnobSlot].size.height / (CGFloat)contentHeight;
    int offset = [self rectForPart:NSScrollerKnobSlot].origin.y;
    int indent = [self rectForPart:NSScrollerKnobSlot].origin.x + INSET;
    [transform scaleXBy:1 yBy:scale];
    [transform translateXBy:0 yBy:offset];

    //
    // make lines
    //
    NSMutableArray *lines = [NSMutableArray array];
    NSPoint prev = NSMakePoint( -1, -1 );

    for( NSNumber *e in _markData ) {
        int i = [e intValue];
        NSPoint pt = NSMakePoint( indent, i );
        pt = [transform transformPoint:pt];
        pt.x = ceil( pt.x );
        pt.y = ceil( pt.y ) + 0.5;
        if( pt.x == prev.x && pt.y == prev.y ) continue;
        prev = pt;
        NSBezierPath *line = [NSBezierPath bezierPath];
        [line setLineWidth:1];
        [line moveToPoint:pt];
        [line relativeLineToPoint:NSMakePoint( width, 0 )];
        [lines addObject:line];
    }

    //
    // draw lines
    //
    NSColor *color = [_dataSource markedScrollerColor:self];
    [color set];

    for( NSBezierPath *e in lines ) {
        [e stroke];
    }
}

- (void)drawKnob
{
    [self drawContentInMarkedScroller];
    [super drawKnob];
}

@end
