/* Gui Reis    -    gui.sreis25@gmail.com */


/// Botões usados na aplicação
enum AppButton: CustomStringConvertible {
    /// Símbolo - 􀊫
    case search
    
    /// Símbolo - 􀈑
    case trash
    
    /// Símbolo - 􀊫
    case share
    
    /// Símbolo - 􀅼
    case add
    
    /// Símbolo - 􀅉
    case reload
    
    /// Símbolo - 􀍠
    case menu
    
    /// Símbolo - 􀋭
    case visible
    
    /// Símbolo - 􀋯
    case notVisible
    
    /// Símbolo - 􀠧
    case favorite
    
    /// Símbolo - 􀃜
    case addQuare
    
    
    var description: String {
        switch self {
        case .search: return "magnifyingglass"
        case .trash: return "trash"
        case .share: return "square.and.arrow.up"
        case .add: return "plus"
        case .reload: return "arrow.counterclockwise"
        case .menu: return "ellipsis"
        case .visible: return "eye"
        case .notVisible: return "eye.slash"
        case .favorite: return "star.square"
        case .addQuare: return "plus.square"
        }
    }
}
