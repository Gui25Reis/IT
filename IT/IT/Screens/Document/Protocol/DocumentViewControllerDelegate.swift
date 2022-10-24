/* Gui Reis     -    gui.sreis25@gmail.com */


protocol DocumentControllerDelegate: AnyObject {
    /// Abre a tela de edição do link que foi selecionado
    func openLinkPage(with index: Int?) -> Void
    
    /// Define qual página da web vai ser visualizada no web Preview
    func openLinkOnWebView(for index: Int) -> Void
    
    /// Retorna o link que está no preview
    func getActualLinkPreview() -> Int
    
    /// Copia no clipboard as inforamações do link selecionado
    func copyLinkinfo(for index: Int) -> Void
    
    /// Deleta o link
    func deleteLink(for index: Int)
    
    /// Copia no clipboard as inforamações do link selecionado
    func openLinkOnBrowser(for index: Int) -> Void
}
