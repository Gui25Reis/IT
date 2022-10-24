/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


class AllCategoriesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    static var data = [
        TagConfig(text: "Código", color: .tertiaryLabel),
        TagConfig(text: "Documentação", color: .tertiaryLabel),
        TagConfig(text: "Teoria", color: .tertiaryLabel),
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        let data = Self.data[indexPath.row]
        cell.setupTag(with: data)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let data = Self.data[row]
        SelectedCategoriesDataSource.data.append(data)
        
        Self.data.remove(at: row)
        
        self.controllerProtocol?.reloadCollectionData()
    }
    
    
    weak var controllerProtocol: CategoriesProtocol?
}




class SelectedCategoriesDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    static var data: [TagConfig] = [] {
        didSet {
            DocumentTagsOKDataSource.tags = Self.data
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Self.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        
        let data = Self.data[indexPath.row]
        cell.setupTag(with: data)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        let data = Self.data[row]
        AllCategoriesDataSource.data.append(data)
        
        Self.data.remove(at: row)
        
        self.controllerProtocol?.reloadCollectionData()
    }
    
    
    weak var controllerProtocol: CategoriesProtocol?
}



protocol CategoriesProtocol: NSObject {
    
    func reloadCollectionData()
}


class CategoriesViewController: UIViewController, CategoriesProtocol {
        
    func reloadCollectionData() {
        self.myView.reloadCollectionData()
    }
    
    private let allCategoriesManager = AllCategoriesDataSource()
    
    private let selectedCategoriesManager = SelectedCategoriesDataSource()
    
    
    /* MARK: - Atributos */
    
    private var myView: CategorieView
    
    
    
    /* MARK: - Construtor */
    
    init(with viewType: CategorieViewType) {
        self.myView = CategorieView(setupFor: viewType)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
        
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.setupButtonsAction()
        
        self.allCategoriesManager.controllerProtocol = self
        self.selectedCategoriesManager.controllerProtocol = self
        self.myView.allCategoriesCollection.dataSource = self.allCategoriesManager
        self.myView.allCategoriesCollection.delegate = self.allCategoriesManager
        
        self.myView.selectedCategoriesCollection.dataSource = self.selectedCategoriesManager
        self.myView.selectedCategoriesCollection.delegate = self.selectedCategoriesManager
    }
    
    
    /* MARK: - Ações de botões */
    
    /// Ação de sair da tela
    @objc private func dismissAction() -> Void {
        self.dismiss(animated: false)
    }
    
    
    /// Ação de sair da tela
    @objc private func openNewCategorieSetupAction() -> Void {
        let vc = CategorieSetupViewController()
        vc.modalPresentationStyle = .overFullScreen
        
        self.present(vc, animated: false)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Define as ações dos botões
    private func setupButtonsAction() -> Void {
        self.myView.setDismssAction(target: self, action: #selector(self.dismissAction))
        self.myView.setNewCategorieAction(target: self, action: #selector(self.openNewCategorieSetupAction))
    }
}
