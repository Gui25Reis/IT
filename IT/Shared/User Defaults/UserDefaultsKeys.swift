/* Gui Reis     -    gui.sreis25@gmail.com */


/// Chaves usadas no User Defaults
enum UserDefaultsKeys: CustomStringConvertible {
    
    /// Core Data: contador (auto incremento) do id de Documentos
    case cdDocument
    
    /// Core Data: contador (auto incremento) do id dos grupos de documentos
    case cdGroup
    
    /// Core Data: contador (auto incremento) do id das categorias (tags) dos documentos
    case cdCategory
    
    /// Core Data: contador (auto incremento) do id dos links dos documentos
    case cdLink
    
    
    var description: String {
        switch self {
        case .cdDocument: return "cdDocument"
        case .cdGroup: return "cdGroup"
        case .cdCategory: return "cdCategory"
        case .cdLink: return "cdLink"
        }
    }
}
