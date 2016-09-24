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

#import <Cocoa/Cocoa.h>

@interface Timer : NSObject

@property ( nonatomic, weak ) id delegate;
@property ( nonatomic ) BOOL reqeat;
@property ( nonatomic ) SEL selector;
@property ( nonatomic, readonly ) BOOL isActive;

- (void)start:(NSTimeInterval)interval;
- (void)stop;

@end

@interface NSObject ( TimerDelegate )
- (void)timerOnTimer:(Timer *)sender;
@end
