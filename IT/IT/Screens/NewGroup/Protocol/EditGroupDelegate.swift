/* Gui Reis     -    gui.sreis25@gmail.com */


protocol EditGroupDelegate: AnyObject {
    
    /// Verifica se é um novo grupo que vai ser adicionado
    func isNewGroup(at index: Int) -> Bool
    
    /// Atualiza o novo grupo criado
    func updateNewGroup(at index: Int, with text: String) -> Void
}
