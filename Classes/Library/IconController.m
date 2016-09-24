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

#import "IconController.h"

@implementation IconController {
    BOOL _highlight;
    BOOL _newTalk;
}

- (void)setHighlight:(BOOL)aHighlight newTalk:(BOOL)aNewTalk
{
    if( _highlight == aHighlight && _newTalk == aNewTalk ) {
        return;
    }

    _highlight = aHighlight;
    _newTalk = aNewTalk;

    NSImage *icon = [NSImage imageNamed:@"NSApplicationIcon"];

    if( _highlight || _newTalk ) {
        NSSize iconSize = icon.size;
        NSImage *badge = _highlight ? [NSImage imageNamed:@"redbadge"] : [NSImage imageNamed:@"bluebadge"];
        if( badge ) {
            NSSize size = badge.size;
            int w = size.width;
            int h = size.height;
            int x = iconSize.width - w;
            int y = iconSize.height - h;
            NSRect rect = NSMakeRect( x, y, w, h );
            NSRect sourceRect = NSMakeRect( 0, 0, size.width, size.height );
            NSDictionary *hints = @{ NSImageHintInterpolation : @( NSImageInterpolationHigh ) };

            icon = [icon copy];
            [icon lockFocus];
            [badge drawInRect:rect fromRect:sourceRect operation:NSCompositeSourceOver fraction:1 respectFlipped:YES hints:hints];
            [icon unlockFocus];
        }
    }

    [NSApp setApplicationIconImage:icon];
}

@end
