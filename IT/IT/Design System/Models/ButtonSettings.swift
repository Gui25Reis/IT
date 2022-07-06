/* Gui Reis    -    gui.sreis25@gmail.com */


import Cocoa

/// Informações para configuração inicial do botão apenas com ícone
struct ButtonSettings {
    // Ícone
    let icon: String
    let size: CGFloat
    // let weight: NSImage.SymbolWeight
    // let scale: NSImage.SymbolScale
    
    // Ação
    let target: Any?
    let action: Selector
}
