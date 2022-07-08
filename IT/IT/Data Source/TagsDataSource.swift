/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagsDataSource: NSObject, UICollectionViewDataSource {
    
    /* MARK: - Atributos */
    
    
    
    /* MARK: - Construtor */
    
//    init(for book: SuecaCardBook) {
//        self.book = book
//        super.init()
//    }

    
    
    /* MARK: - Encapsulamento */
    
//    public func setDelegate(_ delegate: SuecaControllerDelegate) -> Void {
//        self.delegate = delegate
//    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    
    /// Configura uma célula
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCollectionCell.identifier, for: indexPath) as? MainViewCollectionCell else {
//            return UICollectionViewCell()
//        }
        
        
        return UICollectionViewCell()
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação para deletar uma linha da tabela
    
}
