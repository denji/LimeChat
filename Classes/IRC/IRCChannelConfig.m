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

#import "IRCChannelConfig.h"
#import "Keychain.h"
#import "NSDictionaryHelper.h"
#import "NSStringHelper.h"

@implementation IRCChannelConfig {
    NSString *_channelID;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _type = CHANNEL_TYPE_CHANNEL;
        _autoOp = [NSMutableArray new];

        _autoJoin = YES;
        _logToConsole = YES;
        _notify = YES;

        _channelID = [NSString lcf_uuidString];

        _name = @"";
        _password = @"";
        _mode = @"+sn";
        _topic = @"";
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [self init];
    if( self ) {
        _type = [dic intForKey:@"type"];

        _channelID = [dic stringForKey:@"channelID"] ?: [NSString lcf_uuidString];

        _name = [dic stringForKey:@"name"] ?: @"";
        _password = [dic stringForKey:@"password"];
        if( !_password ) {
            _password = [Keychain genericPasswordWithAccountName:[self passwordKey] serviceName:[self keychainServiceName]];
            if( !_password ) {
                _password = @"";
            }
        }

        _autoJoin = [dic boolForKey:@"auto_join"];
        _logToConsole = [dic boolForKey:@"console"];
        if( [dic objectForKey:@"notify"] ) {
            _notify = [dic boolForKey:@"notify"];
        }
        else {
            _notify = [dic boolForKey:@"growl"];
        }

        _mode = [dic stringForKey:@"mode"] ?: @"";
        _topic = [dic stringForKey:@"topic"] ?: @"";

        [_autoOp addObjectsFromArray:[dic arrayForKey:@"autoop"]];
    }
    return self;
}

- (NSMutableDictionary *)dictionaryValueSavingToKeychain:(BOOL)saveToKeychain
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    [dic setInt:_type forKey:@"type"];

    if( _channelID ) [dic setObject:_channelID forKey:@"channelID"];

    if( _name ) [dic setObject:_name forKey:@"name"];
    BOOL useKeychain = YES;
#ifdef DEBUG_BUILD
    useKeychain = NO;
#endif
    if( useKeychain && saveToKeychain && _password.length ) {
        [Keychain setGenericPassword:_password accountName:[self passwordKey] serviceName:[self keychainServiceName]];
    }
    else {
        [dic setObject:_password ?: @"" forKey:@"password"];
    }

    [dic setBool:_autoJoin forKey:@"auto_join"];
    [dic setBool:_logToConsole forKey:@"console"];
    [dic setBool:_notify forKey:@"notify"];

    if( _mode ) [dic setObject:_mode forKey:@"mode"];
    if( _topic ) [dic setObject:_topic forKey:@"topic"];

    if( _autoOp ) [dic setObject:_autoOp forKey:@"autoop"];

    return dic;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[IRCChannelConfig alloc] initWithDictionary:[self dictionaryValueSavingToKeychain:NO]];
}

- (void)deletePasswordsFromKeychain
{
    [Keychain deleteGenericPasswordWithAccountName:[self passwordKey] serviceName:[self keychainServiceName]];
}

- (NSString *)keychainServiceName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)passwordKey
{
    return [_channelID stringByAppendingString:@"_channelPassword"];
}

@end
