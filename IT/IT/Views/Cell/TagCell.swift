/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdTagCell"
    
    // Views
    private let tagView = TagView()
    
    private let removeButton = CustomViews.newButton()
    
    
    /// Define o que vai acontecer quando a célula é selecionada
    override var isSelected: Bool {
        didSet {
            if self.allowSelection {
                self.setupIfCellSelected(to: self.isSelected)
            }
        }
    }
    
    public var allowSelection: Bool = true
    
    public var style: TagStyle {
        didSet {
            switch self.style {
            case .visualization:
                self.removeButton.isHidden = true
            case .dismiss:
                self.removeButton.isHidden = false
            }
            
            self.setupConstraints()
        }
    }

    
    
    /* MARK: - Construtor */
    
    public override init(frame: CGRect) {
        self.style = .visualization
        self.removeButton.isHidden = true
        
        super.init(frame: frame)
        self.clipsToBounds = true
        
        // self.setupIfCellSelected(to: false)
        
        self.setupViews()
        self.setupConstraints()
        self.setupIfCellSelected(to: false)
    }
    
    
    
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a tag
    public func setupTag(with config: TagConfig) -> Void {
        self.tagView.setupTag(with: config)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        // if self.bounds != self.viewSize {
            self.setupStaticTexts()
        // }
    }

    
    
    /* MARK: - Configurações */
    
    private func setupIfCellSelected(to bool: Bool) -> Void {
        switch bool {
        case true:
            self.backgroundColor = .secondaryLabel
        case false:
            self.backgroundColor = .secondarySystemBackground
        }
    }
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.tagView)
        self.contentView.addSubview(self.removeButton)
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Botões */
        self.removeButton.setupIcon(with: IconConfig(
            icon: .close, size:  self.contentView.bounds.height * 0.6, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.constraints)
        
        switch self.style {
        case .visualization:
            NSLayoutConstraint.activate([
                self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.tagView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                self.tagView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
                self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            ])
            
        case .dismiss:
            NSLayoutConstraint.activate([
                self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
                self.tagView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
                self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
                self.tagView.rightAnchor.constraint(equalTo: self.removeButton.leftAnchor),
                
                self.removeButton.centerYAnchor.constraint(equalTo: self.tagView.centerYAnchor),
                self.removeButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            ])
        }
    }
}
