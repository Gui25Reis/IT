/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CopyWarningView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    let mainLabel = CustomViews.newLabel(alignment: .center)
        
    

    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setupUI()
        self.setupViews()
        self.setupConstraints()
        self.setupStaticTexts()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.mainLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.layer.cornerRadius = 3
        self.backgroundColor = .systemFill
        self.isHidden = true
        
        self.mainLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        // self.mainLabel.text = "Texto copiado no clipboard"
        self.mainLabel.setupText(with: FontConfig(
            text: "Texto copiado no clipboard", fontSize: 15, weight: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 10
        NSLayoutConstraint.activate([
            self.mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: space),
            self.mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: space),
            self.mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -space),
            self.mainLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space),
        ])
    }
}
