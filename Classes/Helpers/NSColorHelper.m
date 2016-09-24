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

#import "NSColorHelper.h"

@implementation NSColor ( NSColorHelper )

+ (NSColor *)fromCSS:(NSString *)s
{
    if( [s hasPrefix:@"#"] ) {
        s = [s substringFromIndex:1];

        int len = s.length;
        if( len == 6 ) {
            long n = strtol( [s UTF8String], NULL, 16 );
            int r = ( n >> 16 ) & 0xff;
            int g = ( n >> 8 ) & 0xff;
            int b = n & 0xff;
            return DEVICE_RGB( r, g, b );
        }
        else if( len == 3 ) {
            long n = strtol( [s UTF8String], NULL, 16 );
            int r = ( n >> 8 ) & 0xf;
            int g = ( n >> 4 ) & 0xf;
            int b = n & 0xf;
            return [NSColor colorWithDeviceRed:r / 15.0 green:g / 15.0 blue:b / 15.0 alpha:1];
        }
    }
    else if( s ) {
        static NSRegularExpression *rgba = nil;
        if( !rgba ) {
            NSString *pattern = @"rgba\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d*(?:\\.\\d+))\\s*\\)";
            rgba = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
        }

        NSTextCheckingResult *result = [rgba firstMatchInString:s options:0 range:NSMakeRange( 0, s.length )];
        if( result && result.numberOfRanges > 4 ) {
            int r = [[s substringWithRange:[result rangeAtIndex:1]] intValue];
            int g = [[s substringWithRange:[result rangeAtIndex:2]] intValue];
            int b = [[s substringWithRange:[result rangeAtIndex:3]] intValue];
            float a = [[s substringWithRange:[result rangeAtIndex:4]] floatValue];
            return DEVICE_RGBA( r, g, b, a );
        }

        static NSRegularExpression *rgb = nil;
        if( !rgb ) {
            NSString *pattern = @"rgb\\(\\s*(\\d+)\\s*,\\s*(\\d+)\\s*,\\s*(\\d+)\\s*\\)";
            rgb = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
        }

        result = [rgb firstMatchInString:s options:0 range:NSMakeRange( 0, s.length )];
        if( result && result.numberOfRanges > 3 ) {
            int r = [[s substringWithRange:[result rangeAtIndex:1]] intValue];
            int g = [[s substringWithRange:[result rangeAtIndex:2]] intValue];
            int b = [[s substringWithRange:[result rangeAtIndex:3]] intValue];
            return DEVICE_RGB( r, g, b );
        }
    }

    static NSDictionary *nameMap = nil;
    if( !nameMap ) {
        nameMap = [NSDictionary dictionaryWithObjectsAndKeys:
                                    DEVICE_RGB( 0, 0, 0 ), @"black", DEVICE_RGB( 0xC0, 0xC0, 0xC0 ), @"silver", DEVICE_RGB( 0x80, 0x80, 0x80 ), @"gray", DEVICE_RGB( 0xFF, 0xFF, 0xFF ), @"white", DEVICE_RGB( 0x80, 0, 0 ), @"maroon", DEVICE_RGB( 0xFF, 0, 0 ), @"red", DEVICE_RGB( 0x80, 0, 0x80 ), @"purple", DEVICE_RGB( 0xFF, 0, 0xFF ), @"fuchsia", DEVICE_RGB( 0, 0x80, 0 ), @"green", DEVICE_RGB( 0, 0xFF, 0 ), @"lime", DEVICE_RGB( 0x80, 0x80, 0 ), @"olive", DEVICE_RGB( 0xFF, 0xFF, 0 ), @"yellow", DEVICE_RGB( 0, 0, 0x80 ), @"navy", DEVICE_RGB( 0, 0, 0xFF ), @"blue", DEVICE_RGB( 0, 0x80, 0x80 ), @"teal", DEVICE_RGB( 0, 0xFF, 0xFF ), @"aqua", DEVICE_RGBA( 0, 0, 0, 0 ), @"transparent", nil];
    }

    return [nameMap objectForKey:[s lowercaseString]];
}

@end
