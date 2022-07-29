/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkSetupView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    private let backgroudButton = CustomViews.newButton()
    
    private let container = CustomViews.newView()
    
    private let cancelButton = CustomViews.newButton()
    
    private let saveButton = CustomViews.newButton()
    
    private let linkWarningLabel = CustomViews.newLabel(alignment: .center)
    
    private let tableForm: UITableView = {
        let tv = CustomViews.newTable()
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.register(LinkInfoCell.self, forCellReuseIdentifier: LinkInfoCell.identifier)
        return tv
    }()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.container.backgroundColor = .systemBackground
        
        self.setupViews()
        self.setupConstraints()
        
        self.setUrlWarning(to: true)
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Define o texto da aviso a partir da validação da URL
    public func setUrlWarning(to warning: Bool) -> Void {
        switch warning {
        case true:
            self.linkWarningLabel.text = "URL Válida"
            self.linkWarningLabel.textColor = .green
            
        case false:
            self.linkWarningLabel.text = "URL Inválida"
            self.linkWarningLabel.textColor = .red
        }
    }
    
    
    public func setupLinkInfo(with linkInfo: LinkInfo) -> Void {
        
    }
    
    
    /* Ações de Botões */
    
    /// Ação de salvar
    public func setSaveAction(target: Any?, action: Selector) -> Void {
        self.saveButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de fechar a tela
    public func setCancelAction(target: Any?, action: Selector) -> Void {
        self.backgroudButton.addTarget(target, action: action, for: .touchDown)
        self.cancelButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* Table */
    
    /// Configurando o delegate da Teble View
    public func setTableDelegate(to delegate: UITableViewDelegate) -> Void {
        self.tableForm.delegate = delegate
    }
    
    
    /// Configurando o dataSource da Teble View
    public func setTableDataSource(to dataSource: UITableViewDataSource) -> Void {
        self.tableForm.dataSource = dataSource
    }
    
    
    /// Atrualiza os dados da tabela
    public func reloadTableData() -> Void {
        self.tableForm.reloadData()
        self.tableForm.reloadInputViews()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        self.setupStaticTexts()
        self.setupDynamicConstraints()
        self.setupUI()
        
        self.reloadInputViews()
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.backgroudButton)
        self.addSubview(self.container)
        
        self.container.addSubview(self.cancelButton)
        self.container.addSubview(self.saveButton)
        self.container.addSubview(self.tableForm)
        self.container.addSubview(self.linkWarningLabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        let radius: CGFloat = self.bounds.height * 0.01
        
        self.container.layer.cornerRadius = radius
        
        self.tableForm.layer.cornerRadius = radius
        
        self.tableForm.rowHeight = self.tableForm.bounds.height/2
        self.reloadTableData()
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        // Botões
        self.cancelButton.setupText(with: FontConfig(
            text: "Cancel", fontSize: 18, weight: .semibold)
        )
        
        self.saveButton.setupText(with: FontConfig(
            text: "Salvar", fontSize: 18, weight: .bold)
        )
        
        
        // Labels
        if self.linkWarningLabel.text == nil {
            self.linkWarningLabel.text = " "
        }
        
        self.linkWarningLabel.setupText(with: FontConfig(
            text: self.linkWarningLabel.text, fontSize: 15, weight: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 15
        
        NSLayoutConstraint.activate([
            self.backgroudButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroudButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroudButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroudButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.cancelButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: space/2),
            self.cancelButton.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            
            
            self.saveButton.topAnchor.constraint(equalTo: self.container.topAnchor, constant: space/2),
            self.saveButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            
            
            self.tableForm.topAnchor.constraint(equalTo: self.cancelButton.bottomAnchor, constant: space),
            self.tableForm.bottomAnchor.constraint(equalTo: self.linkWarningLabel.topAnchor,constant: -space),
            self.tableForm.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: space),
            self.tableForm.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -space),
            
            
            self.linkWarningLabel.centerXAnchor.constraint(equalTo: self.container.centerXAnchor),
            self.linkWarningLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.linkWarningLabel.trailingAnchor.constraint(equalTo: self.container.trailingAnchor),
            self.linkWarningLabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -space/2),
            
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        guard let frame = self.superview?.bounds else {return}
        self.frame = frame
        
        // let btWidth = self.container.bounds.width/4
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.container.heightAnchor.constraint(equalToConstant: self.bounds.height*0.18),
            self.container.widthAnchor.constraint(equalToConstant: self.bounds.width*0.25),
            
            
            self.cancelButton.widthAnchor.constraint(equalToConstant: self.bounds.width*0.05),
            
            
            self.saveButton.widthAnchor.constraint(equalToConstant: self.bounds.width*0.05),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
