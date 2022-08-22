/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class CategoryCDManeger {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: CategoryCDManeger = CategoryCDManeger()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "Category"
        
    
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
    
    /// Pega uma única categoria
    public func getCategorie(at categoryID: Int16) -> Category? {
        let fr = NSFetchRequest<Category>(entityName: self.entityName)
        do {
            let allCategories = try self.mainContext.fetch(fr)
            
            for category in allCategories {
                if category.id == categoryID {
                    return category
                }
            }
            return nil
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos as categorias
    public func getAllCategories() -> [Category] {
        let fr = NSFetchRequest<Category>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo dado no core data
    public func addNewCategory(with data: CategoryInfo) throws -> Category {
        let category = Category(context: self.mainContext)
        
        category.id = data.id
        category.title = data.title
        category.color = data.color
        
        self.saveContext()
        return category
    }
    
    
    /// Remove um dado no Core Data
    public func deleteCategory(at item: Category) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
}
