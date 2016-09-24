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

#import <Cocoa/Cocoa.h>

@interface OtherTheme : NSObject

@property ( nonatomic ) NSString *fileName;

@property ( nonatomic, readonly ) NSString *logNickFormat;
@property ( nonatomic, readonly ) NSColor *logScrollerMarkColor;

@property ( nonatomic, readonly ) NSFont *inputTextFont;
@property ( nonatomic, readonly ) NSColor *inputTextBgColor;
@property ( nonatomic, readonly ) NSColor *inputTextColor;
@property ( nonatomic, readonly ) NSColor *inputTextSelColor;

@property ( nonatomic, readonly ) NSFont *treeFont;
@property ( nonatomic, readonly ) NSColor *treeBgColor;
@property ( nonatomic, readonly ) NSColor *treeHighlightColor;
@property ( nonatomic, readonly ) NSColor *treeNewTalkColor;
@property ( nonatomic, readonly ) NSColor *treeUnreadColor;

@property ( nonatomic, readonly ) NSColor *treeActiveColor;
@property ( nonatomic, readonly ) NSColor *treeInactiveColor;

@property ( nonatomic, readonly ) NSColor *treeSelActiveColor;
@property ( nonatomic, readonly ) NSColor *treeSelInactiveColor;
@property ( nonatomic, readonly ) NSColor *treeSelTopLineColor;
@property ( nonatomic, readonly ) NSColor *treeSelBottomLineColor;
@property ( nonatomic, readonly ) NSColor *treeSelTopColor;
@property ( nonatomic, readonly ) NSColor *treeSelBottomColor;

@property ( nonatomic, readonly ) NSFont *memberListFont;
@property ( nonatomic, readonly ) NSColor *memberListBgColor;
@property ( nonatomic, readonly ) NSColor *memberListColor;
@property ( nonatomic, readonly ) NSColor *memberListOpColor;

@property ( nonatomic, readonly ) NSColor *memberListSelColor;
@property ( nonatomic, readonly ) NSColor *memberListSelTopLineColor;
@property ( nonatomic, readonly ) NSColor *memberListSelBottomLineColor;
@property ( nonatomic, readonly ) NSColor *memberListSelTopColor;
@property ( nonatomic, readonly ) NSColor *memberListSelBottomColor;

- (void)reload;

@end
