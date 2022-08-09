/* Gui Reis     -    gui.sreis25@gmail.com */


protocol MenuViewControllerDelegate: AnyObject {
    /// Define o grupo que foi selecionado
    func setGroupSelected(with indexPath: Int) -> Void
    
    /// Pega o grupo selecionado
    func getGroupSelected() -> Int?
    
    /// Atualiza os dados da collection de grupos
    func reloadGroupCollection() -> Void
    
    /// Abre a página do documento mostrando as informações dele
    func openDocumentPage(at documentIndex: Int) -> Void
}
