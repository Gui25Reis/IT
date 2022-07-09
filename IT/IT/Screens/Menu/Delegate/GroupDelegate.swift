/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class GroupDelegate: NSObject, UICollectionViewDelegate {
    
    /* MARK: - Atributos */
    
    // private let list: [DocumentsCell] = MainCollectionDataSource.sugestionTypes
    
    // private weak var mainDelegate: MainControllerDelegate?
        

    
    /* MARK: - Encapsulamento */
    
//    public func setProtocol(_ delegate: MainControllerDelegate) -> Void {
//        self.mainDelegate = delegate
//    }
    
    
    
    /* MARK: - Delegate */
    
    /// Ação de quando clica em uma célula
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Faz a configuração de atualiazar os dados da tabela
    }
}
