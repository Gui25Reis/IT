/* Gui Reis    -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import Cocoa


/// Elementos de UI da tela de Menu
class MenuView: NSView {
    
    /* MARK: - Atributos */
    
    // let search: NSSearchField = CustomNSViews.newSearchField()
    
    
    let newDocumentButton: NSButton = CustomNSViews.newButton(with: .add)
    
    let reloadButton: NSButton = CustomNSViews.newButton(with: .reload)
    
    let categoriesButton: NSButton = CustomNSViews.newButton(with: .add)
    
    
    /* MARK: - Construtor */
    
    init() {
        super.init(frame: .zero)
        
        self.wantsLayer = true
        let color: NSColor = .tertiaryLabelColor
        self.layer?.backgroundColor = color.cgColor
        
        // self.addSubview(self.search)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    
    /* MARK: - Ciclo de Vida */
    
    
    override func layout() {
        super.layout()
        
        // let space: CGFloat = 50
        
        let safeArea: CGFloat = 15
        let btHeight: CGFloat = 30
        NSLayoutConstraint.activate([
            
//            self.search.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            self.search.topAnchor.constraint(equalTo: self.topAnchor, constant: safeArea),
//            self.search.heightAnchor.constraint(equalToConstant: btHeight),
//            self.search.widthAnchor.constraint(equalToConstant: 500),
            
            /* BOTÕES */
            
            // Novo documento
            self.newDocumentButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: safeArea),
            self.newDocumentButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -safeArea),
            self.newDocumentButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.newDocumentButton.widthAnchor.constraint(equalToConstant: btHeight),
            
            
            // Re-carregar
            self.reloadButton.topAnchor.constraint(equalTo: self.newDocumentButton.topAnchor),
            self.reloadButton.rightAnchor.constraint(equalTo: self.newDocumentButton.leftAnchor, constant: -safeArea),
            self.reloadButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.reloadButton.widthAnchor.constraint(equalToConstant: btHeight),
            
            
            // Categorias
            self.categoriesButton.topAnchor.constraint(equalTo: self.newDocumentButton.topAnchor),
            self.categoriesButton.rightAnchor.constraint(equalTo: self.reloadButton.leftAnchor, constant: -safeArea),
            self.categoriesButton.heightAnchor.constraint(equalToConstant: btHeight),
            self.categoriesButton.widthAnchor.constraint(equalToConstant: btHeight),
        ])
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Adiciona as views na tela
    private func setupViews() -> Void {
        self.addSubview(self.newDocumentButton)
        self.addSubview(self.reloadButton)
        self.addSubview(self.categoriesButton)
    }
    
    
    /// Define as constraints constantes
    private func setupStaticConstraints() -> Void {
        
    }
    
    
    /// Define as constraints constantes
    private func setupStaticConstraints() -> Void {
        
    }
}
