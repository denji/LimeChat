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

#import "SoundWrapper.h"
#import "Preferences.h"
#import "SoundPlayer.h"

@implementation SoundWrapper {
    UserNotificationType _eventType;
}

- (id)initWithEventType:(UserNotificationType)aEventType
{
    self = [super init];
    if( self ) {
        _eventType = aEventType;
    }
    return self;
}

+ (SoundWrapper *)soundWrapperWithEventType:(UserNotificationType)eventType
{
    return [[SoundWrapper alloc] initWithEventType:eventType];
}

- (NSString *)displayName
{
    return [Preferences titleForEvent:_eventType];
}

- (NSString *)sound
{
    NSString *sound = [Preferences soundForEvent:_eventType];

    if( sound.length == 0 ) {
        return EMPTY_SOUND;
    }
    else {
        return sound;
    }
}

- (void)setSound:(NSString *)value
{
    if( [value isEqualToString:EMPTY_SOUND] ) {
        value = @"";
    }

    if( value.length ) {
        [SoundPlayer play:value];
    }
    [Preferences setSound:value forEvent:_eventType];
}

- (BOOL)notification
{
    return [Preferences userNotificationEnabledForEvent:_eventType];
}

- (void)setNotification:(BOOL)value
{
    [Preferences setUserNotificationEnabled:value forEvent:_eventType];
}

@end
