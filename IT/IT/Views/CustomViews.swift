/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CustomViews {
    
    /* MARK: - Métodos */
    
    /// Botões com escrita
    static func newButton() -> UIButton {
        let bt = UIButton()

        bt.translatesAutoresizingMaskIntoConstraints = false
        return bt
    }
    

    /// Label
    static func newLabel(alignment: NSTextAlignment = .left) -> UILabel {
        let lbl = UILabel(frame: .zero)
        lbl.textAlignment = alignment
        
        // lbl.textColor = UIColor(appColor: .text)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    
    /// Cria uma nova view
    static func newView() -> UIView {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    
    /// Cria uma table
    static func newTable() -> UITableView {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.clipsToBounds = true
        tv.layer.masksToBounds = true
        
        // tv.backgroundColor = UIColor(appColor: .suecaCard)
        
        tv.alwaysBounceVertical = false
        tv.alwaysBounceHorizontal = false
        
        // Tirando o espaço do topo
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        
        let view = UIView(frame: frame)
        tv.tableHeaderView = view
        tv.tableFooterView = view
        return tv
    }
    
    
    /// Cria uma collection
    static func newCollection() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.collectionViewLayout = UICollectionViewFlowLayout()
        cv.clipsToBounds = true
        cv.layer.masksToBounds = true
        
        cv.alwaysBounceVertical = false
        cv.alwaysBounceHorizontal = false
        
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }
}
