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

#import "UserNotificationController.h"

#define USER_NOTIFICATION_CONTEXT_KEY @"context"

@implementation UserNotificationController

- (id)init
{
    self = [super init];
    if( self ) {
        [NSUserNotificationCenter defaultUserNotificationCenter].delegate = self;
    }
    return self;
}

- (void)notify:(UserNotificationType)type title:(NSString *)title desc:(NSString *)desc context:(id)context
{
    switch( type ) {
    case USER_NOTIFICATION_HIGHLIGHT:
        title = [NSString stringWithFormat:@"Highlight: %@", title];
        break;
    case USER_NOTIFICATION_NEW_TALK:
        title = @"New Private Message";
        break;
    case USER_NOTIFICATION_CHANNEL_MSG:
        break;
    case USER_NOTIFICATION_CHANNEL_NOTICE:
        title = [NSString stringWithFormat:@"Notice: %@", title];
        break;
    case USER_NOTIFICATION_TALK_MSG:
        title = @"Private Message";
        break;
    case USER_NOTIFICATION_TALK_NOTICE:
        title = @"Private Notice";
        break;
    case USER_NOTIFICATION_KICKED:
        title = [NSString stringWithFormat:@"Kicked: %@", title];
        break;
    case USER_NOTIFICATION_INVITED:
        title = [NSString stringWithFormat:@"Invited: %@", title];
        break;
    case USER_NOTIFICATION_LOGIN:
        title = [NSString stringWithFormat:@"Logged in: %@", title];
        break;
    case USER_NOTIFICATION_DISCONNECT:
        title = [NSString stringWithFormat:@"Disconnected: %@", title];
        break;
    case USER_NOTIFICATION_FILE_RECEIVE_REQUEST:
        desc = [NSString stringWithFormat:@"From %@\n%@", title, desc];
        title = @"File receive request";
        context = @{ USER_NOTIFICATION_DCC_KEY : @YES };
        break;
    case USER_NOTIFICATION_FILE_RECEIVE_SUCCESS:
        desc = [NSString stringWithFormat:@"From %@\n%@", title, desc];
        title = @"File receive succeeded";
        context = @{ USER_NOTIFICATION_DCC_KEY : @YES };
        break;
    case USER_NOTIFICATION_FILE_RECEIVE_ERROR:
        desc = [NSString stringWithFormat:@"From %@\n%@", title, desc];
        title = @"File receive failed";
        context = @{ USER_NOTIFICATION_DCC_KEY : @YES };
        break;
    case USER_NOTIFICATION_FILE_SEND_SUCCESS:
        desc = [NSString stringWithFormat:@"To %@\n%@", title, desc];
        title = @"File send succeeded";
        context = @{ USER_NOTIFICATION_DCC_KEY : @YES };
        break;
    case USER_NOTIFICATION_FILE_SEND_ERROR:
        desc = [NSString stringWithFormat:@"To %@\n%@", title, desc];
        title = @"File send failed";
        context = @{ USER_NOTIFICATION_DCC_KEY : @YES };
        break;
    default:
        break;
    }

    NSUserNotification *note = [NSUserNotification new];
    note.title = title;
    note.subtitle = desc;
    if( context ) {
        note.userInfo = @{ USER_NOTIFICATION_CONTEXT_KEY : context };
    }

    /*
     if (type == USER_NOTIFICATION_INVITED) {
     note.hasActionButton = YES;
     note.actionButtonTitle = @"Join";
     }
     */

    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center deliverNotification:note];
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)sender didActivateNotification:(NSUserNotification *)note
{
    BOOL actionButtonClicked = note.activationType == NSUserNotificationActivationTypeActionButtonClicked;
    [_delegate notificationControllerDidActivateNotification:[note.userInfo objectForKey:USER_NOTIFICATION_CONTEXT_KEY] actionButtonClicked:actionButtonClicked];
}

@end
