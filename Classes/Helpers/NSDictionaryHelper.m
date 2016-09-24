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

#import "NSDictionaryHelper.h"
#import "NSStringHelper.h"

@implementation NSDictionary ( NSDictionaryHelper )

- (BOOL)boolForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj respondsToSelector:@selector( boolValue )] ) {
        return [obj boolValue];
    }
    return NO;
}

- (int)intForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj respondsToSelector:@selector( intValue )] ) {
        return [obj intValue];
    }
    return 0;
}

- (long long)longLongForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj respondsToSelector:@selector( longLongValue )] ) {
        return [obj longLongValue];
    }
    return 0;
}

- (double)doubleForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj respondsToSelector:@selector( doubleValue )] ) {
        return [obj doubleValue];
    }
    return 0;
}

- (NSString *)stringForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj isKindOfClass:[NSString class]] ) {
        return obj;
    }
    return nil;
}

- (NSDictionary *)dictionaryForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj isKindOfClass:[NSDictionary class]] ) {
        return obj;
    }
    return nil;
}

- (NSArray *)arrayForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if( [obj isKindOfClass:[NSArray class]] ) {
        return obj;
    }
    return nil;
}

@end

@implementation NSMutableDictionary ( NSMutableDictionaryHelper )

- (void)setBool:(BOOL)value forKey:(NSString *)key
{
    [self setObject:@( value ) forKey:key];
}

- (void)setInt:(int)value forKey:(NSString *)key
{
    [self setObject:@( value ) forKey:key];
}

- (void)setLongLong:(long long)value forKey:(NSString *)key
{
    [self setObject:@( value ) forKey:key];
}

- (void)setDouble:(double)value forKey:(NSString *)key
{
    [self setObject:@( value ) forKey:key];
}

@end
