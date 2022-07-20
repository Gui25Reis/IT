/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class EditGroupView: UIView {
    
    /* MARK: - Atributos */
    
    // Views
    private let backgroudButton = CustomViews.newButton()
    
    private let titleLabel = CustomViews.newLabel(alignment: .left)
    
    private let newGroupButton = CustomViews.newButton()
    
    private let container: UIView = {
        let lbl = CustomViews.newView()
        lbl.backgroundColor = .secondarySystemBackground
        return lbl
    }()
    
    private let groupsTable: UITableView = {
        let tv = CustomViews.newTable()
        tv.register(EditGroupCell.self, forCellReuseIdentifier: EditGroupCell.identifier)
        return tv
    }()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    


    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
        
    /// Ação do botão de adicionar um novo grupo
    public func setNewGroupAction(target: Any?, action: Selector) -> Void {
        self.newGroupButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de fechar a tela
    public func setExitAction(target: Any?, action: Selector) -> Void {
        self.backgroudButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /* Table */
    
    /// Configurando o delegate da Teble View
    public func setTableDelegate(to delegate: UITableViewDelegate) -> Void {
        self.groupsTable.delegate = delegate
    }
    
    
    /// Configurando o dataSource da Teble View
    public func setTableDataSource(to dataSource: UITableViewDataSource) -> Void {
        self.groupsTable.dataSource = dataSource
    }
    
    
    /// Atrualiza os dados da tabela
    public func reloadTableData() -> Void {
        self.groupsTable.reloadData()
        self.groupsTable.reloadInputViews()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        //if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
            self.groupsTable.reloadInputViews()
            
            self.viewSize = self.bounds
        //}
    }
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.backgroudButton)
        self.addSubview(self.container)
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.newGroupButton)
        self.container.addSubview(self.groupsTable)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        self.container.layer.cornerRadius = self.bounds.height * 0.01
        
        self.groupsTable.layer.cornerRadius = self.bounds.height * 0.01
        self.groupsTable.rowHeight = self.groupsTable.bounds.height * 0.15
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleLabel.setupText(with: FontConfig(
            text: "Grupos", fontSize: self.bounds.height * 0.03, weight: .bold)
        )
        
        
        /* Botões */
        self.newGroupButton.setupIcon(with: IconConfig(
            icon: .add, size:  self.bounds.height * 0.026, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 10
        
        NSLayoutConstraint.activate([
            self.backgroudButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroudButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroudButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroudButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: space),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.container.centerXAnchor),
            
            
            self.groupsTable.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: space),
            self.groupsTable.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -space),
            self.groupsTable.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -space),
            self.groupsTable.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: space),
            
            
            self.newGroupButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.newGroupButton.trailingAnchor.constraint(equalTo: self.groupsTable.trailingAnchor),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
    
        self.dynamicConstraints = [
            self.newGroupButton.widthAnchor.constraint(equalToConstant: self.newGroupButton.bounds.height),
            
            self.container.heightAnchor.constraint(equalToConstant: self.bounds.height*0.3),
            self.container.widthAnchor.constraint(equalToConstant: self.bounds.width*0.3),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
