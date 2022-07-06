/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Cocoa


extension NSImage {
    
    convenience init?(buttonType: Buttons) {
        self.init(systemSymbolName: buttonType.description, accessibilityDescription: "")
    }
}
