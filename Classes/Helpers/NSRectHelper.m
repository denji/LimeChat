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

#import "NSRectHelper.h"

NSPoint NSRectCenter( NSRect rect )
{
    return NSMakePoint( rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2 );
}

NSRect NSRectAdjustInRect( NSRect r, NSRect bounds )
{
    if( NSMaxX( bounds ) < NSMaxX( r ) ) {
        r.origin.x = NSMaxX( bounds ) - r.size.width;
    }
    if( NSMaxY( bounds ) < NSMaxY( r ) ) {
        r.origin.y = NSMaxY( bounds ) - r.size.height;
    }
    if( r.origin.x < bounds.origin.x ) {
        r.origin.x = bounds.origin.x;
    }
    if( r.origin.y < bounds.origin.y ) {
        r.origin.y = bounds.origin.y;
    }
    return r;
}
