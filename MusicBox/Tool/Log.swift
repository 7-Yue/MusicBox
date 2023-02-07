import Foundation
import Logging

class Log {
    private static let logger = Logger(label: "com.MusicBox.main")
    
    static func info(msg: String) {
        Log.logger.info("\(msg)")
    }
    
    static func debug(msg: String) {
        Log.logger.debug("\(msg)")
    }
    
    static func warning(msg: String) {
        Log.logger.warning("\(msg)")
    }
    
    static func error(msg: String) {
        Log.logger.error("\(msg)")
    }
    
}

