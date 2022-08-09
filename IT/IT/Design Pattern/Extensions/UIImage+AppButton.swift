/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UIImage {
        
    /// Cria uma imagem a partir do ícone passado
    convenience init?(icon: AppButton) {
        self.init(systemName: icon.description)
    }
}
