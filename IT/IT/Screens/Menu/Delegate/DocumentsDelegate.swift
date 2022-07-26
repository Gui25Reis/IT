/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentsDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    private weak var delegate: MenuViewControllerDelegate?
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setDelegate(_ delegate: MenuViewControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.openDocumentPage(at: indexPath.row)
    }
}
