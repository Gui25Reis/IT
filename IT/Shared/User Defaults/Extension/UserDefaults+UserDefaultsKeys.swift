/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Foundation


extension UserDefaults {
    
    /// Faz um incremento e retorna o valor (pós incremento)
    internal static func autoIncrement(for key: UserDefaultsKeys) -> Int16 {
        var data = UserDefaults.standard.integer(forKey: key.description)
        data += 1
        
        UserDefaults.standard.set(data, forKey: key.description)
        return Int16(data)
    }
}
