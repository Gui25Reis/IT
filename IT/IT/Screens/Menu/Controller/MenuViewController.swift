/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class MenuViewController: UIViewController {
    
    /* MARK: - Atributos */
    
    /// View principal que a classe vai controlar
    private let myView = MenuView()
    
    
    
    /* MARK: - Ciclo de Vida */
    
    public override func loadView() -> Void {
        super.loadView()
        
        self.view = self.myView
    }
    
    
    public override func viewDidLoad() -> Void {
        super.viewDidLoad()
    }
    
    
    /* MARK: - Ações de botões */
    
    
    
    /* MARK: - Configurações */
    
}
