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

#import "LogTheme.h"
#import "OtherTheme.h"
#import <LimeChat-Swift.h>
#import <Cocoa/Cocoa.h>

@interface ViewTheme : NSObject

@property ( nonatomic ) NSString *name;
@property ( nonatomic, readonly ) LogTheme *log;
@property ( nonatomic, readonly ) OtherTheme *other;
@property ( nonatomic, readonly ) CustomJSFile *js;

- (void)reload;

+ (void)createUserDirectory;

+ (NSString *)buildResourceFileName:(NSString *)name;
+ (NSString *)buildUserFileName:(NSString *)name;
+ (NSArray *)extractFileName:(NSString *)source;

+ (NSString *)resourceBasePath;
+ (NSString *)userBasePath;

@end
