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

class CustomJSFile: NSObject {
    private var _fileName: String?
    var fileName: String {
        get {
            return _fileName!
        }
        set(value) {
            _fileName = value
            reload()
        }
    }
    fileprivate(set) var content = ""

    func reload() {
        do {
            self.content = try String(contentsOfFile: fileName, encoding: String.Encoding.utf8)
        }
        catch {/* error handling */}
    }

    override init() {
        super.init()
    }
}
