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
    private var groupSelected: Int?
    
    
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
        let vc = DocumentViewController(with: self.getDocumentTest())
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false)
    }
        
    
    
    /* MARK: - Configurações */
    
    /// Configura os delegates e Data Sources das views
    private func setupDelegates() -> Void {
        // Collection de documentos
        self.myView.setDocumentsCollectionDelegate(with: self.documentsDelegate)
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
    }
    
    
    /// Dados para fazer teste enquanto nào é criado o Core Data
    private func setupTestGroupData() -> Void {
        let tag = TagConfig(text: "Academy", color: nil)
        
        for _ in 0..<5 {
            EditGroupController.groups.append(tag)
        }
    }
    
    
    
    private func getDocumentTest() -> Document {
        return Document(
            group: "Academy",
            categories: [
                TagConfig(text: "Categoria", color: .red),
                TagConfig(text: "Categoria", color: .blue),
                TagConfig(text: "Categoria", color: .brown),
                TagConfig(text: "Categoria", color: .yellow),
                TagConfig(text: "Categoria", color: .orange)
            ],
            title: "Como fazer um padrão de arquivo?",
            links: [
                LinkInfo(
                    name: "Padrão de comentário",
                    categorie: TagConfig(text: "Notion", color: .orange),
                    link: "https://kings-gui.notion.site/Padroniza-o-do-c-digo-cf5fd2bdeee448da892c462bd02fc572"
                ),
                LinkInfo(
                    name: "Padrão de comentário",
                    categorie: TagConfig(text: "Notion", color: .orange),
                    link: "https://kings-gui.notion.site/Padroniza-o-do-c-digo-cf5fd2bdeee448da892c462bd02fc572"
                ),
                LinkInfo(
                    name: "Padrão de comentário",
                    categorie: TagConfig(text: "Notion", color: .orange),
                    link: "https://kings-gui.notion.site/Padroniza-o-do-c-digo-cf5fd2bdeee448da892c462bd02fc572"
                )
            ]
        )
    }
}
