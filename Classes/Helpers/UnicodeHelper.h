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

#define UnicodeIsRTLCharacter( c ) ( { __typeof__(c) __c = (c); (0x0590 <= (__c) && (__c) <= 0x08FF || 0xFB1D <= (__c) && (__c) <= 0xFDFD || 0xFE70 <= (__c) && (__c) <= 0xFEFC); } )

@interface UnicodeHelper : NSObject

+ (BOOL)isAlphabeticalCodePoint:(int)c;

@end
