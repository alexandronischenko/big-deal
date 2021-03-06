//
//  Log.swift
//  BigDeal
//
//  Created by Alexandr Onischenko on 31.05.2022.
//

import Foundation

enum Logger {
    enum LogLevel {
        case info
        case warning
        case error
        
        var prefix: String {
            switch self {
            case .info:
                return "INFO"
            case .warning:
                return "WARNING ⚠️"
            case .error:
                return "ERROR 🛑"
            }
        }
    }
    
    static func log(
        level: LogLevel = .info,
        str: String,
        shouldLogContext: Bool = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let logComponents = [Date().description, "[\(level.prefix)]", str]
        
        var description: String {
            return "\((file as NSString).lastPathComponent):\(line) \(function)"
        }
        
        var fullString = logComponents.joined(separator: " ")
        if shouldLogContext {
            fullString += "-> \(description)"
        }
        
        #if DEBUG
        print(fullString)
        #endif
    }
}
