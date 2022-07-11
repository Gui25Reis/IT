/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    private var documents: [Document] = []
    
    private var dataSources: [Int: DocumentTagsDataSource] = [:]
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        let document = Document(
            group: "Teste",
            categories: [
                TagConfig(text: "Teste", color: .tertiaryLabel),
                TagConfig(text: "Teste", color: .tertiaryLabel),
                TagConfig(text: "Teste", color: .tertiaryLabel)
            ],
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
        
        
        let documentTagsDataSource = DocumentTagsDataSource(tags: document.categories)
        self.dataSources[indexPath.row] = documentTagsDataSource
        
        cell.setTagsCollectionDataSource(with: documentTagsDataSource)
        return cell
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação para deletar uma linha da tabela
    
    
}
