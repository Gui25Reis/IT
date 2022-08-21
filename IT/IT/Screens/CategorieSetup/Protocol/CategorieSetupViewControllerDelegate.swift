/* Gui Reis     -    gui.sreis25@gmail.com */

// Bibliotecas necessárias
import class UIKit.UIColor


protocol CategorieSetupViewControllerDelegate: AnyObject {
    
    /// Abre a tela de escolher a cor
    func openColorPicker() -> Void
    
    /// Atualiza a cor selecionada
    func updateColorSelected(to color: UIColor) -> Void
    
    /// Atualiza a quantidade de caractere
    func updateStringCount(to num: Int) -> Void
    
    /// Retorna a quantidade máxima de string permitida
    func getStringCountAllowed() -> Int
}
