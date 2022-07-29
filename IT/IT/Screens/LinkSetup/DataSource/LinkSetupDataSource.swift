/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkSetupDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    private var linkInfo: LinkInfo?

    
    /* MARK: - Construtor */
    
    // init() {
    //     super.init()
    // }
    
    
    /* MARK: - Encapsulamento */
    
    public func setLinkInfo(wirh linkInfo: LinkInfo) -> Void {
        self.linkInfo = linkInfo
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkInfoCell.identifier, for: indexPath) as? LinkInfoCell else {
            return UITableViewCell()
        }
        
        
        if indexPath.row == 0 {
            cell.setBackgroundText(with: "Nome")
            if let name = self.linkInfo?.name {
                cell.setupCell(with: name, tag: 0)
            }

        } else {
            cell.setBackgroundText(with: "Link (Url)")
            if let link = self.linkInfo?.link {
                cell.setupCell(with: link, tag: 0)
            }
        }
        
        return cell
    }
}
