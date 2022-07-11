/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagView: UIView {
    
    /* MARK: - Atributos */
    
    private let tagLabel = CustomViews.newLabel(alignment: .center)
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define as informaçòes da tag: texto e cor
    public func setupTag(with config: TagConfig) -> Void {
        self.tagLabel.text = config.text
        if let color = config.color {
            self.backgroundColor = color
        }
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            
            self.reloadInputViews()
            
            self.viewSize = self.bounds
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.tagLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.layer.cornerRadius = self.bounds.height*0.1
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        self.tagLabel.setupText(with: FontConfig(
            fontSize: self.bounds.height*0.45, weight: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 4
        
        NSLayoutConstraint.activate([
            self.tagLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.tagLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space),
            self.tagLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space),
            self.tagLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space),
        ])
    }
}
