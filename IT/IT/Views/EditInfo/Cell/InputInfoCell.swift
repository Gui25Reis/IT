/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class InputInfoCell: UITableViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdInputInfoCell"
    
    // Views
    private let inputField: UITextField = CustomViews.newTextField()
    
    private let colorPickerButton = CustomViews.newButton()
    

    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    /// Estilo da célula
    public var style: EditInfoStyle = .justInput {
        didSet {
            self.setupStyle()
        }
    }
    
    
    
    /* MARK: - Construtor */
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .tertiarySystemBackground
                
        self.setupViews()
        
        self.colorPickerButton.backgroundColor = .orange
        self.colorPickerButton.isHidden = true
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */

    /// Atualiza a cor do botão
    public func updateButtonColor(to color: UIColor) -> Void {
        self.colorPickerButton.backgroundColor = color
    }
    
    
    /// Define o texto que vai ser mostrado
    public func setupCell(with text: String, tag: Int) -> Void {
        self.inputField.text = text
        
        self.inputField.tag = tag
        self.colorPickerButton.tag = tag
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
    
    
    /// Define a ação do de escolher a cor
    public func setColorPickerAction(target: Any?, action: Selector) -> Void {
        self.colorPickerButton.addTarget(target, action: action, for: .touchDown)
    }

    
    /* Text Field */
        
    
    /// Configura a célula para adicionar uma nova categoria
    public func setupNewCell() -> Void {
        self.inputField.becomeFirstResponder()
    }
    
    
    /// Define o delegate do text field
    public func setTextFieldDelegate(with delegate: UITextFieldDelegate) -> Void {
        self.inputField.delegate = delegate
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        // if self.bounds != self.viewSize {
            self.setupStaticTexts()
            self.setupUI()
            
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
        
            self.viewSize = self.bounds
        // }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura o estilo da célula
    private func setupStyle() -> Void {
        self.colorPickerButton.isHidden = self.style == .justInput
        self.setupDynamicConstraints()
    }
    
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.contentView.addSubview(self.inputField)
        self.contentView.addSubview(self.colorPickerButton)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.colorPickerButton.layer.cornerRadius = self.contentView.bounds.height * 0.07
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        self.inputField.setupText(with: FontConfig(
            fontSize: self.contentView.bounds.height * 0.35, weight: .medium)
        )
    }
    

    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let square: CGFloat = self.contentView.bounds.height * 0.55
        
        self.dynamicConstraints = [
            self.colorPickerButton.widthAnchor.constraint(equalToConstant: square),
            self.colorPickerButton.heightAnchor.constraint(equalToConstant: square)
        ]
        
        
        let space: CGFloat = 5
        
        switch self.style {
        case.justInput:
            self.dynamicConstraints.append(contentsOf: [
                self.inputField.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -space),
                self.inputField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: space),
                self.inputField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
                self.inputField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
            ])
        
        case .withColor:
            self.dynamicConstraints.append(contentsOf: [
                self.inputField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: space),
                self.inputField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
                self.inputField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
                self.inputField.rightAnchor.constraint(equalTo: self.colorPickerButton.leftAnchor, constant: -space),
                
                self.colorPickerButton.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
                self.colorPickerButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -space*1.5),
            ])
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
