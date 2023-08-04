//
//  StorageManager.swift
//  MiniCV
//
//  Created by Руслан Шигапов on 04.08.2023.
//

import CoreData

final class StorageManager {
    
    static let shared = StorageManager()

    // MARK: - Core Data stack
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MiniCV")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    private init() {}
    
    // MARK: - CRUD
    func create(by name: String) {
        let skill = Skill(context: viewContext)
        skill.name = name
        saveContext()
    }
    
    func fetchSkills(completion: (Result<[Skill], Error>) -> Void) {
        let fetchRequest = Skill.fetchRequest()
        do {
            let skills = try viewContext.fetch(fetchRequest)
            completion(.success(skills))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func delete(_ skill: Skill) {
        viewContext.delete(skill)
        saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}

