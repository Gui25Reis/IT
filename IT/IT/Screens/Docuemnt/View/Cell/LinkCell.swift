/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkCell: UITableViewCell {
    
    /* MARK: - Atributos */
    
    static let identifier = "IdLinkCell"
    
    
    // Views
    
    private let titleField = CustomViews.newTextField()
    
    private let tagView = TagView()
    
    private let linkViewButton = CustomViews.newButton()
    
    private let optionsButton = CustomViews.newButton()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    /// Estado de quando o link da célula está selecionado ou não
    private var isVisible: Bool = false
    
    
    /* MARK: - Construtor */
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // self.backgroundColor = .tertiarySystemBackground
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Configura a célula
    public func setupCell(with config: LinkInfo) -> Void {
        self.titleField.text = config.name
        self.tagView.setupTag(with: config.categorie)
    }
    
    
    /// Define o ícone do botão de visualizar ícone
    public func changeLinkVisibilityIcon(for visibility: Bool) -> Void {
        var icon: AppButton = .notVisible
        if visibility {
            icon = .visible
        }
        
        self.linkViewButton.setupIcon(with: IconConfig(
            icon: icon, size: self.contentView.bounds.height*0.5,
            weight: .regular, scale: .medium)
        )
        self.isVisible = visibility
    }
    
  
    /* Ações dos Botões */
    
    /// Define a ação do botão de visualiazar link
    public func setLinkAction(target: Any?, action: Selector) -> Void {
        self.linkViewButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Define a ação do botão de menu de opções
    public func setOptionsAction(target: Any?, action: Selector) -> Void {
        self.optionsButton.addTarget(target, action: action, for: .touchDown)
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
        self.contentView.addSubview(self.titleField)
        self.contentView.addSubview(self.tagView)
        self.contentView.addSubview(self.linkViewButton)
        self.contentView.addSubview(self.optionsButton)
    }

    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleField.setupText(with: FontConfig(
            fontSize: self.contentView.bounds.height*0.55, weight: .medium)
        )
        
        
        /* Botões */
        self.changeLinkVisibilityIcon(for: self.isVisible)
        
        self.optionsButton.setupIcon(with: IconConfig(
            icon: .menu, size: self.contentView.bounds.height*0.5,
            weight: .regular, scale: .medium)
        )
        
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 5
        
        let between: CGFloat = 7
        
        NSLayoutConstraint.activate([
            self.optionsButton.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -space),
            self.optionsButton.centerYAnchor.constraint(equalTo: self.titleField.centerYAnchor),
            
            
            self.linkViewButton.rightAnchor.constraint(equalTo: self.optionsButton.leftAnchor, constant: -between),
            self.linkViewButton.centerYAnchor.constraint(equalTo: self.titleField.centerYAnchor),
            
            
            self.tagView.rightAnchor.constraint(equalTo: self.linkViewButton.leftAnchor, constant: -between),
            self.tagView.centerYAnchor.constraint(equalTo: self.titleField.centerYAnchor),
            
            
            self.titleField.rightAnchor.constraint(equalTo: self.tagView.leftAnchor, constant: -space),
            self.titleField.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: space),
            self.titleField.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: space),
            self.titleField.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -space),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let btHeight: CGFloat = self.contentView.bounds.height*0.6
        
        self.dynamicConstraints = [
            self.optionsButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.optionsButton.widthAnchor.constraint(equalToConstant: btHeight),
            
            
            self.linkViewButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.linkViewButton.widthAnchor.constraint(equalToConstant: btHeight*1.5),
            
            
            self.tagView.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height*0.6),
            self.tagView.widthAnchor.constraint(equalToConstant: self.contentView.bounds.width*0.1),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
