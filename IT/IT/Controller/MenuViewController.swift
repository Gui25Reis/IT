/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Cocoa


/// Controller para a tela principal - Menu
class MenuViewController: NSViewController {
    
    /* MARK: - Atributos */
    
    let myView = MenuView()
    
//    init() {
//        super.init(nibName: "IT.MenuViewController", bundle: nil)
//        self.view = myView
//
//        print("Estou no INIT")
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    override func loadView() {
        // super.loadView()
        
        
        let myView = MenuView()
        self.view = myView
        
        print("Estou no LoadView")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        print("Estou no DidLoad")
    }
}
