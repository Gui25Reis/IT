/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuViewController: UIViewController {
    
    /* MARK: - Atributos */
    
    /// View principal que a classe vai controlar
    private let myView = MenuView()
    
    
    /* Delegates & DataSource */
    
    /// Delegate da collection dos documentos
    private let documentsDelegate = DocumentsDelegate()
    
    /// Data Source da collection dos documentos
    private let documentsDataSource = DocumentsDataSource()
    
    /// Delegate da collection dos grupos
    private let groupDelegate = GroupDelegate()
    
    /// Data Source da collection dos grupos
    private let groupDataSource = GroupDataSource()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        
        self.setupDelegates()
    }
    

    
    /* MARK: - Ações de botões */
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os delegates e Data Sources das views
    private func setupDelegates() -> Void {
        // Collection de documentos
        self.myView.setDocumentsCollectionDelegate(with: self.documentsDelegate)
        self.myView.setDocumentsCollectionDataSource(with: self.documentsDataSource)
        
        // Collection de grupos
        self.myView.setGroupCollectionDelegate(with: self.groupDelegate)
        self.myView.setGroupCollectionDataSource(with: self.groupDataSource)
        
        // Atualizando as tabelas
        self.myView.reloadGroups()
        self.myView.reloadDocuments()
    }
}
