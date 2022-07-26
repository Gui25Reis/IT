/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentViewController: UIViewController {
    
    /* MARK: - Atributos */
    
    private let myView = DocumentView()
    
    
    private var document: Document?
    
    
    /* Delegates & Data Sources*/
    
    /// Data Source da collection de categorias
    private var tagsDataSource: DocumentTagsDataSource?
    
    
    /// Delegate da tabel de links
    private let linksDelegate = LinksDelegate()
    
    /// Data Source da tabela de links
    private var linksDataSource: LinksDataSource?
    
     
    
    /* MARK: - Construtor */
    
    init(with document: Document?) {
        super.init(nibName: nil, bundle: nil)
        
        if let document = document {
            self.document = document
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
        
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.setupDocumentInfo()
        self.setupButtonsAction()
        self.setupDelegates()
    }
    
    
    /* MARK: - Ações de botões */
    
    
    /// Ação do botào de fechar a página
    @objc private func closeAction() -> Void {
        self.dismiss(animated: false)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os delegates e Data Sources das views
    private func setupDelegates() -> Void {
        // Collection -> Tags
        if let tagsDataSource = self.tagsDataSource {
            self.myView.setTagCollectionDataSource(with: tagsDataSource)
        }
        
        // Table -> Links
        self.myView.setLinksTableDelegate(with: self.linksDelegate)
        if let linksDataSource = self.linksDataSource {
            self.myView.setLinksTableDataSource(with: linksDataSource)
        }
        
        // Atualizando dados
        self.myView.reloadCollectionData()
        self.myView.reloadTableData()
    }
    
    
    /// Define as açòes dos botões da tela
    private func setupButtonsAction() -> Void {
        self.myView.setExitAction(target: self, action: #selector(self.closeAction))
    }
    
    
    /// Configra o documento
    private func setupDocumentInfo() -> Void {
        if let document = self.document {
            self.myView.setDocumentTitle(with: document.title)
            
            self.tagsDataSource = DocumentTagsDataSource(tags: document.categories)
            
            self.linksDataSource = LinksDataSource(links: document.links)
            
            // Link padrão
            if !document.links.isEmpty {
                let _ = self.myView.setUrl(with: document.links[0].link)
            }
        } else {
            self.myView.setupNewDocument()
        }
    }
}
