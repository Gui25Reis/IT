/* Gui Reis     -    gui.sreis25@gmail.com */


/// Modelo de informações de um documento
struct Document {
    var group: String
    var categories: [TagConfig]
    var title: String
    var links: [LinkInfo]
}
