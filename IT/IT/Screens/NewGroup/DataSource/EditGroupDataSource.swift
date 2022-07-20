/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import UIKit

class EditGroupDataSource: NSObject, UITableViewDataSource {
    
    /* MARK: - Atributos */
    
    /// Textos que foram editados/modificados enquanto a tela estava sendo apresentada
    private var textChanges: [Int:String] = [:]
    
    
    /// Comunicação com a controller (EditGroupViewController)
    private weak var delegate: EditGroupDelegate?
        
    
    
    /* MARK: - Encapsulamento */
    
    /// Defien a comunicação com a controller
    public func setDelegate(_ delegate: EditGroupDelegate) -> Void {
        self.delegate = delegate
    }
    
    
    /// Retorna a lista de textos atualizada
    public func getTextsChanges() -> [Int:String] {
        return self.textChanges
    }
    
    
    
    /* MARK: - Data Sources */
    
    /// Mostra quantas células vão ser mostradas
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EditGroupController.groups.count
    }
    
    
    /// Configura uma célula
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Cria uma variácel para mexer com uma célula que foi criada
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EditGroupCell.identifier, for: indexPath) as? EditGroupCell else {
            return EditGroupCell()
        }
        
        let row = indexPath.row
        let list = EditGroupController.groups
        
        let tag = list[row]
        
        // Configurando célula
        if let text = self.textChanges[row] {       // Já foi configurada
            cell.setupCell(with: text, tag: row)
        } else {                                    // Primeira vez
            cell.setupCell(with: tag.text, tag: row)
            
            cell.setTextFieldAction(target: self, action: #selector(self.textFieldEditAction(sender:)))
            
            // Atualizando o texto
            self.textChanges[row] = tag.text
            
            // Nova célula
            if let delegate = self.delegate {
                if delegate.isNewGroup(at: row) {
                    cell.setupNewCell()
                }
            }
            
        }
        
        return cell
    }
    
    
    
    /* MARK: - Ações de Botões */
    
    /// Ação do que acontece no textfield da célula
    @objc private func textFieldEditAction(sender textField: UITextField) -> Void {
        self.updateText(at: textField.tag, with: textField.text ?? "")
    }
    
    
    
    /* MARK: - Configurações */
    
    /// Atualiza o texto de acrodo com a mudança feita
    private func updateText(at index: Int, with text: String) -> Void {
        self.textChanges[index] = text
        
        if let delegate = self.delegate {
            delegate.updateNewGroup(at: index, with: text)
        }
    }
}
