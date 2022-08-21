/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CategorieSetupViewController: UIViewController, CategorieSetupViewControllerDelegate {
    
    /* MARK: - Atributos */
    
    private let myView = CategorieSetupView()
    
    /* Delegates */
    
    /// Data Source da tabela de ediçào da categoria
    private let categorieSetupDataSource = CategorieSetupDataSource()
    
    /// Delegate  do color picker
    private let colorPickerDelegate = ColorPickerDelegate()
    
    
    
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
    
    internal func openColorPicker() -> Void {
        let vc = UIColorPickerViewController()
        vc.delegate = self.colorPickerDelegate
        
        self.present(vc, animated: true)
    }
    
    
    internal func updateColorSelected(to color: UIColor) -> Void {
        self.myView.updateColorSelected(to: color)
    }
    
    
    internal func updateStringCount(to num: Int) -> Void {
        self.myView.updateStringCount(to: num)
    }
    
    
    internal func getStringCountAllowed() -> Int {
        return self.myView.maxCaracteresGranted
    }
    
    
    
    /* MARK: - Ações de botões */
    
    /// Ação do botão de cancelar
    @objc private func cancelAction() -> Void {
        self.dismiss(animated: false)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Definindo as ações dos botões
    private func setupButtonAction() -> Void {
        self.myView.setCancelAction(target: self, action: #selector(self.cancelAction))
        self.myView.setSaveAction(target: self, action: #selector(self.cancelAction))
    }
    
    
    /// Definindo os delegates e protocols
    private func setupDelegates() -> Void {
        self.categorieSetupDataSource.setDelegate(wirh: self)
        self.myView.setTableDataSource(to: self.categorieSetupDataSource)
        
        self.colorPickerDelegate.setDelegate(with: self)
    }
}
