/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinksDelegate: NSObject, UITableViewDelegate {
    
    /* MARK: - Atributos */
    
    // private weak var delegate: ?
        

    
    /* MARK: - Encapsulamento */
    
    // public func setDelegate(with delegate: ) -> Void {
    //     self.delegate = delegate
    // }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        // guard let delegate = self.delegate else {return}

        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadInputViews()
    }
}
