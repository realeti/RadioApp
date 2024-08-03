//
//  StorageManager.swift
//  RadioApp
//
//  Created by Natalia on 03.08.2024.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RadioApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private let viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    func fetchData(completion: (Result<[StationEntity], Error>) -> Void) {
        let fetchRequest: NSFetchRequest<StationEntity> = StationEntity.fetchRequest()
        do {
            let stations = try viewContext.fetch(fetchRequest)
            completion(.success(stations))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func deleteStation(_ station: StationEntity) {
        viewContext.delete(station)
        saveContext()
    }
    
    func saveStation(id: UUID, title: String, genre: String) {
        let station = StationEntity(context: viewContext)
        station.id = id
        station.title = title
        station.genre = genre
        
        saveContext()
    }
    
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
