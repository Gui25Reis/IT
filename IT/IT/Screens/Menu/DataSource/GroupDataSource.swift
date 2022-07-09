/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class GroupDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    private var groups: [TagConfig] = []
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        let tag = TagConfig(text: "Academy", color: nil)
        
        for _ in 0..<5 {
            self.groups.append(tag)
        }
    }

    
    
    /* MARK: - Encapsulamento */
    
//    public func setDelegate(_ delegate: SuecaControllerDelegate) -> Void {
//        self.delegate = delegate
//    }
    
    
    
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
        
        let tag = self.groups[indexPath.row]
        cell.setupTag(with: tag)
        
        cell.layer.cornerRadius = collectionView.bounds.height * 0.52
        
        return cell
    }
}
