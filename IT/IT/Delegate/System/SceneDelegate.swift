/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /* MARK: - Atributos */
    
    /// Define a janela principal (inicial)
    var window: UIWindow?

    
    
    /* MARK: - Delegate */
    
    public func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MenuViewController()
        window?.makeKeyAndVisible()
    }
}
