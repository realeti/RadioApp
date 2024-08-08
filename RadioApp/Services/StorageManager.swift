//
//  StorageManager.swift
//  RadioApp
//
//  Created by Natalia on 03.08.2024.
//

import CoreData
import UIKit

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
    
    func fetchUser(id: String, completion: (Result<UserEntity, Error>) -> Void) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let user = result.first(where: { $0.id == id }) {
                completion(.success(user))
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
    func saveUser(_ user: User) {
        let userEnttity = UserEntity(context: viewContext)
        userEnttity.id = user.id
        userEnttity.imageData = user.image
        userEnttity.email = user.email
        userEnttity.login = user.login
        saveContext()
    }
    
    func toggleFavorite(id: UUID, title: String, genre: String) {
        if let station = fetchStation(with: id) {
            deleteStation(station)
        } else {
            saveStation(id: id, title: title, genre: genre)
        }
    }
    
    func deleteStation(_ station: StationEntity) {
        viewContext.delete(station)
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
    
    func fetchStation(with id: UUID) -> StationEntity? {
        let fetchRequest: NSFetchRequest<StationEntity> = StationEntity.fetchRequest()
        let stations = try? viewContext.fetch(fetchRequest)
        let station = stations?.first(where: { $0.id == id })
        return station
    }
    
    private func saveStation(id: UUID, title: String, genre: String) {
        let station = StationEntity(context: viewContext)
        station.id = id
        station.title = title
        station.genre = genre
        
        saveContext()
    }
}
