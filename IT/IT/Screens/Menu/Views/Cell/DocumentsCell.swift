/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class DocumentsCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdDocumentsCell"
    
    // Views
    private let titleLabel: UILabel = {
        let lbl = CustomViews.newLabel(alignment: .center)
        lbl.numberOfLines = 3
        
        return lbl
    }()
    
    
    private let favoriteButton = CustomViews.newButton()
    

    private let tagsCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        cv.isScrollEnabled = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        return cv
    }()
    
    
    // Outros
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .secondarySystemBackground
        
        self.tagsCollection.collectionViewLayout = self.collectionLayout

        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configurando a célula a partir das informações do documento
    public func setupCell(with document: DocumentInfo) -> Void {
        self.titleLabel.text = document.title
        
        self.favoriteButton.isHidden = !document.isFavorited
    }
    
    
    /// Define o Data Source da collection
    public func setTagsCollectionDataSource(with dataSource: DocumentTagsDataSource) -> Void {
        self.tagsCollection.dataSource = dataSource
    }
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        //if self.bounds != self.viewSize {
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            self.setupUI()
            
            self.reloadInputViews()
            self.tagsCollection.reloadInputViews()
            
            self.viewSize = self.bounds
        //}
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.favoriteButton)
        self.contentView.addSubview(self.tagsCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.layer.cornerRadius = self.bounds.height * 0.07
        
        /* Obs:
         A altura da célula precisa ser menor que a altura da
         collection.
         Estava sendo atribuido a altura direto da
         collection mas estava dando erro.
         Então foi atribuido o mesmo valor, mas está tirando 1
         pra ser emnor que a altura, assim tira os warnings.
         */
        let cellSize = CGSize(
            width: self.bounds.width * 0.35,
            height: self.bounds.height * 0.18-1
        )

        self.collectionLayout.itemSize = cellSize
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleLabel.setupText(with: FontConfig(
            fontSize: self.bounds.height * 0.18, weight: .semibold)
        )
        
        /* Botões */
        self.favoriteButton.setupIcon(with: IconConfig(
            icon: .favoriteTrue, size: self.bounds.height * 0.1, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 5
        
        NSLayoutConstraint.activate([
            self.tagsCollection.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
            self.tagsCollection.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: space),
            self.tagsCollection.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: space),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -space),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.tagsCollection.topAnchor),
            
            
            self.favoriteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -space)
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.tagsCollection.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.18)
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
