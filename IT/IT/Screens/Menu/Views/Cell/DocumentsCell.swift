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
        // lbl.sizeToFit()
        
        return lbl
    }()
    
    
    private let tagsView = CustomViews.newView()
    
    
    
    /* MARK: - Construtor */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupViews()
        self.setupConstraints()
        
        self.titleLabel.backgroundColor = .orange
        self.tagsView.backgroundColor = .blue
        self.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configurando a célula a partir das informações do documento
    public func setupCell(with document: Document) -> Void {
        self.titleLabel.text = document.title
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
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.tagsView)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.layer.cornerRadius = self.bounds.height * 0.07
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
            self.tagsView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
            self.tagsView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.tagsView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: space),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -space),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.tagsView.topAnchor)
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.tagsView.heightAnchor.constraint(equalToConstant: self.bounds.height * 0.18),
        ])
    }
}
