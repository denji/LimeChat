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

class NickSheet: SheetBase {
    var uid = 0
    @IBOutlet var currentText: NSTextField!
    @IBOutlet var nextText: NSTextField!

    func start(_ nick: String) {
        currentText.stringValue = nick
        nextText.stringValue = nick
        self.sheet.makeFirstResponder(nextText)
        self.start(nick)
    }

    override init() {
        super.init()
        Bundle.main.loadNibNamed("NickSheet", owner: self, topLevelObjects: nil)
    }

    func ok(/*_ */sender: NickSheet) {
        delegate?.nickSheet?(sender, didInputNick: nextText.stringValue)
        super.ok(sender)
    }

    // MARK: - NSWindow Delegate
    func windowWillClose(_ note: Notification) {
        delegate?.nickSheetWillClose?(self)
    }
}
extension NSObject {
    func nickSheet(_ sender: NickSheet, didInputNick nick: String) {
    }
    
    func nickSheetWillClose(_ sender: NickSheet) {
    }
}

