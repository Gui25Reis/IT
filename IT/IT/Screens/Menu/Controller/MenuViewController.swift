/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuViewController: UIViewController, MenuViewControllerDelegate {
    
    /* MARK: - Atributos */
    
    /* Views */
    
    /// View principal que a classe vai controlar
    private let myView = MenuView()
    
    
    /* Outros */
    
    /// Define qual eh o grupo que está selecionado no momento
    private var groupSelected: Int? {
        didSet {
            if let groupSelected {
                self.documentsDataSource.documents = MocData.allDocuments[groupSelected]!
                self.reloadDocumentsAction()
            }
        }
    }
    
    
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
        
        self.setupTestGroupData()
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.setupButtonsAction()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        
        self.setupDelegates()
    }
    

    
    /* MARK: - Delegate (Protocol) */
    
    internal func setGroupSelected(with indexPath: Int) {
        self.groupSelected = indexPath
    }
    
    
    internal func getGroupSelected() -> Int? {
        return self.groupSelected
    }
    
    
    internal func reloadGroupCollection() -> Void {
        self.myView.reloadGroups()
    }
    
    
    internal func openDocumentPage(at documentIndex: Int) -> Void {
        let document = self.documentsDataSource.documents[documentIndex]
        
        let vc = DocumentViewController(with: document)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false)
    }
        
    
    
    /* MARK: - Ações de botões */
    
    /// Apresnera a tela de manter um grupo
    @objc private func showGroupsAction() -> Void {
        let vc = EditGroupController()
        vc.modalPresentationStyle = .overFullScreen
        vc.menuViewControllerDelegate = self
        
        self.present(vc, animated: false)
    }
    
    
    /// Apresenta a tela do documento
    @objc private func showDocumentAction() -> Void {
        let vc = DocumentViewController(with: nil)
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false)
    }
    
    
    /// Apresenta a tela do categorias
    @objc private func showCategoriesAction() -> Void {
        let vc = CategoriesViewController(with: .visualization)
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false)
    }
    
    
    /// Ação de atualizar a view com e os dados das tabelas e collections
    @objc private func reloadDocumentsAction() -> Void {
        self.myView.reloadDocuments()
        //self.reloadGroupCollection()
        self.reloadInputViews()
        self.myView.reloadInputViews()
    }
        
    
    
    /* MARK: - Configurações */
    
    /// Configura os delegates e Data Sources das views
    private func setupDelegates() -> Void {
        // Collection de documentos
        self.documentsDelegate.setDelegate(self)
        self.myView.setDocumentsCollectionDelegate(with: self.documentsDelegate) // collection.delegate = self.documentsDelegate
        
        self.myView.setDocumentsCollectionDataSource(with: self.documentsDataSource)
        
        // Collection de grupos
        self.groupDelegate.setDelegate(self)
        self.myView.setGroupCollectionDelegate(with: self.groupDelegate)
        
        self.groupDataSource.setDelegate(self)
        self.myView.setGroupCollectionDataSource(with: self.groupDataSource)
    
        
        // Atualizando as tabelas
        self.reloadGroupCollection()
        self.myView.reloadDocuments()
    }
    
    
    /// Define as ações dos botões
    private func setupButtonsAction() -> Void {
        self.myView.setNewGroupAction(target: self, action: #selector(self.showGroupsAction))
        
        self.myView.setNewDocumentAction(target: self, action: #selector(self.showDocumentAction))
        
        self.myView.setReloadAction(target: self, action: #selector(self.reloadDocumentsAction))
        
        self.myView.setTagsAction(target: self, action: #selector(self.showCategoriesAction))
    }
    
    
    /// Dados para fazer teste enquanto nào é criado o Core Data
    private func setupTestGroupData() -> Void {
        let tag = TagConfig(text: "Mackenzie", color: nil)
        
        EditGroupController.groups.append(tag)
//        for _ in 0..<5 {
//            EditGroupController.groups.append(tag)
//        }
    }
}
