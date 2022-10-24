/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class MocData {
    
    static var allDocuments: [Int:[DocumentInfo]] = [:]
    
    static var favDocuments: [DocumentInfo] = []
}


class DocumentsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    public var documents: [DocumentInfo] = []
    
    private var dataSources: [Int: DocumentTagsDataSource] = [:]
    
    
    
    /* MARK: - Construtor */
    
    override init() {
        super.init()
        
        var document = DocumentInfo(
            id: 0,
            group: "",
            categories: [
                TagConfig(text: "Código", color: .tertiaryLabel),
                TagConfig(text: "Documentação", color: .tertiaryLabel)
            ],
            title: "Aula de scroll",
            links: [
                LinkInfo(
                    id: 10, title: "Esconder scroll",
                    link: "https://kings-gui.notion.site/Como-esconder-a-barra-de-rolagem-scroll-bar-da-Collection-ecfe3bc7538a482c8a052f2d0e35c6e6",
                    documents: []
                ),
                LinkInfo (
                    id: 11, title: "Padrão de comentários",
                    link: "https://kings-gui.notion.site/Padroniza-o-do-c-digo-cf5fd2bdeee448da892c462bd02fc572",
                    documents: []
                )
            ],
            isFavorited: false
        )
        
        if MocData.allDocuments[0] == nil {
            MocData.allDocuments[0] = [document]
            self.documents = [document]
        }
                
        self.documents[0].isFavorited = true
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
