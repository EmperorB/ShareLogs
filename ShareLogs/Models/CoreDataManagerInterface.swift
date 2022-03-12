//
//  CoreDataManagerInterface.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 12/03/22.
//

import Foundation

protocol CoreDataManagerInterface: AnyObject {
    func fetchAllCrashes() -> [CrashInformationInterface]
    func addNewCrash(_ crash: CrashInformationInterface)
}
