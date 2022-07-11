/* Gui Reis     -    gui.sreis25@gmail.com */


protocol MenuViewControllerDelegate: AnyObject {
    /// Define o grupo que foi selecionado
    func setGroupSelected(with indexPath: Int) -> Void
    
    /// Pega o grupo selecionado
    func getGroupSelected() -> Int
}
