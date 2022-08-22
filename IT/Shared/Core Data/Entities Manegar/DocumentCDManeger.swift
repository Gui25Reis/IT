/* Gui Reis     -    gui.sreis25@gmail.com */

/* Bibliotecas necessárias: */
import CoreData


class DocumentCDManeger {
    
    /* MARK: - Atributos */
    
    /// Variável singleton para lidar com as informaçòes do Core Data
    static let shared: DocumentCDManeger = DocumentCDManeger()
    
    
    /// Nome da entidade "tabela" que a classe está lidando
    private let entityName: String = "Document"
        
    
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
    
    /// Pega um único documento
    public func getDocument(at documentID: Int) -> Document? {
        let fr = NSFetchRequest<Document>(entityName: self.entityName)
        do {
            let allDocuments = try self.mainContext.fetch(fr)
            
            for document in allDocuments {
                if document.id == documentID {
                    return document
                }
            }
            return nil
        } catch {
            print(error)
        }
        return nil
    }
    
    
    /// Pega todos os documentos criados
    public func getAllDocuments() -> [Document] {
        let fr = NSFetchRequest<Document>(entityName: self.entityName)
        do {
            return try self.mainContext.fetch(fr)
        } catch {
            print(error)
        }
        return []
    }
    
    
    /// Adiciona um novo documento no core data
    public func addNewDocument(with data: DocumentInfo) throws -> Document {
        let document = Document(context: self.mainContext)
        
        document.id = data.id
        document.title = data.title
        document.favorite = data.isFavorited
        
        self.saveContext()
        return document
    }
    
    
    /// Remove um dado no Core Data
    public func deleteDocument(at item: Document) throws {
        self.mainContext.delete(item)
        self.saveContext()
    }
}
