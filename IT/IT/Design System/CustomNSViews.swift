/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Cocoa


class CustomNSViews {
    
    static func newButton(with icon: Buttons) -> NSButton {
        let bt = NSButton()
        
        //bt.isBordered = false
        bt.wantsLayer = true
        
        let color: NSColor = .tertiaryLabelColor
        bt.layer?.backgroundColor = color.cgColor
        
        let image = NSImage(buttonType: icon)
        bt.image = image
        bt.imageScaling = .scaleProportionallyUpOrDown
        
        //bt.bezelStyle = .regularSquare
        //bt.bezelColor = color
        
        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }
    
    
    static func newSearchField() -> NSSearchField {
        let sf = NSSearchField(labelWithString: "Faça uma busca")
        sf.needsLayout = true
        
        let color: NSColor = .tertiaryLabelColor
        sf.layer?.backgroundColor = color.cgColor
        
        sf.backgroundColor = color
        
                
        sf.translatesAutoresizingMaskIntoConstraints = false
        return sf
    }
    
}
