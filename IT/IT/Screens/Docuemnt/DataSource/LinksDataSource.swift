/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinksDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Lista de tags que vão ser mostradas no documento
    private var links: [LinkInfo] = []
    
    
    private var tableWasSet: Bool = false
    
    
    /// Lista de tags que vão ser mostradas no documento
    private var delegate: DocumentControllerDelegate?
    
    
    
    /* MARK: - Construtor */
    
    init(links: [LinkInfo]) {
        super.init()
        
        self.links = links
    }
    
    
    /* MARK: - Delegate */
    
    /// Define o delegate da classe
    public func setDelegate(with delegate: DocumentControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.links.count
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier, for: indexPath) as? LinkCell else {
            return UITableViewCell()
        }
        
        // Configura a célula
        let link = self.links[indexPath.row]
        cell.setupCell(with: link, tag: indexPath.row)
        
        // Ações de botões
        cell.setOptionsAction(target: self, action: #selector(self.editAction(sender:)))
        cell.setLinkAction(target: self, action: #selector(self.showLinkPreviewAction(sender:)))
        
        
        if let actualLinkIndex = self.delegate?.getActualLinkPreview() {
            cell.changeLinkVisibilityIcon(for: indexPath.row == actualLinkIndex)
        }
        
        return cell
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Abre a página de edição do link
    @objc func editAction(sender: UIButton) -> Void {
        self.delegate?.openLinkPage(with: sender.tag)
    }
    
    /// Define o preview
    @objc func showLinkPreviewAction(sender: UIButton) -> Void {
        self.delegate?.openLinkView(for: sender.tag)
    }
}
