/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    /* MARK: - Atributos */
    
    private weak var delegate: CategorieSetupViewControllerDelegate?
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setDelegate(with delegate: CategorieSetupViewControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Função responsável por permitir se pode ou não digitar no textfield
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = self.delegate {
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)
            
            return newString.count <= delegate.getStringCountAllowed()
        }
        return false
    }
    
    
    /// Essa função faz com que a tecla return do teclado faça o app aceitar a entrada e o teclado abaixe
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.returnKeyType = .done
        textField.resignFirstResponder()
        return true
    }
}
