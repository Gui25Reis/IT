/* Gui Reis     -    gui.sreis25@gmail.com */


/// Modelo de informações de um documento
struct DocumentInfo {
    var id: Int16
    var group: String
    var categories: [TagConfig]
    var title: String
    var links: [LinkInfo]
    var isFavorited: Bool
}
