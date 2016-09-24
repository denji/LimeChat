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

typedef enum {
    USER_NOTIFICATION_HIGHLIGHT,
    USER_NOTIFICATION_NEW_TALK,
    USER_NOTIFICATION_CHANNEL_MSG,
    USER_NOTIFICATION_CHANNEL_NOTICE,
    USER_NOTIFICATION_TALK_MSG,
    USER_NOTIFICATION_TALK_NOTICE,
    USER_NOTIFICATION_KICKED,
    USER_NOTIFICATION_INVITED,
    USER_NOTIFICATION_LOGIN,
    USER_NOTIFICATION_DISCONNECT,
    USER_NOTIFICATION_FILE_RECEIVE_REQUEST,
    USER_NOTIFICATION_FILE_RECEIVE_SUCCESS,
    USER_NOTIFICATION_FILE_RECEIVE_ERROR,
    USER_NOTIFICATION_FILE_SEND_SUCCESS,
    USER_NOTIFICATION_FILE_SEND_ERROR,
    USER_NOTIFICATION_COUNT,
} UserNotificationType;

#define USER_NOTIFICATION_DCC_KEY @"dcc"
#define USER_NOTIFICATION_CLIENT_ID_KEY @"clientId"
#define USER_NOTIFICATION_CHANNEL_ID_KEY @"channelId"
#define USER_NOTIFICATION_INVITED_CHANNEL_NAME_KEY @"invitedChannelName"

@protocol NotificationControllerDelegate <NSObject>
- (void)notificationControllerDidActivateNotification:(id)context actionButtonClicked:(BOOL)actionButtonClicked;
@end

@protocol NotificationController <NSObject>
@property ( nonatomic, weak ) id<NotificationControllerDelegate> delegate;
- (void)notify:(UserNotificationType)type title:(NSString *)title desc:(NSString *)desc context:(id)context;
@end
