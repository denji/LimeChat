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

#import "KeyEventHandler.h"

@implementation KeyEventHandler {
    NSMutableDictionary *_codeHandlerMap;
    NSMutableDictionary *_characterHandlerMap;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _codeHandlerMap = [NSMutableDictionary new];
        _characterHandlerMap = [NSMutableDictionary new];
    }
    return self;
}

- (void)registerSelector:(SEL)selector key:(int)code modifiers:(NSUInteger)mods
{
    NSNumber *modsKey = @( mods );
    NSMutableDictionary *map = [_codeHandlerMap objectForKey:modsKey];
    if( !map ) {
        map = [NSMutableDictionary dictionary];
        [_codeHandlerMap setObject:map forKey:modsKey];
    }

    NSNumber *codeKey = @( code );
    [map setObject:NSStringFromSelector( selector ) forKey:codeKey];
}

- (void)registerSelector:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods
{
    NSNumber *modsKey = @( mods );
    NSMutableDictionary *map = [_characterHandlerMap objectForKey:modsKey];
    if( !map ) {
        map = [NSMutableDictionary dictionary];
        [_characterHandlerMap setObject:map forKey:modsKey];
    }

    NSNumber *charKey = @( c );
    [map setObject:NSStringFromSelector( selector ) forKey:charKey];
}

- (void)registerSelector:(SEL)selector characters:(NSRange)characterRange modifiers:(NSUInteger)mods
{
    NSNumber *modsKey = @( mods );
    NSMutableDictionary *map = [_characterHandlerMap objectForKey:modsKey];
    if( !map ) {
        map = [NSMutableDictionary dictionary];
        [_characterHandlerMap setObject:map forKey:modsKey];
    }

    int from = characterRange.location;
    int to = NSMaxRange( characterRange );

    for( int i = from; i < to; ++i ) {
        NSNumber *charKey = @( i );
        [map setObject:NSStringFromSelector( selector ) forKey:charKey];
    }
}

- (BOOL)processKeyEvent:(NSEvent *)e
{
    NSInputManager *im = [NSInputManager currentInputManager];
    if( im && [im markedRange].length > 0 ) return NO;

    NSUInteger m = [e modifierFlags];
    m &= NSShiftKeyMask | NSControlKeyMask | NSAlternateKeyMask | NSCommandKeyMask;
    NSNumber *modsKey = @( m );

    NSMutableDictionary *codeMap = [_codeHandlerMap objectForKey:modsKey];
    if( codeMap ) {
        int k = [e keyCode];
        NSNumber *codeKey = @( k );
        NSString *selectorName = [codeMap objectForKey:codeKey];
        if( selectorName ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [_target performSelector:NSSelectorFromString( selectorName )
                          withObject:e];
#pragma clang diagnostic pop
            return YES;
        }
    }

    NSMutableDictionary *characterMap = [_characterHandlerMap objectForKey:modsKey];
    if( characterMap ) {
        NSString *str = [[e charactersIgnoringModifiers] lowercaseString];
        if( str.length ) {
            UniChar c = [str characterAtIndex:0];
            NSNumber *charKey = @( c );
            NSString *selectorName = [characterMap objectForKey:charKey];
            if( selectorName ) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [_target performSelector:NSSelectorFromString( selectorName )
                              withObject:e];
#pragma clang diagnostic pop
                return YES;
            }
        }
    }

    return NO;
}

@end
