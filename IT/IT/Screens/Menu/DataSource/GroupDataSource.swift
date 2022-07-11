/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class GroupDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    private var groups: [TagConfig] = []
    
    private var delegate: MenuViewControllerDelegate?
    
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        let tag = TagConfig(text: "Academy", color: nil)
        
        for _ in 0..<5 {
            self.groups.append(tag)
        }
    }

    
    
    /* MARK: - Encapsulamento */
    
    public func setDelegate(_ delegate: MenuViewControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    
    /// Configura uma célula
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        let row = indexPath.row
        
        // Configurando célula
        let tag = self.groups[row]
        cell.setupTag(with: tag)
        
        // UI
        cell.layer.cornerRadius = collectionView.bounds.height * 0.52
        
        
        // Definindo a célula selecionada inicial
        if let delegate = self.delegate {
            if row == 0 {
                delegate.setGroupSelected(with: row)
                cell.isSelected = true
                
                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
            }
            cell.isSelected = (delegate.getGroupSelected() == row)
        }
        
        return cell
    }
}
