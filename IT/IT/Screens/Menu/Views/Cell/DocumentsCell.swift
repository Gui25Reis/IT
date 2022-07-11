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
    public func setupCell(with document: Document) -> Void {
        self.titleLabel.text = document.title
    }
    
    
    /// Define o Data Source da collection
    public func setTagsCollectionDataSource(with dataSource: DocumentTagsDataSource) -> Void {
        self.tagsCollection.dataSource = dataSource
    }
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        // self.setupUI()
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.tagsCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.layer.cornerRadius = self.bounds.height * 0.07
        
        let cellSize = CGSize(
            width: self.bounds.width * 0.35,
            height: self.bounds.height * 0.18
        )

        self.collectionLayout.itemSize = cellSize
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleLabel.setupText(with: FontConfig(
            fontSize: self.bounds.height * 0.18, weight: .semibold)
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
            self.titleLabel.bottomAnchor.constraint(equalTo: self.tagsCollection.topAnchor)
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
