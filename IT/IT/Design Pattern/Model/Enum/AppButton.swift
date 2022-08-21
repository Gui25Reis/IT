/* Gui Reis    -    gui.sreis25@gmail.com */


/// Botões usados na aplicação
enum AppButton: CustomStringConvertible {
    /// Símbolo - 􀊫
    case search
    
    /// Símbolo - 􀈑
    case trash
    
    /// Símbolo - 􀈂
    case share
    
    /// Símbolo - 􀅼
    case add
    
    /// Símbolo - 􀅉
    case reload
    
    /// Símbolo - 􀍡
    case menu
    
    /// Símbolo - 􀋮
    case visible
    
    /// Símbolo - 􀋭
    case notVisible
    
    /// Símbolo - 􀠧
    case favoriteSquare
    
    /// Símbolo - 􀃜
    case addSquare
    
    /// Símbolo - 􀰌
    case back
    
    /// Símbolo - 􀋂
    case favoriteFalse
    
    /// Símbolo - 􀋃
    case favoriteTrue
    
    /// Símbolo - 􀈟
    case goToWeb
    
    /// Símbolo - 􀈊
    case edit
    
    /// Símbolo - 􀉃
    case copyLink
    
    /// Símbolo - 􀋡
    case tag
    
    /// Símbolo - 􀁡
    case close
    
    
    var description: String {
        switch self {
        case .search: return "magnifyingglass"
        case .trash: return "trash"
        case .share: return "square.and.arrow.up"
        case .add: return "plus"
        case .reload: return "arrow.counterclockwise"
        case .menu: return "ellipsis.circle"
        case .visible: return "eye.fill"
        case .notVisible: return "eye"
        case .favoriteSquare: return "star.square"
        case .addSquare: return "plus.square"
        case .back: return "arrow.backward"
        case .favoriteFalse: return "star"
        case .favoriteTrue: return "star.fill"
        case .goToWeb: return "paperplane"
        case .edit: return "pencil"
        case .copyLink: return "doc.on.clipboard"
        case .tag: return "tag"
        case .close: return "xmark.circle.fill"
        }
    }
}
