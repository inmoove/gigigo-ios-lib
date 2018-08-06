//
//  Log.swift
//  OrchextraApp
//
//  Created by Alejandro Jiménez Agudo on 19/10/15.
//  Copyright © 2015 Gigigo. All rights reserved.
//

import Foundation


public enum LogLevel: Int {
    /// No log will be shown.
    case none = 0
    
    /// Only warnings and errors.
    case error = 1
    
    /// Errors and relevant information.
    case info = 2
    
    /// Request and Responses will be displayed.
    case debug = 3
}

public enum LogStyle: Int {
    
    /// Profesional style no emojis
    case  none = 0
    
    /// Funny style with emojis
    case funny = 1
}


public func >=(levelA: LogLevel, levelB: LogLevel) -> Bool {
    return levelA.rawValue >= levelB.rawValue
}

public var logManagers = [String: LogManager]()

extension LogManager: Hashable {
    public var hashValue: Int {
        return bundle.hash
    }
    
    public static func == (lhs: LogManager, rhs: LogManager) -> Bool {
        return lhs.bundle == rhs.bundle
    }
}

open class LogManager {
    
    open static let shared = LogManager()
    public var bundle = Bundle.main
    
    public init() {
        self.bundle = Bundle.current
        let filename: NSString = #file
        guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
        logManagers[className] = self
    }
    
    public init(bundle: Bundle, filename: NSString = #file) {
        guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
        self.bundle = bundle
        logManagers[className] = self
    }
    
    open var appName: String?
    open var logLevel: LogLevel = .none
    open var logStyle: LogStyle = .none
    
    static func managerFor(className: String) -> LogManager {
        return logManagers[className] ?? LogManager.shared
    }
    
    public func setLogLevel(_ logLevel: LogLevel, filename: NSString = #file) {
        guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
        let logManager = logManagers[className] ?? LogManager.shared
        logManager.logLevel = logLevel
    }
    
    public func setLogStyle(_ logStyle: LogStyle, filename: NSString = #file) {
        guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
        let logManager = logManagers[className] ?? LogManager.shared
        logManager.logStyle = logStyle
    }
}

public func Log(_ log: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
    let manager = LogManager.managerFor(className: className)
    
    guard manager.logLevel != .none else { return }
    let appName = manager.appName ?? "Gigigo Log Manager"
    
    print("\(appName)::" + log)
}

public func LogInfo(_ log: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
    
    let manager = LogManager.managerFor(className: className)
    
    let emoji = (manager.logStyle == .funny) ? " ⓘ" : ""
    let caller = " [Info\(emoji)] \(className)(\(line)) - \(funcname): "
    guard manager.logLevel >= .info else { return }
    Log(caller + log)
}

public func LogDebug(_ log: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
    
    let manager = LogManager.managerFor(className: className)
    
    let emoji = (manager.logStyle == .funny) ? " 🐛" : ""
    let caller = " [Debug\(emoji)] \(className)(\(line)) - \(funcname): "
    guard manager.logLevel >= .debug else { return }
    Log(caller + log)
}

public func LogWarn(_ message: String, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
    let manager = LogManager.managerFor(className: className)
    
    guard manager.logLevel >= .error else { return }
    let emoji = (manager.logStyle == .funny) ? " 🔥" : ""
    let caller = " [Error\(emoji)] \(className)(\(line)) - \(funcname): "
    Log(caller + message)
}

public func LogError(_ error: NSError?, filename: NSString = #file, line: Int = #line, funcname: String = #function) {
    guard let className = filename.lastPathComponent.components(separatedBy: ".").first else { return }
    let manager = LogManager.managerFor(className: className)
    
    guard
        manager.logLevel >= .error,
        let err = error
        else { return }
    let emoji = (manager.logStyle == .funny) ? " 🔥" : ""
    let caller = " [Error\(emoji)] \(className)(\(line)) - \(funcname): \(err.localizedDescription)"
    Log(caller)
}
