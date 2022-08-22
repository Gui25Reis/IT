/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class DocumentGroupRelationship {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: DocumentGroupRelationship = DocumentGroupRelationship()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "DocumentGroup"
        
    
    /// Usada para fazer alterações na tabela
    private var mainContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    
    /// Tabela que a classe está mexendo (pegando a tebela e tornando em uma variável)
    private lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataInfo.coreDataName)
        container.loadPersistentStores() {_, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()


    
    /* MARK: - Configurações do Core Data */
    
    /// Salvando e atualizando alterações que tiveram no core data
    private func saveContext() -> Void {
        if self.mainContext.hasChanges {
            do {
                try self.mainContext.save()
            } catch(let errorGenerated) {
                print("Erro na hora de salvar \(errorGenerated)")
                fatalError("Unresolved error \(errorGenerated)")
            }
        }
    }
    
    
    
    /* MARK: - Acessando o Core Data (Encapsulamento) */
    
    /// Pega o grupo de um determinado documento
    public func getGroupFrom(documentID: Int16) -> Group? {
        let fr = NSFetchRequest<DocumentGroup>(entityName: self.entityName)
        do {
            let allGroups = try self.mainContext.fetch(fr)
            
            
            for group in allGroups {
                if group.idDocument == documentID {
                    if let gp = GroupCDManeger.shared.getGruop(at: group.idGroup) {
                        return gp
                    }
                }
            }
            
            return nil
                
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos as relações
    public func getAllRelations() -> [DocumentGroup] {
        let fr = NSFetchRequest<DocumentGroup>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo dado no core data
    public func addNewRelation(with data: DocGroup) throws -> DocumentGroup {
        let relation = DocumentGroup(context: self.mainContext)
        
        relation.idGroup = data.idGroup
        relation.idDocument = data.idDocument
        
        self.saveContext()
        return relation
    }
    
    
    /// Remove um dado no Core Data a partir de um item específico
    public func deleteRelation(at item: DocumentGroup) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
    
    
    /// Remove todas as relações a partir de um documento específico no Core Data
    public func deleteGroupFrom(documentID: Int16) throws {
        for category in self.getAllRelations() {
            if category.idDocument == documentID {
                self.mainContext.delete(category)
                self.saveContext()
                return
            }
        }
    }
}
