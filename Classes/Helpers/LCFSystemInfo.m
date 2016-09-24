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

#import "LCFSystemInfo.h"

static BOOL initialized;
static SInt32 major;
static SInt32 minor;
static SInt32 bugFix;
static BOOL isMarvericksOrLater;

@implementation LCFSystemInfo

+ (void)_initializeVersionInfo
{
    if( initialized ) {
        return;
    }

    initialized = YES;

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    Gestalt( gestaltSystemVersionMajor, &major );
    Gestalt( gestaltSystemVersionMinor, &minor );
    Gestalt( gestaltSystemVersionBugFix, &bugFix );
#pragma clang diagnostic pop

    isMarvericksOrLater = ( major > 10 ) || ( major == 10 && minor >= 9 );
}

+ (BOOL)isMarvericksOrLater
{
    [self _initializeVersionInfo];
    return isMarvericksOrLater;
}

@end
