/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UIButton {
    
    /// Configura o ícone do botão a partir da configuração passada
    internal func setupIcon(with config: IconConfig) -> Void {
        
        let configIcon = UIImage.SymbolConfiguration(
            pointSize: config.size,
            weight: config.weight,
            scale: config.scale
        )
        
        let image = UIImage(systemName: config.icon.description, withConfiguration: configIcon)
        self.setImage(image, for: .normal)
        
//        if let btColor = UIColor(appColor: .button) {
//            self.tintColor = btColor
//        }
    }
}
