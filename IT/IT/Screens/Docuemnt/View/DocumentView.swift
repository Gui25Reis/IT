/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentView: UIView {
    
    /* MARK: - Atributos */
    
    /* Views */
    
    private let backButton = CustomViews.newButton()
    
    private let shareButton = CustomViews.newButton()
    
    private let deleteButton = CustomViews.newButton()
    
    private let titleField = CustomViews.newTextField()
    
    private let webView = CustomViews.newWebView()
    
    
    // Collection -> tag
    private let newTagButton = CustomViews.newButton()
    
    private let tagCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        cv.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        return cv
    }()
    
    
    // Table -> Links
    private let linkLabel = CustomViews.newLabel(alignment: .left)
    
    private let newLinkButton = CustomViews.newButton()
    
    private let linkTable: UITableView = {
        let tv = CustomViews.newTable()
        // tv.backgroundColor = .red

        tv.register(LinkCell.self, forCellReuseIdentifier: LinkCell.identifier)
        return tv
    }()
    
    
    /* Outros */
    
    /// Configuração do layout da Collection
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.setupConstraints()
        
        self.tagCollection.collectionViewLayout = self.collectionLayout
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Faz a configuração de quando é um novo documento
    public func setupNewDocument() -> Void {
        self.titleField.placeholder = "Escreva título"
    }
    
    
    /// Define a URL que vai aparecer
    public func setUrl(with urlQuery: String) -> Bool {
        if let url = URL(string: urlQuery) {
            let request = URLRequest(url: url)
            
            self.webView.load(request)
            return true
        }
        return false
    }
    
    
    /// Define o título do documento
    public func setDocumentTitle(with title: String) -> Void {
        self.titleField.text = title
    }
    
    
    /* Ações de Botões */
    
    /// Ação do botão de sair da página
    public func setExitAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de compartilhar o conteúdo da página
    public func setShareAction(target: Any?, action: Selector) -> Void {
        self.shareButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de deletar documento
    public func setDeleteAction(target: Any?, action: Selector) -> Void {
        self.backButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de adicioanr uma nova categoria
    public func setNewTagAction(target: Any?, action: Selector) -> Void {
        self.newTagButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de adicioanr uma nova categoria
    public func setNewLinkAction(target: Any?, action: Selector) -> Void {
        self.newLinkButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /* Collection */
    
    /// Define qual vai ser o Data Source da collection
    public func setTagCollectionDataSource(with dataSource: DocumentTagsDataSource) -> Void {
        self.tagCollection.dataSource = dataSource
    }
    
    
    /// Atualiza os dados da collection
    public func reloadCollectionData() -> Void {
        self.tagCollection.reloadData()
    }
    
    
    /* Table */
        
    /// Define qual vai ser o Data Source da table
    public func setLinksTableDataSource(with dataSource: LinksDataSource) -> Void {
        self.linkTable.dataSource = dataSource
    }
    
    /// Define qual vai ser o Delegate da table
    public func setLinksTableDelegate(with delegate: LinksDelegate) -> Void {
        self.linkTable.delegate = delegate
    }
    
    /// Atualiza os dados da tabela
    public func reloadTableData() -> Void {
        self.linkTable.reloadData()
    }
    

    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
            
            self.viewSize = self.bounds
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.webView)
        
        self.addSubview(self.backButton)
        self.addSubview(self.shareButton)
        self.addSubview(self.deleteButton)
        
        self.addSubview(self.titleField)
        
        self.addSubview(self.newTagButton)
        self.addSubview(self.tagCollection)
        
        self.addSubview(self.linkLabel)
        self.addSubview(self.newLinkButton)
        self.addSubview(self.linkTable)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        /* Table */
        self.linkTable.layer.cornerRadius = self.bounds.height * 0.009
        self.linkTable.rowHeight = self.bounds.height * 0.04
        
        
        /* Collection */
        /* Obs:
         A altura da célula precisa ser menor que a altura da
         collection.
         Estava sendo atribuido a altura direto da
         collection mas estava dando erro.
         Então foi atribuido o mesmo valor, mas está tirando 1
         pra ser emnor que a altura, assim tira os warnings.
         */
        let cellSize = CGSize(
            width: self.bounds.width * 0.05,
            height: self.bounds.height * 0.024-1
        )

        self.collectionLayout.itemSize = cellSize
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleField.setupText(with: FontConfig(
            fontSize: self.bounds.height * 0.04, weight: .semibold)
        )
        
        self.linkLabel.setupText(with: FontConfig(
            text: "Links", fontSize: self.bounds.height * 0.03, weight: .semibold)
        )
        
        
        /* Botões */
        self.backButton.setupIcon(with: IconConfig(
            icon: .back, size:  self.bounds.height * 0.024, weight: .regular, scale: .medium)
        )
        
        self.shareButton.setupIcon(with: IconConfig(
            icon: .share, size:  self.bounds.height * 0.021, weight: .regular, scale: .medium)
        )
        
        self.deleteButton.setupIcon(with: IconConfig(
            icon: .trash, size:  self.bounds.height * 0.021, weight: .regular, scale: .medium)
        )
        
        self.newTagButton.setupIcon(with: IconConfig(
            icon: .addSquare, size:  self.bounds.height * 0.024, weight: .regular, scale: .medium)
        )
        
        self.newLinkButton.setupIcon(with: IconConfig(
            icon: .add, size:  self.bounds.height * 0.024, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.webView.topAnchor.constraint(equalTo: self.topAnchor),
            self.webView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.webView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.webView.leadingAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.deleteButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            self.deleteButton.trailingAnchor.constraint(equalTo: self.titleField.trailingAnchor),
            
            
            self.shareButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor),
            
            
            // Collection
            self.newTagButton.leadingAnchor.constraint(equalTo: self.titleField.leadingAnchor),
            
    
            self.tagCollection.centerYAnchor.constraint(equalTo: self.newTagButton.centerYAnchor),
            self.tagCollection.trailingAnchor.constraint(equalTo: self.titleField.trailingAnchor),
            
            
            // Table
            self.linkLabel.leadingAnchor.constraint(equalTo: self.titleField.leadingAnchor),
            self.linkLabel.rightAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.newLinkButton.centerYAnchor.constraint(equalTo: self.linkLabel.centerYAnchor),
            self.newLinkButton.trailingAnchor.constraint(equalTo: self.titleField.trailingAnchor),
            
            
            self.linkTable.leadingAnchor.constraint(equalTo: self.titleField.leadingAnchor),
            self.linkTable.trailingAnchor.constraint(equalTo: self.titleField.trailingAnchor),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        let space = self.bounds.height*0.022
        
        let between = self.bounds.height*0.025
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            
            
            self.shareButton.rightAnchor.constraint(equalTo: self.deleteButton.leftAnchor, constant: -space),
            
            
            self.titleField.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: between),
            self.titleField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            self.titleField.rightAnchor.constraint(equalTo: self.webView.leftAnchor, constant: -space),
            
            
            // Collection
            self.newTagButton.topAnchor.constraint(equalTo: self.titleField.bottomAnchor, constant: space),
            
            
            self.tagCollection.leftAnchor.constraint(equalTo: self.newTagButton.rightAnchor, constant: space/2),
            self.tagCollection.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.024),
            
            
            // Table
            self.linkLabel.topAnchor.constraint(equalTo: self.tagCollection.bottomAnchor, constant: between),
            
            
            self.linkTable.topAnchor.constraint(equalTo: self.linkLabel.bottomAnchor, constant: space/2),
            self.linkTable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
