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

#define KEY_RETURN 0x24
#define KEY_TAB 0x30
#define KEY_SPACE 0x31
#define KEY_BACKSPACE 0x33
#define KEY_ESCAPE 0x35
#define KEY_ENTER 0x4C
#define KEY_HOME 0x73
#define KEY_PAGE_UP 0x74
#define KEY_DELETE 0x75
#define KEY_END 0x77
#define KEY_PAGE_DOWN 0x79
#define KEY_LEFT 0x7B
#define KEY_RIGHT 0x7C
#define KEY_DOWN 0x7D
#define KEY_UP 0x7E

@interface KeyEventHandler : NSObject

@property ( nonatomic, weak ) id target;

- (void)registerSelector:(SEL)selector key:(int)code modifiers:(NSUInteger)mods;
- (void)registerSelector:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods;
- (void)registerSelector:(SEL)selector characters:(NSRange)characterRange modifiers:(NSUInteger)mods;

- (BOOL)processKeyEvent:(NSEvent *)e;

@end
