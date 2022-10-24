/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class LinksDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    static weak var delegate2: DocumentProtocol?
    
    /// Lista de tags que vão ser mostradas no documento
    static var links: [LinkInfo] = [] {
        didSet {
            print(Self.links.count)
            Self.delegate2?.reloadTableData()
            print(Self.links.count)
        }
    }
    
    
    /// Lista de tags que vão ser mostradas no documento
    private var delegate: DocumentControllerDelegate?
    
    
    
    /* MARK: - Construtor */
    
    init(links: [LinkInfo]) {
        super.init()
        
        if !links.isEmpty {
            Self.links = links
        }
    }
    
    
    /* MARK: - Delegate */
    
    /// Define o delegate da classe
    public func setDelegate(with delegate: DocumentControllerDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Define quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("entrei aqui")
        return Self.links.count
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        
        print("oooooiiiii")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LinkCell.identifier, for: indexPath) as? LinkCell else {
            return UITableViewCell()
        }
        
        // Configura a célula
        let link = Self.links[indexPath.row]
        cell.setupCell(with: link, tag: indexPath.row)
        cell.tag = indexPath.row
        
        
        // Estado da célula se eh selecionada ou nào de acordo com o botão
        if let actualLinkIndex = self.delegate?.getActualLinkPreview() {
            if indexPath.row == actualLinkIndex {
                cell.changeLinkVisibilityIcon(for: true)
                tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
            } else {
                cell.changeLinkVisibilityIcon(for: false)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
        
        cell.setLinkAction(target: self, action: #selector(self.showLinkPreviewAction(sender:)))
        
        self.setupButtonsAction(for: cell)
        
        return cell
    }
    
    
    /* MARK: - Configurações */
    
    /// Define as ações dos botões da célula
    private func setupButtonsAction(for cell: LinkCell) -> Void {
        // Visualização da página
        cell.setLinkAction(target: self, action: #selector(self.showLinkPreviewAction(sender:)))
        
        // Conetxt Menu
        let editAction = UIAction(title: "Editar", image: UIImage(icon: .edit)) {_ in
            self.editAction(sender: cell)
        }
        
        let copyAction = UIAction(title: "Copiar", image: UIImage(icon: .copyLink)) {_ in
            self.copyLinkAction(sender: cell)
        }
        
        let openOnBrowserAction = UIAction(title: "Abrir no navegador", image: UIImage(icon: .goToWeb)) {_ in
            self.openLinkOnBrowserAction(sender: cell)
        }
        
        let deleteAction = UIAction(title: "Deletar", attributes: .destructive) {_ in
            self.deleteLinkAction(sender: cell)
        }
        
        let options = UIMenu(title: "", options: .displayInline,  children: [copyAction, editAction, openOnBrowserAction])
        
        let menu = UIMenu(title: "", children: [options, deleteAction])
        cell.setOptionsMenu(menu: menu)
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Define o link que vai ser mostrado no web preview
    @objc func showLinkPreviewAction(sender: UIButton) -> Void {
        print("Entre na função com \(sender.tag)")
        self.delegate?.openLinkOnWebView(for: sender.tag)
    }
    
    /* Conetxt Menu */
    
    /// Copia as informações do link (título e url) para o clipboard
    @objc func copyLinkAction(sender: UIView) -> Void {
        self.delegate?.copyLinkinfo(for: sender.tag)
    }
    
    
    /// Abre a página de edição do link
    @objc func editAction(sender: UIView) -> Void {
        self.delegate?.openLinkPage(with: sender.tag)
    }
    
    
    /// Abre o link em um navegador externo
    @objc func openLinkOnBrowserAction(sender: UIView) -> Void {
        self.delegate?.openLinkOnBrowser(for: sender.tag)
    }
    
    
    /// Deleta o link
    @objc func deleteLinkAction(sender: UIView) -> Void {
        self.delegate?.deleteLink(for: sender.tag)
    }
}



/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */


class DocumentTagsOKDataSource: NSObject, UICollectionViewDataSource {
    
    static weak var documentProtocol: DocumentProtocol?
    
    /* MARK: - Atributos */
    
    /// Lista de tags que vão ser mostradas no documento
    static var tags: [TagConfig] = [] {
        didSet {
            Self.documentProtocol?.reloadColletionData()
        }
    }
    
    
    
    /* MARK: - Construtor */
    
    init(tags: [TagConfig]) {
        super.init()
        
        Self.tags = tags
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Self.tags.count
    }
    
    
    /// Configura uma célula
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.identifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        // Configura a célula
        let tag = Self.tags[indexPath.row]
        cell.setupTag(with: tag)
        
        // Desativa a seleção
        cell.allowSelection = false
        
        // Borda arredondada
        cell.layer.cornerRadius = collectionView.bounds.height * 0.15
        return cell
        
    }
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação para deletar uma linha da tabela
    
    
}
