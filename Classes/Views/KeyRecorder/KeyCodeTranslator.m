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

#import "KeyCodeTranslator.h"

#define MAX_LEN 4

@implementation KeyCodeTranslator {
    TISInputSourceRef _layout;
    const UCKeyboardLayout *_layoutData;
}

- (id)initWithKeyboardLayout:(TISInputSourceRef)aLayout
{
    self = [super init];
    if( self ) {
        _layout = aLayout;
        CFDataRef data = TISGetInputSourceProperty( _layout, kTISPropertyUnicodeKeyLayoutData );
        _layoutData = (const UCKeyboardLayout *)CFDataGetBytePtr( data );
    }
    return self;
}

- (void)dealloc
{
    if( _layout ) CFRelease( _layout );
}

+ (id)sharedInstance
{
    static KeyCodeTranslator *instance = nil;
    TISInputSourceRef currentLayout = TISCopyCurrentKeyboardLayoutInputSource();

    if( !instance ) {
        instance = [[KeyCodeTranslator alloc] initWithKeyboardLayout:currentLayout];
    }
    else if( [instance keyboardLayout] != currentLayout ) {
        instance = [[KeyCodeTranslator alloc] initWithKeyboardLayout:currentLayout];
    }
    return instance;
}

- (TISInputSourceRef)keyboardLayout
{
    return _layout;
}

- (NSString *)translateKeyCode:(short)keyCode
{
    UniCharCount len;
    UniChar str[MAX_LEN];
    UInt32 deadKeyState;

    UCKeyTranslate( _layoutData, keyCode, kUCKeyActionDisplay, 0, LMGetKbdType(), kUCKeyTranslateNoDeadKeysBit, &deadKeyState, MAX_LEN, &len, str );
    return [NSString stringWithCharacters:str length:1];
}

@end
