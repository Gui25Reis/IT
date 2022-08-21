/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit


extension UIColor {
    
    /// Pega as informações da cor - red (vermelho), blue (azul), green (verde), alpha (alfa)
    internal func getColorInfo() -> ColorInfo {
        
        var colorsNumber: [Float] = [0, 0, 0, 1]
        
        if let colors = self.cgColor.components {
            for index in 0..<colors.count {
                colorsNumber[index] = Float(colors[index])
            }
        }
        
        let colorInfo = ColorInfo(
            red: colorsNumber[0],
            blue: colorsNumber[1],
            green: colorsNumber[2],
            alpha: Float(self.cgColor.alpha)
        )
        
        return colorInfo
    }
    
    var hexString: String? {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        let multiplier = CGFloat(255.999999)

        guard self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return nil
        }

        if alpha == 1.0 {
            return String(
                format: "#%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier)
            )
        }
        else {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                Int(red * multiplier),
                Int(green * multiplier),
                Int(blue * multiplier),
                Int(alpha * multiplier)
            )
        }
    }
}
