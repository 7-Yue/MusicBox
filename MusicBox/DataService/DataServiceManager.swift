import Foundation

class DataServiceManager {
    /// `Singleton`
    static let shared = DataServiceManager()
    
}

// MARK: - Remote Part
extension DataServiceManager {
    
    func searchRelatedMusics(page: Int,
                             limit: Int,
                             keyword: String,
                             channel: MusicChannel) {
        if (channel == .KuWo) {
            LXAPI.KW.searchRelatedMusics(page: page, limit: limit, keyword: keyword)
        } else {
            Log.warning(msg: "ζδΈζ―ζ")
        }
    }
}

// MARK: - Local Part
extension DataServiceManager {
    
}
