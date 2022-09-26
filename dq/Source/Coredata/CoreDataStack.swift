//
//  CoreDataStack.swift
//  dq
//
//  Created by Kyu jin Lee on 2022/09/15.
//

import CoreData

class CoreDataStack: ObservableObject {
    private let persistentContainer: NSPersistentContainer
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = {
            let container = NSPersistentContainer(name: modelName)
            container.loadPersistentStores { description, error in
                if let err = error {
                    print(err)
                }
            }
            return container
        }()
    }
    
    func save() {
        guard managedObjectContext.hasChanges else {
            return
        }
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func appendInterestedList(element: String, date: String, id: String, flag: Int) {
        let interestedList = InterestedList(context: managedObjectContext)
        interestedList.elementName = element
        interestedList.expireDate = date
        interestedList.elementID = id
        interestedList.flag = Int64(flag)
    }
}
