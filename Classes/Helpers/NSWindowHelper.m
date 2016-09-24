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

#import "NSWindowHelper.h"
#import "NSRectHelper.h"

@implementation NSWindow ( NSWindowHelper )

- (void)centerOfWindow:(NSWindow *)window
{
    NSPoint p = NSRectCenter( window.frame );
    NSRect frame = self.frame;
    NSSize size = frame.size;
    p.x -= size.width / 2;
    p.y -= size.height / 2;

    NSScreen *screen = window.screen;
    if( screen ) {
        NSRect screenFrame = [screen visibleFrame];
        NSRect r = frame;
        r.origin = p;
        if( !NSContainsRect( screenFrame, r ) ) {
            r = NSRectAdjustInRect( r, screenFrame );
            p = r.origin;
        }
    }

    [self setFrameOrigin:p];
}

@end
