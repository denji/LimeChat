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

#import "ListView.h"
#import "OtherTheme.h"
#import <Cocoa/Cocoa.h>

@interface MemberListView : ListView

@property ( nonatomic, weak ) id dropDelegate;
@property ( nonatomic ) OtherTheme *theme;

- (void)themeChanged;

@end

@interface NSObject ( MemberListView )
- (void)memberListViewKeyDown:(NSEvent *)e;
- (void)memberListViewDropFiles:(NSArray *)files row:(NSNumber *)row;
@end
