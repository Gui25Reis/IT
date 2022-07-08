/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuView: UIView {
    
    /* MARK: - Atributos */
    
    private let titleLabel = CustomViews.newLabel()
    
    private let tagsButton = CustomViews.newButton()
    private let reloadButton = CustomViews.newButton()
    private let newDocumentButton = CustomViews.newButton()
    
    private let documentsLabel = CustomViews.newLabel()
    
    private let documentsCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        cv.register(DocumentsCell.self, forCellWithReuseIdentifier: DocumentsCell.identifier)
        return cv
    }()
    
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        return layout
    }()
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.documentsCollection.collectionViewLayout = self.collectionLayout
        
        self.setupViews()
        self.setupConstraints()
        
        self.documentsCollection.backgroundColor = .tertiaryLabel
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Collection */
    
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
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.titleLabel)
        
        self.addSubview(self.tagsButton)
        self.addSubview(self.reloadButton)
        self.addSubview(self.newDocumentButton)
        
        self.addSubview(self.documentsLabel)
        self.addSubview(self.documentsCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.documentsCollection.layer.cornerRadius = self.bounds.height * 0.016
        
        // Layout
        let cellSize = CGSize(
            width: self.documentsCollection.bounds.width * 0.15,
            height: self.documentsCollection.bounds.height * 0.18
        )
        self.collectionLayout.itemSize = cellSize
        self.reloadDocuments()
        
        // print("Tamanho da celula: \nAltura: \(self.documentsCollection.bounds.width * 0.15) | Largura: \(self.documentsCollection.bounds.height * 0.18)")
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
            
            // Botões da esquerda
            self.newDocumentButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            
            self.reloadButton.centerYAnchor.constraint(equalTo: self.newDocumentButton.centerYAnchor),

            self.tagsButton.centerYAnchor.constraint(equalTo: self.reloadButton.centerYAnchor),
            
            
            self.documentsLabel.trailingAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.documentsCollection.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        let space = self.bounds.height*0.022
        let negSpace = -space/2
        
        let between: CGFloat = self.bounds.height*0.015
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: space),
            
            
            // Botões da esquerda
            self.newDocumentButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: space),
            self.newDocumentButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: negSpace),
            
            self.reloadButton.rightAnchor.constraint(equalTo: self.newDocumentButton.leftAnchor, constant: -between),
            
            self.tagsButton.rightAnchor.constraint(equalTo: self.reloadButton.leftAnchor, constant: -between),
            
            
            self.documentsLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: space),
            self.documentsLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: space*2),
            
            
            self.documentsCollection.topAnchor.constraint(equalTo: self.documentsLabel.bottomAnchor, constant: space),
            self.documentsCollection.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: space),
            self.documentsCollection.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: negSpace),
            self.documentsCollection.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: negSpace),
        ])
    }
}
