/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class ColorPickerDelegate: NSObject, UIColorPickerViewControllerDelegate {
    
    /* MARK: - Atributos */
    
    private weak var delegate: CategorieSetupViewControllerDelegate?
        

    
    /* MARK: - Encapsulamento */
    
     public func setDelegate(with delegate: CategorieSetupViewControllerDelegate) -> Void {
         self.delegate = delegate
     }
    
    
    
    /* MARK: - Delegate */
    
    internal func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
        self.delegate?.updateColorSelected(to: color)
        
        viewController.dismiss(animated: true)
    }
}
