/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    private var documents: [Document] = []
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        let document = Document(
            group: "Teste",
            categories: [TagConfig(text: "Teste", color: .cyan), TagConfig(text: "Teste", color: .cyan)],
            title: "Título do documento!!!!"
        )
        
        for _ in 0..<70 {
            self.documents.append(document)
        }
    }

    
    
    /* MARK: - Encapsulamento */
    
//    public func setDelegate(_ delegate: SuecaControllerDelegate) -> Void {
//        self.delegate = delegate
//    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.documents.count
    }
    
    
    /// Configura uma célula
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DocumentsCell.identifier, for: indexPath) as? DocumentsCell else {
            return UICollectionViewCell()
        }
        
        let document = self.documents[indexPath.row]
        cell.setupCell(with: document)
        
        // collectionView.reloadData()
        return cell
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação para deletar uma linha da tabela
    
    
}