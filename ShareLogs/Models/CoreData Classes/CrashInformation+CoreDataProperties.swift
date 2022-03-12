//
//  CrashInformation+CoreDataProperties.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 12/03/22.
//
//

import Foundation
import CoreData


extension CrashInformation: CrashInformationInterface {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrashInformation> {
        return NSFetchRequest<CrashInformation>(entityName: "CrashTrace")
    }

    @NSManaged public var date: Date?
    @NSManaged public var stackTrace: String?

}

extension CrashInformation : Identifiable {

}
