/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

/// Salva informações de uma cor (modelo para salvar no banco de dados)
struct ColorInfo {
    var red: Float
    var blue: Float
    var green: Float
    var alpha: Float
    var hex: String
    
    init () {
        self.red = 0
        self.blue = 0
        self.green = 0
        self.alpha = 1
        self.hex = ""
    }
    
    init (red: Float, blue: Float, green: Float, alpha: Float) {
        self.red = red
        self.blue = blue
        self.green = green
        self.alpha = alpha
        
        self.hex = String.init(
            format: "%02lX%02lX%02lX",
            lroundf(self.red * 255),
            lroundf(self.green * 255),
            lroundf(self.blue * 255)
        )
    }
}
