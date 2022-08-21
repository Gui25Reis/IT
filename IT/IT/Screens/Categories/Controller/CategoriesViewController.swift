/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CategoriesViewController: UIViewController {
    
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
