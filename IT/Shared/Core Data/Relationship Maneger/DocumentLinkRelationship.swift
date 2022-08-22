/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class DocumentLinkRelationship {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: DocumentLinkRelationship = DocumentLinkRelationship()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "DocumentLink"
        
    
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
    
    /// Pega as categorias de um determinado documento
    public func getLinksFrom(documentID: Int16) -> [Link]? {
        let fr = NSFetchRequest<DocumentLink>(entityName: self.entityName)
        do {
            let allLinks = try self.mainContext.fetch(fr)
            
            var linksInDocument: [Link] = []
            
            for link in allLinks {
                if link.idDocument == documentID {
                    if let lk = LinkCDManeger.shared.getLink(at: link.idLink) {
                        linksInDocument.append(lk)
                    }
                }
            }
            return linksInDocument
                
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos as relações
    public func getAllRelations() -> [DocumentLink] {
        let fr = NSFetchRequest<DocumentLink>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo dado no core data
    public func addNewRelation(with data: DocLink) throws -> DocumentLink {
        let relation = DocumentLink(context: self.mainContext)
        
        relation.idLink = data.idLink
        relation.idDocument = data.idDocument
        
        self.saveContext()
        return relation
    }
    
    
    /// Remove um dado no Core Data a partir de um item específico
    public func deleteRelation(at item: DocumentLink) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
    
    
    /// Remove todas as relações a partir de um documento específico no Core Data
    public func deleteCategoriesFrom(documentID: Int16) throws {
        for link in self.getAllRelations() {
            if link.idDocument == documentID {
                self.mainContext.delete(link)
            }
        }
        self.saveContext()
    }
}
