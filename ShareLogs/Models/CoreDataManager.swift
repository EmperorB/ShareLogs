//
//  CoreDataManager.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 12/03/22.
//

import Foundation
import CoreData

final class CoreDataManager: CoreDataManagerInterface {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let identifier = "com.budhirajaRajesh.ShareCrashes"
        let bundle = Bundle(identifier: identifier)
        let modelURL = bundle!.url(forResource: "CrashTrace", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
       let container = NSPersistentContainer(name: "CrashTrace", managedObjectModel: managedObjectModel)
        print(container.persistentStoreDescriptions)
        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func fetchAllCrashes() -> [CrashInformationInterface] {
        let request: NSFetchRequest<CrashInformation> = CrashInformation.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        let crashes: [CrashInformation]? = try? persistentContainer.viewContext.fetch(request)
        let crashesArray = crashes ?? []
        var array: [CrashInformationInterface] = []
        for each in crashesArray {
            array.append(Crash.map(each))
        }
        return array
    }
    
    func addNewCrash(_ crash: CrashInformationInterface) {
        let newCrash = CrashInformation(context: persistentContainer.viewContext)
        newCrash.date = crash.date
        newCrash.stackTrace = crash.stackTrace
        saveContext()
    }
    
}
