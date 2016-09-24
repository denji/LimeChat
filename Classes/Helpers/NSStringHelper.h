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

#import <Foundation/Foundation.h>

#define IsNumeric( c ) ( '0' <= ( c ) && ( c ) <= '9' )
#define IsAlpha( c ) ( 'a' <= ( c ) && ( c ) <= 'z' || 'A' <= ( c ) && ( c ) <= 'Z' )
#define IsAlphaNum( c ) ( IsAlpha( c ) || IsNumeric( c ) )
#define IsWordLetter( c ) ( IsAlphaNum( c ) || ( c ) == '_' )
#define IsAlphaWithDiacriticalMark( c ) ( 0xc0 <= c && c <= 0xff && c != 0xd7 && c != 0xf7 )

@interface NSString ( NSStringHelper )

- (const UniChar *)getCharactersBuffer;
- (BOOL)isEqualNoCase:(NSString *)other;
- (BOOL)contains:(NSString *)str;
- (BOOL)containsIgnoringCase:(NSString *)str;
- (int)findCharacter:(UniChar)c;
- (int)findCharacter:(UniChar)c start:(int)start;
- (NSArray *)split:(NSString *)delimiter;
- (NSArray *)splitIntoLines;
- (NSString *)trim;

- (BOOL)isAlphaNumOnly;
- (BOOL)isNumericOnly;

- (NSString *)safeUsername;
- (NSString *)safeFileName;

- (NSString *)stripMIRCEffects;

- (NSRange)rangeOfUrl;
- (NSRange)rangeOfUrlStart:(int)start;

- (NSRange)rangeOfAddress;
- (NSRange)rangeOfAddressStart:(int)start;

- (NSRange)rangeOfChannelName;
- (NSRange)rangeOfChannelNameStart:(int)start;

- (NSString *)encodeURIComponent;
- (NSString *)encodeURIFragment;

- (BOOL)isChannelName;
- (BOOL)isModeChannelName;
- (NSString *)canonicalName;

- (NSString *)lcf_stringByRemovingCrashingSequences;
+ (NSString *)lcf_uuidString;

@end

@interface NSMutableString ( NSMutableStringHelper )

- (NSString *)getToken;
- (NSString *)getIgnoreToken;

@end
