/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UITextField {
    
    /// Configura a fonte e texto da label a partir da configuração passada
    internal func setupText(with config: FontConfig) -> Void {
        if let text = config.text {
            self.text = text
        }
        self.font = .systemFont(ofSize: config.fontSize, weight: config.weight)
    }
}
