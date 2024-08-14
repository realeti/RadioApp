//
//  StorageManager.swift
//  RadioApp
//
//  Created by Natalia on 03.08.2024.
//

import CoreData
import FirebaseAuth
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
    
    func fetchUser(id: String) -> UserEntity? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let result = try viewContext.fetch(fetchRequest)
            let user = result.first(where: { $0.id == id })
            return user
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func saveUser(_ user: UserApp) {
        var userEnttity: UserEntity
        if let entity = fetchUser(id: user.id) {
            userEnttity = entity
        } else {
            userEnttity = UserEntity(context: viewContext)
        }
        userEnttity.id = user.id
        userEnttity.imageData = user.image
        userEnttity.email = user.email
        userEnttity.login = user.login
        saveContext()
    }
    
    func toggleFavorite(id: UUID, title: String, genre: String, url: String, favicon: String) {
        if let station = fetchStation(with: id) {
            deleteStation(station)
        } else {
            saveStation(id: id, title: title, genre: genre, url: url, favicon: favicon)
        }
    }
    
    func deleteStation(_ station: StationEntity) {
        setNotification(station.id)
        
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
    
    func getUserImage() -> UIImage {
        var userImage: UIImage
        if
            let id = Auth.auth().currentUser?.uid,
            let userEntity = StorageManager.shared.fetchUser(id: id),
            let imageData = userEntity.imageData,
            let image = UIImage(data: imageData)
        {
            userImage = image
        } else {
            userImage = .person
        }
        
        return userImage
    }
    
    private func saveStation(id: UUID, title: String, genre: String, url: String, favicon: String) {
        let station = StationEntity(context: viewContext)
        station.id = id
        station.title = title
        station.genre = genre
        station.url = url
        station.favicon = favicon
        
        saveContext()
    }
}

// MARK: - Notification
private extension StorageManager {
    func setNotification(_ stationId: UUID?) {
        guard let stationId else { return }
        
        NotificationCenter.default.post(
            name: .favoriteRemoved,
            object: nil,
            userInfo: [K.UserInfoKey.removedStationIndex: stationId]
        )
    }
}
