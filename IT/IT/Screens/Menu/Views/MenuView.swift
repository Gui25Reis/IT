/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    private let titleLabel = CustomViews.newLabel()
    
    private let tagsButton = CustomViews.newButton()
    private let reloadButton = CustomViews.newButton()
    private let newDocumentButton = CustomViews.newButton()
    
    private let documentsLabel = CustomViews.newLabel()
    
    public let groupView = GroupView()
    
    private let documentsCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        cv.register(DocumentsCell.self, forCellWithReuseIdentifier: DocumentsCell.identifier)
        return cv
    }()
    
    
    // Outros
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        return layout
    }()
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.documentsCollection.collectionViewLayout = self.collectionLayout
        
        self.setupViews()
        self.setupConstraints()
        
        // self.documentsCollection.backgroundColor = .tertiaryLabel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de Botões */
    
    /// Ação do botão de adicionar um novo documento
    public func setNewDocumentAction(target: Any?, action: Selector) -> Void {
        self.newDocumentButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Ação do botão de atualizar os dados da tela
    public func setReloadAction(target: Any?, action: Selector) -> Void {
        self.reloadButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Ação do botão de tags
    public func setTagsAction(target: Any?, action: Selector) -> Void {
        self.tagsButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    // Group View
    
    /// Ação do botão de favoritos
    public func setFavoriteAction(target: Any?, action: Selector) -> Void {
        self.groupView.setFavoriteAction(target: target, action: action)
    }
    
    
    /// Ação do botão de manter um grupo
    public func setNewGroupAction(target: Any?, action: Selector) -> Void {
        self.groupView.setNewGroupAction(target: target, action: action)
    }
    
    
    /* Collection */
    
    // Documentos
    
    /// Define qual vai ser o Data Source da collection
    public func setDocumentsCollectionDataSource(with dataSource: DocumentsDataSource) -> Void {
        self.documentsCollection.dataSource = dataSource
    }
    
    
    /// Define qual vai ser o delegate da collection
    public func setDocumentsCollectionDelegate(with delegate: DocumentsDelegate) -> Void {
        self.documentsCollection.delegate = delegate
    }
    
    
    /// Atualiza a tabela
    public func reloadDocuments() -> Void {
        self.documentsCollection.reloadData()
        self.documentsCollection.reloadInputViews()
    }
    
    
    // Grupos
    
    /// Define qual vai ser o Data Source da collection
    public func setGroupCollectionDataSource(with dataSource: GroupDataSource) -> Void {
        self.groupView.setGroupCollectionDataSource(with: dataSource)
    }
    
    
    /// Define qual vai ser o delegate da collection
    public func setGroupCollectionDelegate(with delegate: GroupDelegate) -> Void {
        self.groupView.setGroupCollectionDelegate(with: delegate)
    }
    
    
    /// Atualiza a tabela
    public func reloadGroups() -> Void {
        self.groupView.reloadGroups()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        //if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
            //self.documentsCollection.reloadInputViews()
            
            self.viewSize = self.bounds
        //}
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.titleLabel)
        
        self.addSubview(self.tagsButton)
        self.addSubview(self.reloadButton)
        self.addSubview(self.newDocumentButton)
        
        self.addSubview(self.documentsLabel)
        self.addSubview(self.groupView)
        
        self.addSubview(self.documentsCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.documentsCollection.layer.cornerRadius = self.bounds.height * 0.016
        
        let cellInLine: CGFloat = 7
        let spaceBetweenCell = self.documentsCollection.bounds.width * 0.005
        let sizeWithoutSpace = self.documentsCollection.bounds.width - (spaceBetweenCell*cellInLine)
        
        // Layout
        let cellSize = CGSize(
            width: sizeWithoutSpace/cellInLine,
            height: self.documentsCollection.bounds.height * 0.16
        )

        self.collectionLayout.itemSize = cellSize
        self.collectionLayout.minimumLineSpacing = spaceBetweenCell
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleLabel.setupText(with: FontConfig(
            text: "Nome App", fontSize: self.bounds.height * 0.02, weight: .bold)
        )
        
        self.documentsLabel.setupText(with: FontConfig(
            text: "Documentos", fontSize: self.bounds.height * 0.025, weight: .semibold)
        )
        
        
        /* Botões */
        self.newDocumentButton.setupIcon(with: IconConfig(
            icon: .add, size:  self.bounds.height * 0.023, weight: .regular, scale: .medium)
        )
        
        self.reloadButton.setupIcon(with: IconConfig(
            icon: .reload, size: self.bounds.height * 0.022, weight: .regular, scale: .medium)
        )
        
        self.tagsButton.setupIcon(with: IconConfig(
            icon: .search, size: self.bounds.height * 0.022, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.titleLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.documentsCollection.leadingAnchor),
            
            // Botões da esquerda
            self.newDocumentButton.trailingAnchor.constraint(equalTo: self.documentsCollection.trailingAnchor),
            self.newDocumentButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            
            self.reloadButton.centerYAnchor.constraint(equalTo: self.newDocumentButton.centerYAnchor),

            self.tagsButton.centerYAnchor.constraint(equalTo: self.reloadButton.centerYAnchor),
            
            
            self.documentsLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            self.documentsLabel.leadingAnchor.constraint(equalTo: self.documentsCollection.leadingAnchor),
            
            self.groupView.trailingAnchor.constraint(equalTo: self.documentsCollection.trailingAnchor),
            self.groupView.leadingAnchor.constraint(equalTo: self.documentsCollection.leadingAnchor),
            
            self.documentsCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let space = self.bounds.height*0.022
        let negSpace = -space/2
        
        let between: CGFloat = self.bounds.height*0.015
        
        self.dynamicConstraints = [
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: space),
            
            // Botões da esquerda
            self.newDocumentButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: space),
            
            self.reloadButton.rightAnchor.constraint(equalTo: self.newDocumentButton.leftAnchor, constant: -between),
            
            self.tagsButton.rightAnchor.constraint(equalTo: self.reloadButton.leftAnchor, constant: -between),
            
            // Corpo
            self.documentsLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: space*1.4),
            
            self.groupView.topAnchor.constraint(equalTo: self.documentsLabel.bottomAnchor, constant: space*1.4),
            self.groupView.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.04),
            
            self.documentsCollection.topAnchor.constraint(equalTo: self.groupView.bottomAnchor, constant: space),
            self.documentsCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: negSpace),
            self.documentsCollection.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.98),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
