/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class GroupView: UIView {
    
    /* MARK: - Atributos */
    
    // Views

    private let favoriteButton = CustomViews.newButton()
    private let newGroupButton = CustomViews.newButton()
    
    private let groupCollection: UICollectionView = {
        let cv = CustomViews.newCollection()
        cv.register(TagCell.self, forCellWithReuseIdentifier: TagCell.identifier)
        return cv
    }()
    
    
    // Outros
    
    private let collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        return layout
    }()
    
    /// Constraints que vão mudar de acordo com o tamanho da tela
    private var dynamicConstraints: [NSLayoutConstraint] = []
    
    
    /// Salva a última dimensão da tela
    private var viewSize: CGRect = .zero
    
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.groupCollection.collectionViewLayout = self.collectionLayout
        
        self.setupViews()
        self.setupConstraints()
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    
    
    /* MARK: - Encapsulamento */
    
    /* Ações de Botões */
    
    /// Ação do botão de favoritos
    public func setFavoriteAction(target: Any?, action: Selector) -> Void {
        self.favoriteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /// Ação do botão de manter um grupo
    public func setNewGroupAction(target: Any?, action: Selector) -> Void {
        self.newGroupButton.addTarget(target, action: action, for: .touchDown)
    }
    
    
    /* Collection */
    
    /// Define qual vai ser o Data Source da collection
    public func setGroupCollectionDataSource(with dataSource: GroupDataSource) -> Void {
        self.groupCollection.dataSource = dataSource
    }
    
    
    /// Define qual vai ser o delegate da collection
    public func setGroupCollectionDelegate(with delegate: GroupDelegate) -> Void {
        self.groupCollection.delegate = delegate
    }
    
    
    /// Atualiza a collection
    public func reloadGroups() -> Void {
        self.groupCollection.reloadData()
        self.groupCollection.reloadInputViews()
    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func layoutSubviews() -> Void {
        super.layoutSubviews()
        
        if self.bounds != self.viewSize {
            self.setupUI()
            self.setupStaticTexts()
            self.setupDynamicConstraints()
            
            self.reloadInputViews()
            self.groupCollection.reloadInputViews()
            
            self.viewSize = self.bounds
        }
    }
    
    
    
    /* MARK: - Configurações */
        
    /// Adiciona os elementos (Views) na tela
    private func setupViews() -> Void {
        self.addSubview(self.favoriteButton)
        self.addSubview(self.newGroupButton)
        self.addSubview(self.groupCollection)
    }
    
    
    /// Personalização da UI
    private func setupUI() -> Void {
        let cellSize = CGSize(
            width: self.groupCollection.bounds.width * 0.09,
            height: self.groupCollection.bounds.height-1
        )
        self.collectionLayout.itemSize = cellSize
        
        self.groupCollection.reloadInputViews()
    }
    
    
    /// Define os textos que são estáticos (os textos em si que vão sempre ser o mesmo)
    private func setupStaticTexts() -> Void {
        let btSize: CGFloat = self.bounds.height
        
        self.favoriteButton.setupIcon(with: IconConfig(
            icon: .favoriteSquare, size: btSize, weight: .regular, scale: .medium)
        )
        
        self.newGroupButton.setupIcon(with: IconConfig(
            icon: .addSquare, size: btSize, weight: .regular, scale: .medium)
        )
    }
    
    
    /// Define as constraints que são estáticas (que não vão mudar ao longo do código)
    private func setupConstraints() -> Void {
        let space: CGFloat = 5
        
        NSLayoutConstraint.activate([
            self.favoriteButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.favoriteButton.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.newGroupButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.newGroupButton.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.newGroupButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            
            self.groupCollection.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.groupCollection.topAnchor.constraint(equalTo: self.topAnchor),
            self.groupCollection.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.groupCollection.rightAnchor.constraint(equalTo: self.newGroupButton.leftAnchor, constant: -space),
            self.groupCollection.leftAnchor.constraint(equalTo: self.favoriteButton.rightAnchor, constant: space),
        ])
    }
    
    
    /// Define as constraints que dependem do tamanho da tela
    private func setupDynamicConstraints() -> Void {
        NSLayoutConstraint.deactivate(self.dynamicConstraints)
        
        self.dynamicConstraints = [
            self.favoriteButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.1),
            self.favoriteButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            
            self.newGroupButton.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.1),
            self.newGroupButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
        ]
        
        NSLayoutConstraint.activate(self.dynamicConstraints)
    }
}
