/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class GroupDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    private weak var delegate: MenuViewControllerDelegate?
        

    
    /* MARK: - Encapsulamento */
    
    public func setDelegate(_ delegate: MenuViewControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let delegate = self.delegate else {return}
        
        // Define qual céula foi selecionada
        let row = indexPath.row
        
        guard delegate.getGroupSelected() != row else {return}
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagCell else {return}
        
        cell.isSelected = true
        delegate.setGroupSelected(with: row)
    }
}
