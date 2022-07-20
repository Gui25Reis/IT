/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinksDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Lista de tags que vão ser mostradas no documento
    private var links: [LinkInfo] = []
    
    
    
    /* MARK: - Construtor */
    
    init(links: [LinkInfo]) {
        super.init()
        
        self.links = links
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
        
        cell.setupCell(with: link)
        
        return cell
        
    }
}
