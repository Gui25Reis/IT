/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagCell: UITableViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdTagCell"
    
    private let tagView = TagView()
        
    
    
    /* MARK: - Construtor */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a tag
    public func setupTag(with config: TagConfig) -> Void {
        self.tagView.setupTag(with: config)
    }
    
    
    
    /* MARK: - Configurações */
    
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
