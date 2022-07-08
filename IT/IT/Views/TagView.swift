/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class TagView: UIView {
    
    /* MARK: - Atributos */
    
    private let tagLabel = CustomViews.newLabel(alignment: .center)
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupViews()
        self.setupConstraints()
        
        self.setupTag(with: TagConfig(text: "Teste", color: .green))
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define as informaçòes da tag: texto e cor
    public func setupTag(with config: TagConfig) -> Void {
        self.tagLabel.text = config.text
        self.backgroundColor = config.color
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.setupUI()
        // self.setupStaticTexts()
        // self.setupDynamicConstraints()
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
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        
    }
}
