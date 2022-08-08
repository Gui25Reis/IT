/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkInfoCell: UITableViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdLinkInfoCell"
    
    // Views
    private let inputField: UITextField = CustomViews.newTextField()
    

    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    
    /* MARK: - Construtor */
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .tertiarySystemBackground
                
        self.setupViews()
        self.setupConstraints()
        
        // self.inputField.placeholder = "Link (url)"
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o texto que vai ser mostrado
    public func setupCell(with text: String, tag: Int) -> Void {
        self.inputField.text = text
        self.inputField.tag = tag
    }
    
    
    /// Define o texto que vai ser mostrado
    public func setBackgroundText(with text: String) -> Void {
        self.inputField.placeholder = text
    }
    
    
    /* Ações dos Botões */
    
    
    /// Define a ação do textField
    public func setTextFieldAction(target: Any?, action: Selector) -> Void {
        self.inputField.addTarget(target, action: action, for: .editingChanged)
    }

    
    /* Text Field */
        
    
    /// Configura a célula para adicionar uma nova categoria
    public func setupNewCell() -> Void {
        self.inputField.becomeFirstResponder()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        if self.bounds != self.viewSize {
            self.setupStaticTexts()
            // self.setupDynamicConstraints()
            
            self.reloadInputViews()
        
            self.viewSize = self.bounds
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.inputField)
    }

    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        self.inputField.setupText(with: FontConfig(
            fontSize: self.contentView.bounds.height * 0.35, weight: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 5
        
        NSLayoutConstraint.activate([
            self.inputField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -space),
            self.inputField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: space),
            self.inputField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.inputField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
        
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
