//
//  CrashInformationInterface.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 12/03/22.
//

import Foundation

public protocol CrashInformationInterface: AnyObject {
    var date: Date? { set get }
    var stackTrace: String? { set get }
}
