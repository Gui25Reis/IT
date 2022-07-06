/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuView: UIView {
    
    /* MARK: - Atributos */
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    
    
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
        
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        
    }
}
