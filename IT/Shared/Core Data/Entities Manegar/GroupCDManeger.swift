/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class GroupCDManeger {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: GroupCDManeger = GroupCDManeger()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "Group"
        
    
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
    
    /// Pega um único grupo
    public func getGruop(at groupID: Int16) -> Group? {
        let fr = NSFetchRequest<Group>(entityName: self.entityName)
        do {
            let allGroups = try self.mainContext.fetch(fr)
            
            for group in allGroups {
                if group.id == groupID {
                    return group
                }
            }
            return nil
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos os grupos
    public func getAllGroups() -> [Group] {
        let fr = NSFetchRequest<Group>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        }catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo grupo no core data
    public func addNewGroup(with data: GroupInfo) throws -> Group {
        let group = Group(context: self.mainContext)
        
        group.id = data.id
        group.title = data.title
        
        self.saveContext()
        return group
    }
    
    
    /// Remove um dado no Core Data
    public func deleteGroup(at item: Group) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
}
