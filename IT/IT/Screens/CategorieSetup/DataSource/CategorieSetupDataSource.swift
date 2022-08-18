/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class CategorieSetupDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    private var tagInfo: TagConfig? //= TagConfig(text: "Teste", color: .clear)
    
    
    /* Delegates */
    
    private var delegate: CategorieSetupViewControllerDelegate?
    
    
    private var textFielDelegate: TextFieldDelegate = TextFieldDelegate()
    
    
    
    
    
    /* MARK: - Encapsulamento */
    
    public func setTagInfo(wirh tagInfo: TagConfig) -> Void {
        self.tagInfo = tagInfo
    }
    
    
    public func setDelegate(wirh delegate: CategorieSetupViewControllerDelegate) -> Void {
        self.delegate = delegate
        self.textFielDelegate.setDelegate(with: delegate)
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InputInfoCell.identifier, for: indexPath) as? InputInfoCell else {
            return UITableViewCell()
        }
        
        
        cell.setBackgroundText(with: "Nome")
        if let name = self.tagInfo?.text, let color = self.tagInfo?.color {
            cell.setupCell(with: name, tag: 0)
            cell.updateButtonColor(to: color)
        }
        
        cell.style = .withColor
        self.setupButtonAction(for: cell)
        
        cell.setTextFieldDelegate(with: self.textFielDelegate)
        
        return cell
    }
    
    
    
    /* MARK: - Ações de Botões */
        
    /// Açào do botão de escolher a cor
    @objc private func openColorPickerAction() -> Void {
        if let delegate = self.delegate {
            delegate.openColorPicker()
        }
    }
    
    
    /// Açào do botão de escolher a cor
    @objc private func updateStringCountAction(sender: UITextField) -> Void {
        self.delegate?.updateStringCount(to: sender.text?.count ?? 0)
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Configura a ação dos botões
    private func setupButtonAction(for cell: InputInfoCell) -> Void {
        cell.setColorPickerAction(target: self, action: #selector(self.openColorPickerAction))
        cell.setTextFieldAction(target: self, action: #selector(self.updateStringCountAction(sender:)))
    }
}
