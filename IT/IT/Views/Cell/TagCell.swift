/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagCell: UICollectionViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdTagCell"
    
    // Views
    private let tagView = TagView()
    
    /// Define o que vai acontecer quando a célula é selecionada
    override var isSelected: Bool {
        
        didSet {
            self.setupIfCellSelected(to: self.isSelected)
        }
    }
        
    
    
    /* MARK: - Construtor */
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        //self.setupIfCellSelected(to: false)
        
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
    }
        
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.tagView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.tagView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.tagView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.tagView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
        ])
    }
}
