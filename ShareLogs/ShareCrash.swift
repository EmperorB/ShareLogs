//
//  ShareCrash.swift
//  ShareLogs
//
//  Created by Rajesh Budhiraja on 12/03/22.
//

import Foundation

typealias ClosureType = ((Int32) -> Void)

@objcMembers
public final class ShareCrash: NSObject {

    public static let shared = ShareCrash()
    private var closuresArray: [ClosureType] = []
    private let signalType: [Int32] = [SIGABRT, SIGHUP, SIGINT, SIGQUIT, SIGILL, SIGTRAP, SIGEMT, SIGFPE, SIGKILL, SIGBUS, SIGSEGV, SIGSYS, SIGPIPE, SIGALRM, SIGTERM, SIGURG, SIGSTOP, SIGTSTP, SIGTTOU, SIGTTIN, SIGCHLD, SIGCONT, SIGIO, SIGXCPU, SIGXFSZ, SIGVTALRM, SIGPROF, SIGWINCH, SIGINFO, SIGUSR1, SIGUSR2]
    
    private let coreDataManager: CoreDataManagerInterface = CoreDataManager()

    public func fetchCrashes() -> [CrashInformationInterface] {
        coreDataManager.fetchAllCrashes()
    }
    
    public func addNewCrash(_ crash: CrashInformationInterface) {
        coreDataManager.addNewCrash(crash)
    }
        
    private override init() {
        super.init()
        for each in signalType {
            if let signalCapture = signal(each, { s in
                let crash = Crash(.init(), Thread.callStackSymbols.joined(separator: "\n"))
                ShareCrash.shared.addNewCrash(crash)
                exit(s)
            }) {
                self.closuresArray.append(signalCapture)
            }
        }
    }
}

final class Crash: CrashInformationInterface {
    var date: Date?
    var stackTrace: String?
    
    init(_ date: Date, _ stackTrace: String) {
        self.date = date
        self.stackTrace = stackTrace
    }
    
    init() {
        
    }
    
    static func map(_ crash: CrashInformation) -> CrashInformationInterface {
        let temp = Crash()
        temp.date = crash.date
        temp.stackTrace = crash.stackTrace
        return temp
    }
}
