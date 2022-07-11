/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentTagsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Lista de tags que vão ser mostradas no documento
    private var tags: [TagConfig] = []
    
    
    
    /* MARK: - Construtor */
    
    init(tags: [TagConfig]) {
        super.init()
        
        self.tags = tags
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    
    /// Configura uma célula
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row <= 3  {
            // Cria uma variácel para mexer com uma célula que foi criada
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
                return UICollectionViewCell()
            }
            // Configura a célula
            let tag = self.tags[indexPath.row]
            cell.setupTag(with: tag)
            
            // Desativa a seleção
            cell.allowSelection = false
            
            // Borda arredondada
            cell.layer.cornerRadius = collectionView.bounds.height * 0.15
            return cell
        }
        return UICollectionViewCell()
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação para deletar uma linha da tabela
    
    
}
