/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentViewController: UIViewController, DocumentControllerDelegate {
    
    /* MARK: - Atributos */
    
    private let myView = DocumentView()
    
    /// Modal com as informaçòes do documento da página
    private var document: Document?
    
    /// Index do link que está a mostra
    private var linkPreview: Int = 0
    
    
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
    
    
    
    /* MARK: - Delegate (Protocol) */
    
    
    internal func openLinkPage(with index: Int?) -> Void {
        var document: LinkInfo? = nil
        if let index = index {
            document = self.document?.links[index]
        }
        
        let vc = LinkSetupViewController(with: document)
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false)
    }
    
    
    internal func openLinkOnWebView(for index: Int) -> Void {
        if let document = self.document {
            let _ = self.myView.setUrl(with: document.links[index].link)
            
            self.linkPreview = index
            self.myView.reloadTableData()
        }
    }
    
    
    internal func getActualLinkPreview() -> Int {
        return self.linkPreview
    }
    
    
    internal func copyLinkinfo(for index: Int) -> Void {
        if let document = self.document {
            let clipboardText = """
            Se liga nesse link que eu salvei:
            
            >> \(document.links[index].name)
            \(document.links[index].link)
            """
            
            UIPasteboard.general.string = clipboardText
            
            self.myView.showCopyWarning()
        }
    }
    
    
    internal func deleteLink(for index: Int) -> Void {
        // self.document?.links.remove(at: index)
        // self.myView.reloadTableData()
    }
    
    
    internal func openLinkOnBrowser(for index: Int) -> Void {
        if let document = self.document {
            let link = document.links[index].link
            
            if let url = URL(string: link), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    
    /* MARK: - Ações de botões */
    
    
    /// Ação do botão de fechar a página
    @objc private func closeAction() -> Void {
        self.dismiss(animated: false)
    }
    
    
    /// Ação do botão de adicionar um novo link
    @objc private func linkSetupAction() -> Void {
        self.openLinkPage(with: nil)
    }
    
    
    /// Ação do botão de compartilhar o documento
    @objc private func shareAction() -> Void {
        // Chama o botão de compartilhar
        #if targetEnvironment(macCatalyst)
        self.createDocumentCopy()
        
        #else
        let vc = UIActivityViewController(activityItems: [], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem     // Ipad
        self.present(vc, animated: true)
        
        #endif
    }
    
    
    /// Ação do botão de fechar a página
    @objc private func favoriteAction() -> Void {
        self.myView.changeFavoriteIcon(for: nil)
    }
    
    
    /// Ação do botão de fechar a página
    @objc private func openCategoriesPageAction() -> Void {
        self.myView.changeFavoriteIcon(for: nil)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura os delegates e Data Sources das views
    private func setupDelegates() -> Void {
        // Collection -> Tags
        if let tagsDataSource = self.tagsDataSource {
            self.myView.setTagCollectionDataSource(with: tagsDataSource)
        }
        
        // Table -> Links
        self.linksDelegate.setDelegate(with: self)
        self.myView.setLinksTableDelegate(with: self.linksDelegate)
        
        if let linksDataSource = self.linksDataSource {
            self.myView.setLinksTableDataSource(with: linksDataSource)
        }
        
        // Atualizando dados
        self.myView.reloadCollectionData()
        self.myView.reloadTableData()
    }
    
    
    /// Define as ações dos botões da tela
    private func setupButtonsAction() -> Void {
        self.myView.setExitAction(target: self, action: #selector(self.closeAction))
        
        self.myView.setShareAction(target: self, action: #selector(self.shareAction))
        self.myView.setFavoriteAction(target: self, action: #selector(self.favoriteAction))
        
        self.myView.setNewLinkAction(target: self, action: #selector(self.linkSetupAction))
        
        let collectionTap = UITapGestureRecognizer(target: self, action: #selector(self.openCategoriesPageAction))
        self.myView.setCollectionTapAction(tap: collectionTap)
    }
    
    
    /// Configra o documento
    private func setupDocumentInfo() -> Void {
        if let document = self.document {
            self.myView.setDocumentTitle(with: document.title)
            
            self.tagsDataSource = DocumentTagsDataSource(tags: document.categories)
            
            let linksDataSource = LinksDataSource(links: document.links)
            linksDataSource.setDelegate(with: self)
            self.linksDataSource = linksDataSource
            
            
            
            
            // Link padrão
            if !document.links.isEmpty {
                let _ = self.myView.setUrl(with: document.links[0].link)
            }
        } else {
            self.myView.setupNewDocument()
        }
    }
    
    
    
    /* MARK: - Outros */
    
    /// Junta as informações do documento pra ser copiada no clipboard
    private func createDocumentCopy() -> Void {
        if let document = self.document {
            // Criando texto para ser copiado
            var clipboardText = """
            Olha esse documento:
            
            >> \(document.title)
            
            Links:\n
            """
            
            for link in document.links {
                clipboardText += """
                > \(link.name)
                \(link.link)\n\n
                """
            }
            
            // Add no clipboard
            UIPasteboard.general.string = clipboardText
            self.myView.showCopyWarning()
        }
    }
}
