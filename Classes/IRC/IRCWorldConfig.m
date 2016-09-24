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

#import "IRCWorldConfig.h"
#import "IRCClientConfig.h"
#import "NSDictionaryHelper.h"

@implementation IRCWorldConfig

- (id)init
{
    self = [super init];
    if( self ) {
        _clients = [NSMutableArray new];
        _autoOp = [NSMutableArray new];
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic
{
    self = [self init];
    if( self ) {
        NSArray *ary = [dic arrayForKey:@"clients"] ?: [dic arrayForKey:@"units"];

        for( NSDictionary *e in ary ) {
            IRCClientConfig *c = [[IRCClientConfig alloc] initWithDictionary:e];
            [_clients addObject:c];
        }

        [_autoOp addObjectsFromArray:[dic arrayForKey:@"autoop"]];
    }
    return self;
}

- (NSMutableDictionary *)dictionaryValueSavingToKeychain:(BOOL)saveToKeychain includingChildren:(BOOL)includingChildren
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    if( includingChildren ) {
        NSMutableArray *clientAry = [NSMutableArray array];
        for( IRCClientConfig *e in _clients ) {
            [clientAry addObject:[e dictionaryValueSavingToKeychain:saveToKeychain includingChildren:includingChildren]];
        }
        [dic setObject:clientAry forKey:@"clients"];
    }

    [dic setObject:_autoOp forKey:@"autoop"];

    return dic;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [[IRCWorldConfig alloc] initWithDictionary:[self dictionaryValueSavingToKeychain:NO includingChildren:YES]];
}

@end
