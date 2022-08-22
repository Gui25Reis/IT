/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinkSetupDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    private var linkInfo: LinkInfo?
    
    
    private var delegate: LinkSetupViewControllerDelegate?

    
    /* MARK: - Construtor */
    
    // init() {
    //     super.init()
    // }
    
    
    /* MARK: - Encapsulamento */
    
    public func setLinkInfo(wirh linkInfo: LinkInfo) -> Void {
        self.linkInfo = linkInfo
    }
    
    
    public func setDelegate(wirh delegate: LinkSetupViewControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputInfoCell.identifier, for: indexPath) as? InputInfoCell else {
            return UITableViewCell()
        }
        
        
        if indexPath.row == 0 {
            cell.setBackgroundText(with: "Nome")
            if let name = self.linkInfo?.title {
                cell.setupCell(with: name, tag: 0)
            }

        } else {
            cell.setBackgroundText(with: "Link (Url)")
            cell.setTextFieldAction(target: self, action: #selector(self.checkUrlAction(sender:)))
            if let link = self.linkInfo?.link {
                cell.setupCell(with: link, tag: 0)
            }
        }
        
        return cell
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação do TextField que é acionada toda vez que tem uma modificação
    @objc private func checkUrlAction(sender: UITextField) -> Void {
        if let delegate = self.delegate {
            delegate.validateUrl(with: sender.text)
        }
    }
}
