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
#import <WebKit/WebKit.h>

@interface LogView : WebView

@property ( nonatomic, weak ) id keyDelegate;
@property ( nonatomic, weak ) id resizeDelegate;

- (NSString *)contentString;

- (void)clearSelection;
- (BOOL)hasSelection;
- (NSString *)selection;

@end

@interface NSObject ( LogViewDelegate )
- (void)logViewKeyDown:(NSEvent *)e;
- (void)logViewWillResize;
- (void)logViewDidResize;
@end
