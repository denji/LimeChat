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

class ModeSheet: SheetBase {

    var mode: IRCChannelMode!
    var channelName = ""
    var uid = 0
    var cid = 0
    @IBOutlet var sCheck: NSButton!
    @IBOutlet var pCheck: NSButton!
    @IBOutlet var nCheck: NSButton!
    @IBOutlet var tCheck: NSButton!
    @IBOutlet var iCheck: NSButton!
    @IBOutlet var mCheck: NSButton!
    @IBOutlet var aCheck: NSButton!
    @IBOutlet var rCheck: NSButton!
    @IBOutlet var kCheck: NSButton!
    @IBOutlet var lCheck: NSButton!
    @IBOutlet var kText: NSTextField!
    @IBOutlet var lText: NSTextField!

    /*required */override init() {
        super.init()
        Bundle.main.loadNibNamed("ModeSheet", owner: self, topLevelObjects: nil)
    }

    func start() {
        sCheck.state = mode.s ? 1 : 0
        pCheck.state = mode.p ? 1 : 0
        nCheck.state = mode.n ? 1 : 0
        tCheck.state = mode.t ? 1 : 0
        iCheck.state = mode.i ? 1 : 0
        mCheck.state = mode.m ? 1 : 0
        aCheck.state = mode.a ? 1 : 0
        rCheck.state = mode.r ? 1 : 0
        kCheck.state = (mode.k.characters.count > 0) ? 1 : 0
        lCheck.state = (mode.l > 0) ? 1 : 0

        kText.stringValue = mode.k ?? ""
        lText.stringValue = "\(mode.l)"

        self.updateTextFields()

        if channelName.hasPrefix("!")  {
            aCheck.isEnabled = true
            rCheck.isEnabled = true
        }
        else if channelName.hasPrefix("&")  {
            aCheck.isEnabled = true
            rCheck.isEnabled = false
        }
        else {
            aCheck.isEnabled = false
            rCheck.isEnabled = false
        }

        self.sheet.makeFirstResponder(sCheck)
        self.startSheet()
    }

    func updateTextFields() {
        kText.isEnabled = kCheck.state == NSOnState
        lText.isEnabled = lCheck.state == NSOnState
    }

    func onChangeCheck(_ sender: NSButton!) {
        self.updateTextFields()

        if sCheck.state == NSOnState && pCheck.state == NSOnState  {
            if sender == sCheck  {
                pCheck.state = NSOffState
            }
            else {
                sCheck.state = NSOffState
            }
        }
    }

    func ok(/*_ */sender: NSButton!) {
        mode.s = sCheck.state == NSOnState
        mode.p = pCheck.state == NSOnState
        mode.n = nCheck.state == NSOnState
        mode.t = tCheck.state == NSOnState
        mode.i = iCheck.state == NSOnState
        mode.m = mCheck.state == NSOnState
        mode.a = aCheck.state == NSOnState
        mode.r = rCheck.state == NSOnState

        if kCheck.state == NSOnState  {
            mode.k = kText.stringValue
        }
        else {
            mode.k = ""
        }

        if lCheck.state == NSOnState  {
            mode.l = CInt(lText.stringValue)!
        }
        else {
            mode.l = 0
        }

        delegate?.modeSheet?(onOK: self)

        super.ok(sender)
    }

    // MARK: - NSWindow Delegate

    func windowWillClose(_ note: Notification!) {
        delegate?.modeSheetWillClose?(self)
    }
}
extension NSObject {
    func modeSheet(onOK sender: ModeSheet) {
    }

    func modeSheetWillClose(_ sender: ModeSheet) {
    }
}

