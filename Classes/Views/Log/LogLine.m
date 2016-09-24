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

#import "LogLine.h"

@implementation LogLine

- (id)init
{
    self = [super init];
    if( self ) {
    }
    return self;
}

+ (NSString *)lineTypeString:(LogLineType)type
{
    switch( type ) {
    case LINE_TYPE_SYSTEM:
        return @"system";
    case LINE_TYPE_ERROR:
        return @"error";
    case LINE_TYPE_REPLY:
        return @"reply";
    case LINE_TYPE_ERROR_REPLY:
        return @"error_reply";
    case LINE_TYPE_DCC_SEND_SEND:
        return @"dcc_send_send";
    case LINE_TYPE_DCC_SEND_RECEIVE:
        return @"dcc_send_receive";
    case LINE_TYPE_PRIVMSG:
        return @"privmsg";
    case LINE_TYPE_NOTICE:
        return @"notice";
    case LINE_TYPE_ACTION:
        return @"action";
    case LINE_TYPE_JOIN:
        return @"join";
    case LINE_TYPE_PART:
        return @"part";
    case LINE_TYPE_KICK:
        return @"kick";
    case LINE_TYPE_QUIT:
        return @"quit";
    case LINE_TYPE_KILL:
        return @"kill";
    case LINE_TYPE_NICK:
        return @"nick";
    case LINE_TYPE_MODE:
        return @"mode";
    case LINE_TYPE_TOPIC:
        return @"topic";
    case LINE_TYPE_INVITE:
        return @"invite";
    case LINE_TYPE_WALLOPS:
        return @"wallops";
    case LINE_TYPE_DEBUG_SEND:
        return @"debug_send";
    case LINE_TYPE_DEBUG_RECEIVE:
        return @"debug_receive";
    }
    return @"";
}

+ (NSString *)memberTypeString:(LogMemberType)type
{
    switch( type ) {
    case MEMBER_TYPE_NORMAL:
        return @"normal";
    case MEMBER_TYPE_MYSELF:
        return @"myself";
    }
    return @"";
}

@end
