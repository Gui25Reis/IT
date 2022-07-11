/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UIButton {
    
    /// Configura a fonte e texto do botão a partir da configuração passada
    internal func setupText(with config: FontConfig) -> Void {
        if let text = config.text {
            self.setTitle(text, for: .normal)
        }
        self.titleLabel?.font = UIFont.systemFont(ofSize: config.fontSize, weight: config.weight)
    }
}
