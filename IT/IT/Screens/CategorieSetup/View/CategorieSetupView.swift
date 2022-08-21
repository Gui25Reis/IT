/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CategorieSetupView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    private let backgroudButton = CustomViews.newButton()
    
    private let container = CustomViews.newView()
    
    private let cancelButton = CustomViews.newButton()
    
    private let saveButton = CustomViews.newButton()
    
    private let stringCountlabel = CustomViews.newLabel(alignment: .right)
    
    private let tableForm: UITableView = {
        let tv = CustomViews.newTable()
        tv.isScrollEnabled = false
        tv.showsVerticalScrollIndicator = false
        tv.register(InputInfoCell.self, forCellReuseIdentifier: InputInfoCell.identifier)
        return tv
    }()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Caracteres máximo aceitos
    public var maxCaracteresGranted: Int = 25
    


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.setupInitialUI()
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /// Atualiza a quantidade de caracteres colocado
    public func updateStringCount(to count: Int) -> Void {
        self.stringCountlabel.text = "\(count)/\(self.maxCaracteresGranted)"
        
        if count == self.maxCaracteresGranted {
            self.stringCountlabel.textColor = .red
        } else {
            self.stringCountlabel.textColor = .label
        }
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
    
    
    /// Atrualiza a cor do botão
    public func updateColorSelected(to color: UIColor) -> Void {
        let index = IndexPath(row: 0, section: 0)
        guard let cell = self.tableForm.cellForRow(at: index) as? InputInfoCell else {
            return
        }
        
        cell.updateButtonColor(to: color)
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
        self.container.addSubview(self.stringCountlabel)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.container.layer.cornerRadius = self.bounds.height * 0.01
        
        self.tableForm.layer.cornerRadius = self.bounds.height * 0.007
        
        self.tableForm.rowHeight = self.tableForm.bounds.height
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
        if self.stringCountlabel.text == nil {
            self.stringCountlabel.text = " "
        }
        
        self.stringCountlabel.setupText(with: FontConfig(
            text: self.stringCountlabel.text, fontSize: self.container.bounds.height*0.1, weight: .medium)
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
            self.tableForm.bottomAnchor.constraint(equalTo: self.stringCountlabel.topAnchor, constant: -5),
            self.tableForm.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: space),
            self.tableForm.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -space),
            
            
            self.stringCountlabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor),
            self.stringCountlabel.trailingAnchor.constraint(equalTo: self.tableForm.trailingAnchor),
            self.stringCountlabel.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -space),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        guard let frame = self.superview?.bounds else {return}
        self.frame = frame
        
        // let btWidth = self.container.bounds.width/4
        
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.container.heightAnchor.constraint(equalToConstant: self.bounds.height*0.12),
            self.container.widthAnchor.constraint(equalToConstant: self.bounds.width*0.25),
            
            
            self.cancelButton.widthAnchor.constraint(equalToConstant: self.bounds.width*0.05),
            
            
            self.saveButton.widthAnchor.constraint(equalToConstant: self.bounds.width*0.05),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
    
    
    
    /* MARK: - Outros */
    
    private func setupInitialUI() -> Void {
        self.container.backgroundColor = .systemBackground
        
        self.updateStringCount(to: 0)
        self.stringCountlabel.tintColor = .lightText
    }
}
