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

#import "LimeChatApplication.h"
#import "Preferences.h"

enum {
    kEventHotKeyPressedSubtype = 6,
    kEventHotKeyReleasedSubtype = 9,
};

@implementation LimeChatApplication {
    HotKeyManager *_hotkey;
}

- (id)init
{
    self = [super init];
    if( self ) {
        [Preferences migrate];
        [Preferences initPreferences];
    }
    return self;
}

- (void)sendEvent:(NSEvent *)e
{
    if( [e type] == NSSystemDefined && [e subtype] == kEventHotKeyPressedSubtype ) {
        if( _hotkey && [_hotkey enabled] ) {
            unsigned long long handle = (unsigned long long)_hotkey.handle;
            unsigned long long data1 = [e data1];
            handle &= 0xffffffff;
            data1 &= 0xffffffff;
            if( handle == data1 ) {
                id delegate = [self delegate];
                if( [delegate respondsToSelector:@selector( applicationDidReceiveHotKey: )] ) {
                    [delegate applicationDidReceiveHotKey:self];
                }
            }
        }
    }
    [super sendEvent:e];
}

- (void)registerHotKey:(int)keyCode modifierFlags:(NSUInteger)modFlags
{
    if( !_hotkey ) {
        _hotkey = [HotKeyManager new];
    }
    [_hotkey unregisterHotKey];
    [_hotkey registerHotKeyCode:keyCode withModifier:modFlags];
}

- (void)unregisterHotKey
{
    if( _hotkey ) {
        [_hotkey unregisterHotKey];
    }
}

@end
