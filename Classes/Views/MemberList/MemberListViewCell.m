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

#import "MemberListViewCell.h"

#define LEFT_MARGIN 2
#define MARK_RIGHT_MARGIN 2

static OtherTheme *theme;
static int markWidth;
static NSMutableParagraphStyle *markStyle;
static NSMutableParagraphStyle *nickStyle;

@implementation MemberListViewCell

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    MemberListViewCell *c = [[MemberListViewCell alloc] init];
    c.font = self.font;
    c.member = _member;
    return c;
}

- (void)calculateMarkWidth
{
    markWidth = 0;

    NSDictionary *style = [NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
    NSArray *marks = [NSArray arrayWithObjects:@"~", @"&", @"@", @"%", @"+", nil];

    for( NSString *s in marks ) {
        NSSize size = [s sizeWithAttributes:style];
        int width = ceil( size.width );
        if( markWidth < width ) {
            markWidth = width;
        }
    }
}

- (void)setup:(id)aTheme
{
    theme = aTheme;

    if( !markStyle ) {
        markStyle = [NSMutableParagraphStyle new];
        [markStyle setAlignment:NSCenterTextAlignment];
    }

    if( !nickStyle ) {
        nickStyle = [NSMutableParagraphStyle new];
        [nickStyle setAlignment:NSLeftTextAlignment];
        [nickStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    }
}

- (void)themeChanged
{
    [self calculateMarkWidth];
}

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view
{
    NSWindow *window = view.window;
    NSColor *color = nil;

    if( [self isHighlighted] ) {
        if( window && [window isMainWindow] && [window firstResponder] == view ) {
            color = [theme memberListSelColor] ?: [NSColor alternateSelectedControlTextColor];
        }
        else {
            color = [theme memberListSelColor] ?: [NSColor selectedControlTextColor];
        }
    }
    else if( [_member isOp] ) {
        color = [theme memberListOpColor];
    }
    else {
        color = [theme memberListColor];
    }

    NSMutableDictionary *style = [NSMutableDictionary dictionary];
    [style setObject:markStyle forKey:NSParagraphStyleAttributeName];
    [style setObject:self.font forKey:NSFontAttributeName];
    [style setObject:color forKey:NSForegroundColorAttributeName];

    NSRect rect = frame;
    rect.origin.x += LEFT_MARGIN;
    rect.size.width = markWidth;

    UniChar mark = [_member mark];
    if( mark != INVALID_MARK_CHAR ) {
        NSString *markStr = [NSString stringWithFormat:@"%C", mark];
        [markStr drawInRect:rect withAttributes:style];
    }

    [style setObject:nickStyle forKey:NSParagraphStyleAttributeName];

    int offset = LEFT_MARGIN + markWidth + MARK_RIGHT_MARGIN;

    rect = frame;
    rect.origin.x += offset;
    rect.size.width -= offset;

    NSString *nick = [_member nick];
    [nick drawInRect:rect withAttributes:style];
}

@end
