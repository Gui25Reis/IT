/* Gui Reis     -    gui.sreis25@gmail.com */


protocol DocumentControllerDelegate: AnyObject {
    /// Define o grupo que foi selecionado
    func openLinkPage(with index: Int?) -> Void
    
    /// Define qual páfina vai ser visualizada
    func openLinkView(for index: Int) -> Void
    
    /// Retorna o link que está no preview
    func getActualLinkPreview() -> Int
}
