/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    public var documents: [Document] = []
    
    private var dataSources: [Int: DocumentTagsDataSource] = [:]
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        var document = Document(
            group: "Teste",
            categories: [
                TagConfig(text: "Teste", color: .tertiaryLabel),
                TagConfig(text: "Teste", color: .tertiaryLabel),
                TagConfig(text: "Teste", color: .tertiaryLabel)
            ],
            title: "Título do documento nº !!!!",
            links: [
                LinkInfo(
                    name: "Esconder scroll", categorie: TagConfig(text: "", color: nil),
                    link: "https://kings-gui.notion.site/Como-esconder-a-barra-de-rolagem-scroll-bar-da-Collection-ecfe3bc7538a482c8a052f2d0e35c6e6"
                ),
                LinkInfo(
                    name: "Padrão de comentários", categorie: TagConfig(text: "", color: nil),
                    link: "https://kings-gui.notion.site/Padroniza-o-do-c-digo-cf5fd2bdeee448da892c462bd02fc572"
                )
            ]
        )
        
        for num in 0..<70 {
            document.title = "Título do documento nº\(num+1) !!!!"
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
