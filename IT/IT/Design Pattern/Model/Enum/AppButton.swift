/* Gui Reis    -    gui.sreis25@gmail.com */


/// Botões usados na aplicação
enum AppButton: CustomStringConvertible {
    case search
    case trash
    case share
    case add
    case reload
    case menu
    case visible
    case notVisible
    
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
        }
    }
}
