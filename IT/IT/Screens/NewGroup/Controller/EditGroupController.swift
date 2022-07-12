/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class EditGroupController: UIViewController, EditGroupDelegate {
    
    /* MARK: - Atributos */
    
    /* Views */
    private let myView = EditGroupView()
    
    
    /* Outros */
    
    /// Define se está adicionando um novo grupo
    private var newGroupIndex: Int?
    
    
    /// Guarda as células que foram adicionadas
    private var newGroupAdded: [Int:String] = [:]
    
    
    /// Grupos que estão disponíveis
    static var groups: [TagConfig] = []
    
    
    /* Delegates */
    
    /// Comunicação com a controller da tela de Menu (MenuViewController)
    public weak var menuViewControllerDelegate: MenuViewControllerDelegate?
    
    
    /// DataSource da tabela
    private let newGroupsDataSource = EditGroupDataSource()
    
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.setupDelegates()
        self.setupButtonsAction()
    }
    
    
    public override func viewDidAppear(_ animated: Bool) -> Void {
        super.viewDidAppear(animated)
        
        self.myView.reloadTableData()
    }
    
    
    
    /* MARK: - Protocolo */
    
    internal func isNewGroup(at index: Int) -> Bool {
        return self.newGroupAdded[index] != nil
    }
    
    
    internal func updateNewGroup(at index: Int, with text: String) -> Void {
        if self.newGroupAdded[index] != nil {
            self.newGroupAdded[index] = text
        }
    }
    
    
    
    /* MARK: - Ações de botões */
    
    /// Ação para fechar a tela
    @objc private func closeAction() -> Void {
        let textsUpdate = self.newGroupsDataSource.getTextsChanges()
        
        // Lidando com os casos de nova célula
        var removed: Int = 0
        
        for key in self.newGroupAdded.keys {
            if self.newGroupAdded[key] == "" {
                EditGroupController.groups.remove(at: key-removed)
                removed += 1
            } else {
                EditGroupController.groups[key-removed].text = self.newGroupAdded[key]!
            }
        }
        self.newGroupAdded = [:]
        
        
        // Atualiza os textos que foram alterados
        for ind in 0..<EditGroupController.groups.count {
            if let text = textsUpdate[ind] {
                if text != "" {
                    EditGroupController.groups[ind].text = text
                }
            }
        }
        
        // Atualiza a collection da tela de Menu
        self.menuViewControllerDelegate?.reloadGroupCollection()
        
        self.dismiss(animated: false)
    }
    
    
    /// Ação para adicionar um novo grupo
    @objc private func newGroupAction() -> Void {
        self.newGroupAdded[EditGroupController.groups.count] = ""
        
        let newTag = TagConfig(text: "", color: nil)
        EditGroupController.groups.append(newTag)
        
        self.myView.reloadTableData()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Define as açòes dos Botões
    private func setupButtonsAction() -> Void {
        self.myView.setExitAction(target: self, action: #selector(self.closeAction))
        self.myView.setNewGroupAction(target: self, action: #selector(self.newGroupAction))
    }
    
    
    /// Define os delegates
    private func setupDelegates() -> Void {
        self.newGroupsDataSource.setDelegate(self)
        self.myView.setTableDataSource(to: self.newGroupsDataSource)
    }
}
