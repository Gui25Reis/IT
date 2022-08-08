/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkSetupViewController: UIViewController, LinkSetupViewControllerDelegate {
    
    /* MARK: - Atributos */
    
    /// View principal que vai ser controlada
    private let myView = LinkSetupView()
    
    /// Informações do link
    private var linkInfo: LinkInfo?
    
    
    private let linkSetupDataSource = LinkSetupDataSource()
    
    
    
    /* MARK: - Construtor */
    
    init(with linkInfo: LinkInfo?) {
        super.init(nibName: nil, bundle: nil)
        
        if let linkInfo = linkInfo {
            self.linkInfo = linkInfo
            self.linkSetupDataSource.setLinkInfo(wirh: linkInfo)
        }
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
        
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
        
        self.setupButtonAction()
        self.setupDelegates()
    }
    
    
    
    /* MARK: - Delegate (Protocol) */
    
    internal func validateUrl(with url: String?) {
        var validate: Bool?
        if let url = url {
            if url.count == 0 {
                validate = nil
            } else {
                if let testUrl = URL(string: url) {
                    validate = UIApplication.shared.canOpenURL(testUrl)
                } else {
                    validate = false
                }
            }
        }
        self.myView.setUrlWarning(to: validate)
    }
    
    
    
    /* MARK: - Ações de botões */
    
    @objc private func cancelAction() -> Void {
        self.dismiss(animated: false)
    }
    
    
    
    /* MARK: - Configurações */
    
    private func setupButtonAction() -> Void {
        self.myView.setCancelAction(target: self, action: #selector(self.cancelAction))
        self.myView.setSaveAction(target: self, action: #selector(self.cancelAction))
    }
    
    
    private func setupDelegates() -> Void {
        self.linkSetupDataSource.setDelegate(wirh: self)
        self.myView.setTableDataSource(to: self.linkSetupDataSource)
        
        self.myView.reloadTableData()
    }
}
