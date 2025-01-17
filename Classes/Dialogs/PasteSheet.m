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

#import "PasteSheet.h"
#import "NSStringHelper.h"

static NSArray *SYNTAXES;
static NSDictionary *SYNTAX_EXT_MAP;

@implementation PasteSheet {
    GistClient *_gist;
}

- (id)init
{
    self = [super init];
    if( self ) {
        [NSBundle loadNibNamed:@"PasteSheet" owner:self];

        if( !SYNTAXES ) {
            SYNTAXES = [NSArray arrayWithObjects:
                                    @"privmsg", @"notice", @"c", @"css", @"diff", @"html", @"java", @"javascript", @"php", @"plain text", @"python", @"ruby", @"sql", @"shell script", @"perl", @"haskell", @"scheme", @"objective-c", nil];
        }

        if( !SYNTAX_EXT_MAP ) {
            SYNTAX_EXT_MAP = [NSDictionary dictionaryWithObjectsAndKeys:
                                               @"c", @"c", @"css", @"css", @"diff", @"diff", @"hs", @"haskell", @"html", @"html", @"java", @"java", @"js", @"javascript", @"m", @"objective-c", @"pl", @"perl", @"php", @"php", @"txt", @"plain_text", @"py", @"python", @"rb", @"ruby", @"scm", @"scheme", @"sh", @"shell script", @"sql", @"sql", nil, nil];
        }
    }
    return self;
}

- (void)dealloc
{
    [_gist cancel];
}

- (void)start
{
    if( _editMode ) {
        NSArray *lines = [_originalText splitIntoLines];
        _isShortText = lines.count <= 3;
        if( _isShortText ) {
            self.syntax = @"privmsg";
        }
        [self.sheet makeFirstResponder:_bodyText];
    }

    [_syntaxPopup selectItemWithTag:[self tagFromSyntax:_syntax]];
    [_commandPopup selectItemWithTag:[self tagFromSyntax:_command]];
    [_bodyText setString:_originalText];

    if( !NSEqualSizes( _size, NSZeroSize ) ) {
        [self.sheet setContentSize:_size];
    }

    [self startSheet];
}

- (void)pasteOnline:(id)sender
{
    [self setRequesting:YES];

    if( _gist ) {
        [_gist cancel];
    }

    NSString *s = _bodyText.string;
    NSString *fileType = [SYNTAX_EXT_MAP objectForKey:[self syntaxFromTag:_syntaxPopup.selectedTag]];
    if( !fileType ) {
        fileType = @"Text";
    }

    _gist = [GistClient new];
    _gist.delegate = self;
    [_gist send:s fileType:fileType private:YES];
}

- (void)sendInChannel:(id)sender
{
    _command = [self syntaxFromTag:_commandPopup.selectedTag];

    NSString *s = _bodyText.string;

    if( [self.delegate respondsToSelector:@selector( pasteSheet:onPasteText: )] ) {
        [self.delegate pasteSheet:self onPasteText:s];
    }

    [self endSheet];
}

- (void)cancel:(id)sender
{
    if( [self.delegate respondsToSelector:@selector( pasteSheetOnCancel: )] ) {
        [self.delegate pasteSheetOnCancel:self];
    }

    [super cancel:nil];
}

- (void)setRequesting:(BOOL)value
{
    _errorLabel.stringValue = value ? @"Sending…" : @"";
    if( value ) {
        [_uploadIndicator startAnimation:nil];
    }
    else {
        [_uploadIndicator stopAnimation:nil];
    }

    [_pasteOnlineButton setEnabled:!value];
    [_sendInChannelButton setEnabled:!value];
    [_syntaxPopup setEnabled:!value];
    [_commandPopup setEnabled:!value];

    if( value ) {
        [_bodyText setEditable:NO];
        [_bodyText setTextColor:[NSColor disabledControlTextColor]];
        [_bodyText setBackgroundColor:[NSColor windowBackgroundColor]];
    }
    else {
        [_bodyText setTextColor:[NSColor textColor]];
        [_bodyText setBackgroundColor:[NSColor textBackgroundColor]];
        [_bodyText setEditable:YES];
    }
}

- (int)tagFromSyntax:(NSString *)s
{
    NSUInteger n = [SYNTAXES indexOfObject:s];
    if( n != NSNotFound ) {
        return n;
    }
    return -1;
}

- (NSString *)syntaxFromTag:(int)tag
{
    if( 0 <= tag && tag < SYNTAXES.count ) {
        return [SYNTAXES objectAtIndex:tag];
    }
    return nil;
}

#pragma mark - GistClient Delegate

- (void)gistClient:(GistClient *)sender didReceiveResponse:(NSString *)url
{
    _gist = nil;

    [self setRequesting:NO];

    if( url.length ) {
        [_errorLabel setStringValue:@""];

        if( [self.delegate respondsToSelector:@selector( pasteSheet:onPasteURL: )] ) {
            [self.delegate pasteSheet:self onPasteURL:url];
        }

        [self endSheet];
    }
    else {
        [_errorLabel setStringValue:@"Could not get an URL from Gist"];
    }
}

- (void)gistClient:(GistClient *)sender didFailWithError:(NSString *)error statusCode:(int)statusCode
{
    _gist = nil;

    [self setRequesting:NO];
    [_errorLabel setStringValue:[NSString stringWithFormat:@"Gist error: %@", error]];
}

#pragma mark - NSWindow Delegate

- (void)windowWillClose:(NSNotification *)note
{
    _syntax = [self syntaxFromTag:_syntaxPopup.selectedTag];
    _command = [self syntaxFromTag:_commandPopup.selectedTag];

    NSView *contentView = [self.sheet contentView];
    _size = contentView.frame.size;

    if( [self.delegate respondsToSelector:@selector( pasteSheetWillClose: )] ) {
        [self.delegate pasteSheetWillClose:self];
    }
}

@end

