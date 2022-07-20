/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class EditGroupCell: UITableViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdEditGroupCell"
    
    // Views
    private let inputField: UITextField = CustomViews.newTextField()
    
    private var deleteButton: UIButton = CustomViews.newButton()
    
    
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
        
        self.inputField.placeholder = "Digite o nome do grupo"
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o texto que vai ser mostrado
    public func setupCell(with text: String, tag: Int) -> Void {
        self.inputField.text = text
        self.inputField.tag = tag
        self.deleteButton.tag = tag
    }
    
    
    /* Ações dos Botões */
    
    /// Define a ação do botão
    public func setDeleteAction(target: Any?, action: Selector) -> Void {
        self.deleteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do textField
    public func setTextFieldAction(target: Any?, action: Selector) -> Void {
        self.inputField.addTarget(target, action: action, for: .editingChanged)
    }

    
    /* Text Field */
        
    
    /// Configura a célula para adicionar uma nova categoria
    public func setupNewCell() -> Void {
        self.inputField.placeholder = "Novo grupo"
        self.inputField.becomeFirstResponder()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        if self.bounds != self.viewSize {
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
        
            self.viewSize = self.bounds
        }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.inputField)
        self.contentView.addSubview(self.deleteButton)
    }

    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.inputField.setupText(with: FontConfig(
            fontSize: self.contentView.bounds.height*0.55, weight: .medium)
        )
        
        /* Botões */
        self.deleteButton.setupIcon(with: IconConfig(
            icon: .trash, size: self.contentView.bounds.height*0.5,
            weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 5
        
        NSLayoutConstraint.activate([
            self.deleteButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -space),
            self.deleteButton.centerYAnchor.constraint(equalTo: self.inputField.centerYAnchor),
            
            
            self.inputField.rightAnchor.constraint(equalTo: self.deleteButton.leftAnchor, constant: -space),
            self.inputField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: space),
            self.inputField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.inputField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let btHeight: CGFloat = self.contentView.bounds.height*0.6
        
        self.dynamicConstraints = [
            self.deleteButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.deleteButton.widthAnchor.constraint(equalToConstant: btHeight),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
