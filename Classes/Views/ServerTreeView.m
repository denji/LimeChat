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

#import "ServerTreeView.h"

@implementation ServerTreeView {
    NSColor *_bgColor;
    NSColor *_topLineColor;
    NSColor *_bottomLineColor;
    NSGradient *_gradient;
}

- (void)setUp
{
    _bgColor = [NSColor colorWithCalibratedRed:229 / 255.0 green:237 / 255.0 blue:247 / 255.0 alpha:1];
    _topLineColor = [NSColor colorWithCalibratedRed:173 / 255.0 green:187 / 255.0 blue:208 / 255.0 alpha:1];
    _bottomLineColor = [NSColor colorWithCalibratedRed:140 / 255.0 green:152 / 255.0 blue:176 / 255.0 alpha:1];

    NSColor *start = [NSColor colorWithCalibratedRed:173 / 255.0 green:187 / 255.0 blue:208 / 255.0 alpha:1];
    NSColor *end = [NSColor colorWithCalibratedRed:152 / 255.0 green:170 / 255.0 blue:196 / 255.0 alpha:1];
    _gradient = [[NSGradient alloc] initWithStartingColor:start endingColor:end];
}

- (id)initWithFrame:(NSRect)rect
{
    self = [super initWithFrame:rect];
    if( self ) {
        [self setUp];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if( self ) {
        [self setUp];
    }
    return self;
}

- (BOOL)acceptsFirstResponder
{
    if( _responderDelegate ) {
        [_responderDelegate serverTreeViewAcceptsFirstResponder];
        return NO;
    }
    return YES;
}

- (void)themeChanged
{
    _bgColor = _theme.treeBgColor;
    _topLineColor = _theme.treeSelTopLineColor;
    _bottomLineColor = _theme.treeSelBottomLineColor;

    NSColor *start = _theme.treeSelTopColor;
    NSColor *end = _theme.treeSelBottomColor;
    _gradient = [[NSGradient alloc] initWithStartingColor:start endingColor:end];
}

- (NSColor *)_highlightColorForCell:(NSCell *)cell
{
    return nil;
}

- (void)_highlightRow:(int)row clipRect:(NSRect)clipRect
{
    if( ![NSApp isActive] ) return;

    NSRect frame = [self rectOfRow:row];
    NSRect rect = frame;
    rect.origin.y += 1;
    rect.size.height -= 2;
    [_gradient drawInRect:rect angle:90];

    [_topLineColor set];
    rect = frame;
    rect.size.height = 1;
    NSRectFill( rect );

    [_bottomLineColor set];
    rect = frame;
    rect.origin.y += rect.size.height - 1;
    rect.size.height = 1;
    NSRectFill( rect );
}

- (void)drawBackgroundInClipRect:(NSRect)rect
{
    [_bgColor set];
    NSRectFill( rect );
}

@end
