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

#import "KeyRecorderCell.h"
#import "KeyRecorder.h"

@implementation KeyRecorderCell

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

- (NSBezierPath *)borderPathForBounds:(NSRect)r
{
    //r = NSInsetRect(r, 0.5, 0.5);
    CGFloat radius = r.size.height / 2;
    return [NSBezierPath bezierPathWithRoundedRect:r xRadius:radius yRadius:radius];
}

- (void)drawInteriorWithFrame:(NSRect)rect inView:(NSView *)contentView
{
    [NSGraphicsContext saveGraphicsState];

    if( [self showsFirstResponder] ) {
        NSSetFocusRingStyle( NSFocusRingOnly );
        [[self borderPathForBounds:rect] fill];
    }

    [NSGraphicsContext restoreGraphicsState];
}

@end
