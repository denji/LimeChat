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

#import "NSData+Kana.h"

#define ESC 0x1B
#define SO 0x0E
#define SI 0x0F

typedef enum {
    ENC_OTHER,
    ENC_JIS_ROMAN,
    ENC_JIS_KANA,
} KanaEncoding;

@implementation NSData ( Kana )

- (NSData *)convertKanaFromISO2022ToNative
{
    int len = self.length;
    NSMutableData *dest = [NSMutableData dataWithLength:len];
    const unsigned char *src = [self bytes];
    unsigned char *buf = [dest mutableBytes];
    int n = 0;

    KanaEncoding enc = ENC_OTHER;

    for( int i = 0; i < len; ++i ) {
        unsigned char c = src[i];
        if( c == ESC ) {
            BOOL seq = NO;
            if( i + 2 < len ) {
                unsigned char d = src[i + 1];
                unsigned char e = src[i + 2];

                switch( d ) {
                case '$':
                    switch( e ) {
                    case 'B':
                    case 'b':
                    case '@':
                        enc = ENC_OTHER;
                        break;
                    }
                    break;
                case '(':
                    switch( e ) {
                    case 'B':
                    case 'b':
                        enc = ENC_OTHER;
                        break;
                    case 'I':
                    case 'i':
                        enc = ENC_JIS_ROMAN;
                        seq = YES;
                        buf[n++] = ESC;
                        buf[n++] = '(';
                        buf[n++] = 'J';
                        break;
                    }
                    break;
                }

                if( seq ) {
                    i += 2;
                    continue;
                }
            }
        }

        if( enc == ENC_JIS_ROMAN ) {
            if( 0x21 <= c && c <= 0x5F ) {
                c |= 0x80;
            }
        }

        buf[n++] = c;
    }

    [dest setLength:n];
    return dest;
}

- (NSData *)convertKanaFromNativeToISO2022
{
    int len = self.length;
    NSMutableData *dest = [NSMutableData dataWithLength:len];
    const unsigned char *src = [self bytes];
    unsigned char *buf = [dest mutableBytes];
    int n = 0;

    KanaEncoding enc = ENC_OTHER;

    for( int i = 0; i < len; ++i ) {
        unsigned char c = src[i];
        if( c == ESC ) {
            BOOL seq = NO;
            if( i + 2 < len ) {
                unsigned char d = src[i + 1];
                unsigned char e = src[i + 2];

                switch( d ) {
                case '$':
                    switch( e ) {
                    case 'B':
                    case 'b':
                    case '@':
                        enc = ENC_OTHER;
                        break;
                    }
                    break;
                case '(':
                    switch( e ) {
                    case 'B':
                    case 'b':
                        enc = ENC_OTHER;
                        break;
                    case 'J':
                    case 'j':
                        enc = ENC_JIS_ROMAN;
                        seq = YES;
                        buf[n++] = ESC;
                        buf[n++] = '(';
                        buf[n++] = 'I';
                        break;
                    case 'I':
                    case 'i':
                        enc = ENC_JIS_KANA;
                        break;
                    }
                    break;
                }

                if( seq ) {
                    i += 2;
                    continue;
                }
            }
        }

        if( enc == ENC_JIS_ROMAN ) {
            if( c == SO ) {
                enc = ENC_JIS_KANA;
                continue;
            }
        }
        else if( enc == ENC_JIS_KANA ) {
            if( c == SI ) {
                enc = ENC_JIS_ROMAN;
                continue;
            }
        }

        if( enc == ENC_JIS_ROMAN ) {
            if( 0xa1 <= c && c <= 0xDF ) {
                c &= 0x7F;
            }
        }

        buf[n++] = c;
    }

    [dest setLength:n];
    return dest;
}

@end
