// Copyright (C) 2016      Denis Denisov <denji0k AT gmail DOT com>
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

import Foundation

class InviteSheet: SheetBase {
    var nicks = [String]()
    var uid = 0
    @IBOutlet var titleLabel: NSTextField!
    @IBOutlet var channelPopup: NSPopUpButton!
    
    func start(withChannels channels: [String]) {
        var target: String
        if nicks.count == 1 {
            target = nicks[0]
        }
        else if nicks.count == 2 {
            let first = nicks[0]
            let second = nicks[1]
            target = "\(first) and \(second)"
        }
        else {
            target = "\(Int(nicks.count)) users"
        }
        
        self.titleLabel.stringValue = "Invite \(target) to:"
        for s: String in channels {
            channelPopup.addItem(withTitle: s)
        }
        self.startSheet()
    }
    
    func invite(_ sender: Any) {
        let channelName = channelPopup.selectedItem!.title
        delegate!.inviteSheet?(self, onSelectChannel: channelName)
        self.endSheet()
    }
    
    
    override init() {
        super.init()
        Bundle.main.loadNibNamed("InviteSheet", owner: self, topLevelObjects: nil)
        
    }
    // MARK: - NSWindow Delegate
    
    func windowWillClose(_ note: Notification) {
        if self.delegate!.responds(to: #selector(self.inviteSheetWillClose)) {
            self.delegate!.inviteSheetWillClose(self)
        }
    }
}
extension NSObject {
    func inviteSheet(_ sender: InviteSheet, onSelectChannel channelName: String) {
    }
    
    func inviteSheetWillClose(_ sender: InviteSheet) {
    }
}
