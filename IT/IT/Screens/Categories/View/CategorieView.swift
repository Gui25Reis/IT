/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CategorieView: UIView {
    
    public func reloadCollectionData() {
        self.selectedCategoriesCollection.reloadData()
        self.selectedCategoriesCollection.reloadInputViews()
        
        self.allCategoriesCollection.reloadData()
        self.allCategoriesCollection.reloadInputViews()
    }
    
    /* MARK: - Atributos */
    
    // Views
    
    private let backgroundButton = CustomViews.newButton()
    
    private let container = CustomViews.newView()
    
    private let titleLabel = CustomViews.newLabel()
    
    private let newCategorieButton = CustomViews.newButton()
    
    
    private let selectedCategoriesLabel = CustomViews.newLabel()
    
    public let selectedCategoriesCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        // cv.backgroundColor = .orange
        return cv
    }()
    
    
    private let allCategoriesLabel = CustomViews.newLabel()
    
    public let allCategoriesCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        // cv.backgroundColor = .red
        return cv
    }()
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 40)
        
        return layout
    }()
    
    private let collectionLayout2: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 150, height: 40)
        
        return layout
    }()
    
    
    // Outros
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    /// Estilo que a view vai ter
    private var style: CategorieViewType
    


    /* MARK: - Construtor */
    
    init(setupFor style: CategorieViewType) {
        self.style = style
        
        super.init(frame: .zero)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        
        self.container.backgroundColor = .systemBackground
        
        self.setupViews()
        self.setupConstraints()
        
        
        self.allCategoriesCollection.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        self.selectedCategoriesCollection.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        
        self.allCategoriesCollection.collectionViewLayout = self.collectionLayout
        self.selectedCategoriesCollection.collectionViewLayout = self.collectionLayout2
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de Botões */
    
    /// Ação do botão de fechar a tela
    public func setDismssAction(target: Any?, action: Selector) -> Void {
        self.backgroundButton.addTarget(target, action: action, for: .touchDown)
    }
    
    /// Ação do botão de adicionar uma nova categoria
    public func setNewCategorieAction(target: Any?, action: Selector) -> Void {
        self.newCategorieButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        // if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
            
            self.viewSize = self.bounds
        // }
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.backgroundButton)
        self.addSubview(self.container)
        
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.newCategorieButton)
        
        
        switch self.style {
        case .visualization: break
            
        case .canSelect:
            self.container.addSubview(self.selectedCategoriesLabel)
            self.container.addSubview(self.selectedCategoriesCollection)
            
            self.container.addSubview(self.allCategoriesLabel)
        }
        
        self.container.addSubview(self.allCategoriesCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        let radius: CGFloat = self.bounds.height * 0.01
        
        self.container.layer.cornerRadius = radius*2
        
        self.selectedCategoriesCollection.layer.cornerRadius = radius
        self.allCategoriesCollection.layer.cornerRadius = radius
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        /* Labels */
        self.titleLabel.setupText(with: FontConfig(
            text: "Categorias", fontSize: self.bounds.height * 0.025, weight: .semibold)
        )
        
        self.selectedCategoriesLabel.setupText(with: FontConfig(
            text: "Selecionadas", fontSize: self.bounds.height * 0.02, weight: .medium)
        )
        
        self.allCategoriesLabel.setupText(with: FontConfig(
            text: "Todas", fontSize: self.bounds.height * 0.02, weight: .medium)
        )
        
        
        /* Botões */
        self.newCategorieButton.setupIcon(with: IconConfig(
            icon: .add, size: self.bounds.height * 0.02, weight: .medium, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        NSLayoutConstraint.activate([
            self.backgroundButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.container.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.container.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        let space = self.bounds.height*0.02
        
        let between: CGFloat = self.bounds.height*0.018
        
        
        self.dynamicConstraints = [
            self.container.heightAnchor.constraint(equalToConstant: self.bounds.height*0.65),
            self.container.widthAnchor.constraint(equalToConstant: self.bounds.width*0.65),
            
            
            self.titleLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: space),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: space),
            
            
            self.newCategorieButton.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor),
            self.newCategorieButton.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -space),
            
            
            
            self.allCategoriesCollection.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.allCategoriesCollection.trailingAnchor.constraint(equalTo: self.newCategorieButton.trailingAnchor),
            self.allCategoriesCollection.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -space)
        ]
        
        switch self.style {
        case .visualization:
            self.dynamicConstraints += [
                self.allCategoriesCollection.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between/2),
            ]
            
        case .canSelect:
            self.dynamicConstraints += [
                self.selectedCategoriesLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: between),
                self.selectedCategoriesLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
                
                
                self.selectedCategoriesCollection.topAnchor.constraint(equalTo: self.selectedCategoriesLabel.bottomAnchor, constant: between/2),
                self.selectedCategoriesCollection.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
                self.selectedCategoriesCollection.trailingAnchor.constraint(equalTo: self.newCategorieButton.trailingAnchor),
                self.selectedCategoriesCollection.heightAnchor.constraint(equalToConstant: self.container.bounds.height*0.1),
                
                
                self.allCategoriesLabel.topAnchor.constraint(equalTo: self.selectedCategoriesCollection.bottomAnchor, constant: between*1.5),
                self.allCategoriesLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
                
                
                self.allCategoriesCollection.topAnchor.constraint(equalTo: self.allCategoriesLabel.bottomAnchor, constant: between/2),
            ]
        }
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
