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

#import "IRCClientConfig.h"
#import "IRCChannelConfig.h"
#import "IgnoreItem.h"
#import "Keychain.h"
#import "NSDictionaryHelper.h"
#import "NSLocaleHelper.h"
#import "NSStringHelper.h"

@implementation IRCClientConfig {
    NSString *_clientID;
}

- (id)init
{
    self = [super init];
    if( self ) {
        _altNicks = [NSMutableArray new];
        _loginCommands = [NSMutableArray new];
        _channels = [NSMutableArray new];
        _autoOp = [NSMutableArray new];
        _ignores = [NSMutableArray new];

        _clientID = [NSString lcf_uuidString];

        _name = @"";
        _host = @"";
        _port = 6667;
        _password = @"";
        _nick = @"";
        _username = @"";
        _realName = @"";
        _nickPassword = @"";

        _proxyHost = @"";
        _proxyPort = 1080;
        _proxyUser = @"";
        _proxyPassword = @"";

        _encoding = NSUTF8StringEncoding;
        _fallbackEncoding = NSISOLatin1StringEncoding;
        _leavingComment = @"Leaving...";
        _userInfo = @"";

        if( [NSLocale prefersJapaneseLanguage] ) {
            _encoding = NSISO2022JPStringEncoding;
        }
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [self init];
    if( self ) {
        _clientID = [dic stringForKey:@"clientID"] ?: [NSString lcf_uuidString];

        _name = [dic stringForKey:@"name"] ?: @"";

        _host = [dic stringForKey:@"host"] ?: @"";
        _port = [dic intForKey:@"port"] ?: 6667;
        _password = [dic stringForKey:@"password"];
        if( !_password ) {
            _password = [Keychain genericPasswordWithAccountName:[self passwordKey] serviceName:[self keychainServiceName]];
            if( !_password ) {
                _password = @"";
            }
        }
        _useSSL = [dic boolForKey:@"ssl"];

        _nick = [dic stringForKey:@"nick"] ?: @"";
        _username = [dic stringForKey:@"username"] ?: @"";
        _realName = [dic stringForKey:@"realname"] ?: @"";
        _nickPassword = [dic stringForKey:@"nickPassword"];
        if( !_nickPassword ) {
            _nickPassword = [Keychain genericPasswordWithAccountName:[self nickPasswordKey] serviceName:[self keychainServiceName]];
            if( !_nickPassword ) {
                _nickPassword = @"";
            }
        }
        if( _nickPassword.length > 0 ) {
            _useSASL = [dic boolForKey:@"useSASL"];
        }
        [_altNicks addObjectsFromArray:[dic arrayForKey:@"alt_nicks"]];

        _proxyType = [dic intForKey:@"proxy"];
        _proxyHost = [dic stringForKey:@"proxy_host"] ?: @"";
        _proxyPort = [dic intForKey:@"proxy_port"] ?: 1080;
        _proxyUser = [dic stringForKey:@"proxy_user"] ?: @"";
        _proxyPassword = [dic stringForKey:@"proxy_password"];
        if( !_proxyPassword ) {
            _proxyPassword = [Keychain genericPasswordWithAccountName:[self proxyPasswordKey] serviceName:[self keychainServiceName]];
            if( !_proxyPassword ) {
                _proxyPassword = @"";
            }
        }

        _autoConnect = [dic boolForKey:@"auto_connect"];
        _encoding = [dic intForKey:@"encoding"] ?: NSUTF8StringEncoding;
        _fallbackEncoding = [dic intForKey:@"fallback_encoding"] ?: NSISOLatin1StringEncoding;
        _leavingComment = [dic stringForKey:@"leaving_comment"] ?: @"";
        _userInfo = [dic stringForKey:@"userinfo"] ?: @"";
        _invisibleMode = [dic boolForKey:@"invisible"];

        [_loginCommands addObjectsFromArray:[dic arrayForKey:@"login_commands"]];

        for( NSDictionary *e in [dic arrayForKey:@"channels"] ) {
            IRCChannelConfig *c = [[IRCChannelConfig alloc] initWithDictionary:e];
            [_channels addObject:c];
        }

        [_autoOp addObjectsFromArray:[dic arrayForKey:@"autoop"]];

        for( NSDictionary *e in [dic arrayForKey:@"ignores"] ) {
            IgnoreItem *ignore = [[IgnoreItem alloc] initWithDictionary:e];
            [_ignores addObject:ignore];
        }
    }
    return self;
}

- (NSMutableDictionary *)dictionaryValueSavingToKeychain:(BOOL)saveToKeychain includingChildren:(BOOL)includingChildren
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if( _clientID ) [dic setObject:_clientID forKey:@"clientID"];

    if( _name ) [dic setObject:_name forKey:@"name"];

    if( _host ) [dic setObject:_host forKey:@"host"];
    [dic setInt:_port forKey:@"port"];
    [dic setBool:_useSSL forKey:@"ssl"];

    if( _nick ) [dic setObject:_nick forKey:@"nick"];
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
    if( _username ) [dic setObject:_username forKey:@"username"];
    if( _realName ) [dic setObject:_realName forKey:@"realname"];
    if( useKeychain && saveToKeychain && _nickPassword.length ) {
        [Keychain setGenericPassword:_nickPassword accountName:[self nickPasswordKey] serviceName:[self keychainServiceName]];
    }
    else {
        [dic setObject:_nickPassword ?: @"" forKey:@"nickPassword"];
    }
    [dic setBool:_useSASL forKey:@"useSASL"];
    if( _altNicks ) [dic setObject:_altNicks forKey:@"alt_nicks"];

    [dic setInt:_proxyType forKey:@"proxy"];
    if( _proxyHost ) [dic setObject:_proxyHost forKey:@"proxy_host"];
    [dic setInt:_proxyPort forKey:@"proxy_port"];
    if( _proxyUser ) [dic setObject:_proxyUser forKey:@"proxy_user"];

    if( useKeychain && saveToKeychain && _proxyPassword.length ) {
        [Keychain setGenericPassword:_proxyPassword accountName:[self proxyPasswordKey] serviceName:[self keychainServiceName]];
    }
    else {
        [dic setObject:_proxyPassword ?: @"" forKey:@"proxy_password"];
    }

    [dic setBool:_autoConnect forKey:@"auto_connect"];
    [dic setInt:_encoding forKey:@"encoding"];
    [dic setInt:_fallbackEncoding forKey:@"fallback_encoding"];
    if( _leavingComment ) [dic setObject:_leavingComment forKey:@"leaving_comment"];
    if( _userInfo ) [dic setObject:_userInfo forKey:@"userinfo"];
    [dic setBool:_invisibleMode forKey:@"invisible"];

    if( _altNicks ) [dic setObject:_loginCommands forKey:@"login_commands"];

    if( includingChildren ) {
        NSMutableArray *channelAry = [NSMutableArray array];
        for( IRCChannelConfig *e in _channels ) {
            [channelAry addObject:[e dictionaryValueSavingToKeychain:saveToKeychain]];
        }
        [dic setObject:channelAry forKey:@"channels"];
    }

    [dic setObject:_autoOp forKey:@"autoop"];

    NSMutableArray *ignoreAry = [NSMutableArray array];
    for( IgnoreItem *e in _ignores ) {
        if( e.isValid ) {
            [ignoreAry addObject:[e dictionaryValue]];
        }
    }
    [dic setObject:ignoreAry forKey:@"ignores"];

    return dic;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[IRCClientConfig alloc] initWithDictionary:[self dictionaryValueSavingToKeychain:NO includingChildren:YES]];
}

- (void)deletePasswordsFromKeychain
{
    [Keychain deleteGenericPasswordWithAccountName:[self passwordKey] serviceName:[self keychainServiceName]];
    [Keychain deleteGenericPasswordWithAccountName:[self nickPasswordKey] serviceName:[self keychainServiceName]];
    [Keychain deleteGenericPasswordWithAccountName:[self proxyPasswordKey] serviceName:[self keychainServiceName]];

    for( IRCChannelConfig *e in _channels ) {
        [e deletePasswordsFromKeychain];
    }
}

- (NSString *)keychainServiceName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

- (NSString *)passwordKey
{
    return [_clientID stringByAppendingString:@"_password"];
}

- (NSString *)nickPasswordKey
{
    return [_clientID stringByAppendingString:@"_nickservPassword"];
}

- (NSString *)proxyPasswordKey
{
    return [_clientID stringByAppendingString:@"_proxyPassword"];
}

@end
