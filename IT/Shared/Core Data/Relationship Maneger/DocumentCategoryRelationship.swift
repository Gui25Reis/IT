/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class DocumentCategoryRelationship {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: DocumentCategoryRelationship = DocumentCategoryRelationship()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "DocumentCategory"
        
    
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
    public func getCategoriesFrom(documentID: Int16) -> [Category]? {
        let fr = NSFetchRequest<DocumentCategory>(entityName: self.entityName)
        do {
            let allCategories = try self.mainContext.fetch(fr)
            
            var categoriesInDocument: [Category] = []
            
            for category in allCategories {
                if category.idDocument == documentID {
                    if let cat = CategoryCDManeger.shared.getCategorie(at: category.idCategory) {
                        categoriesInDocument.append(cat)
                    }
                }
            }
            return categoriesInDocument
                
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos as relações
    public func getAllRelations() -> [DocumentCategory] {
        let fr = NSFetchRequest<DocumentCategory>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo dado no core data
    public func addNewRelation(with data: DocCategory) throws -> DocumentCategory {
        let relation = DocumentCategory(context: self.mainContext)
        
        relation.idCategory = data.idCategory
        relation.idDocument = data.idDocument
        
        self.saveContext()
        return relation
    }
    
    
    /// Remove um dado no Core Data a partir de um item específico
    public func deleteRelation(at item: DocumentCategory) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
    
    
    /// Remove todas as relações a partir de um documento específico no Core Data
    public func deleteCategoriesFrom(documentID: Int16) throws {
        for category in self.getAllRelations() {
            if category.idDocument == documentID {
                self.mainContext.delete(category)
            }
        }
        self.saveContext()
    }
}
