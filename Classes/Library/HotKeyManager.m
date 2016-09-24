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

#import "HotKeyManager.h"

@implementation HotKeyManager

- (void)dealloc
{
    [self unregisterHotKey];
}

- (BOOL)enabled
{
    return _handle != 0;
}

- (BOOL)registerHotKeyCode:(int)keyCode withModifier:(NSUInteger)modifier
{
    static UInt32 serial = 0;

    [self unregisterHotKey];

    UInt32 mod = 0;
    if( modifier & NSShiftKeyMask ) {
        mod |= shiftKey;
    }
    if( modifier & NSControlKeyMask ) {
        mod |= controlKey;
    }
    if( modifier & NSCommandKeyMask ) {
        mod |= cmdKey;
    }
    if( modifier & NSAlternateKeyMask ) {
        mod |= optionKey;
    }

    EventHotKeyID keyId = { 'LmCt', serial++ };

    OSStatus status = RegisterEventHotKey( keyCode, mod, keyId, GetApplicationEventTarget(), 0, &_handle );
    return status == noErr;
}

- (void)unregisterHotKey
{
    if( _handle ) {
        UnregisterEventHotKey( _handle );
        _handle = 0;
    }
}

@end
