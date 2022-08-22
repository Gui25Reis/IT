/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class LinkCDManeger {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: LinkCDManeger = LinkCDManeger()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "Link"
        
    
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
    
    /// Pega um único link
    public func getLink(at linkID: Int16) -> Link? {
        let fr = NSFetchRequest<Link>(entityName: self.entityName)
        do {
            let allLinks = try self.mainContext.fetch(fr)
            
            for link in allLinks {
                if link.id == linkID {
                    return link
                }
            }
            return nil
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos os links
    public func getAllLinks() -> [Link] {
        let fr = NSFetchRequest<Link>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo dado no core data
    public func addNewLink(with data: LinkInfo) throws -> Link {
        let link = Link(context: self.mainContext)
        
        link.id = data.id
        link.title = data.title
        link.link = data.link
        
        self.saveContext()
        return link
    }
    
    
    /// Remove um dado no Core Data
    public func deleteLink(at item: Link) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
}
