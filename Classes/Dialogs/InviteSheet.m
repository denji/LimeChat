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

#import "InviteSheet.h"

@implementation InviteSheet

- (id)init
{
    self = [super init];
    if( self ) {
        [NSBundle loadNibNamed:@"InviteSheet" owner:self];
    }
    return self;
}

- (void)startWithChannels:(NSArray *)channels
{
    NSString *target;
    if( _nicks.count == 1 ) {
        target = [_nicks objectAtIndex:0];
    }
    else if( _nicks.count == 2 ) {
        NSString *first = [_nicks objectAtIndex:0];
        NSString *second = [_nicks objectAtIndex:1];
        target = [NSString stringWithFormat:@"%@ and %@", first, second];
    }
    else {
        target = [NSString stringWithFormat:@"%d users", (int)_nicks.count];
    }
    _titleLabel.stringValue = [NSString stringWithFormat:@"Invite %@ to:", target];

    for( NSString *s in channels ) {
        [_channelPopup addItemWithTitle:s];
    }

    [self startSheet];
}

- (void)invite:(id)sender
{
    NSString *channelName = [[_channelPopup selectedItem] title];

    if( [self.delegate respondsToSelector:@selector( inviteSheet:onSelectChannel: )] ) {
        [self.delegate inviteSheet:self onSelectChannel:channelName];
    }

    [self endSheet];
}

#pragma mark - NSWindow Delegate

- (void)windowWillClose:(NSNotification *)note
{
    if( [self.delegate respondsToSelector:@selector( inviteSheetWillClose: )] ) {
        [self.delegate inviteSheetWillClose:self];
    }
}

@end
