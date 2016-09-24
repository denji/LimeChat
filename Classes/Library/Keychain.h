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

@interface Keychain : NSObject

#pragma mark - Internet Keychain

+ (BOOL)testInternetPasswordWithName:(NSString *)name url:(NSURL *)url;
+ (NSString *)internetPasswordWithName:(NSString *)name url:(NSURL *)url;
+ (void)setInternetPassword:(NSString *)password name:(NSString *)name url:(NSURL *)url;
+ (void)addInternetPassword:(NSString *)password name:(NSString *)name url:(NSURL *)url;
+ (void)deleteInternetPasswordWithName:(NSString *)name url:(NSURL *)url;

#pragma mark - Generic Keychain

+ (BOOL)testGenericPasswordWithAccountName:(NSString *)accountName serviceName:(NSString *)serviceName;
+ (NSString *)genericPasswordWithAccountName:(NSString *)accountName serviceName:(NSString *)serviceName;
+ (void)setGenericPassword:(NSString *)password accountName:(NSString *)accountName serviceName:(NSString *)serviceName;
+ (void)addGenericPassword:(NSString *)password accountName:(NSString *)accountName serviceName:(NSString *)serviceName;
+ (void)deleteGenericPasswordWithAccountName:(NSString *)accountName serviceName:(NSString *)serviceName;

@end
