/* Gui Reis     -    gui.sreis25@gmail.com */


protocol LinkSetupViewControllerDelegate: AnyObject {
    
    /// Verifica se uma string é um URL
    func validateUrl(with url: String?) -> Void
}
