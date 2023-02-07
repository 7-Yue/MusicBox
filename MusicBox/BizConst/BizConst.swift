import Foundation

enum MusicChannel {
    case KuWo
    case QQ
    case SouGou
    case WangYiYun
    case MiGu
    
    var name: String {
        switch (self) {
            case .KuWo:         return "酷我"
            case .QQ:           return "QQ"
            case .SouGou:       return "搜狗"
            case .WangYiYun:    return "网易云"
            case .MiGu:         return "咪咕"
        }
    }
    
    var tag: String {
        switch (self) {
            case .KuWo:         return "kw"
            case .QQ:           return "qq"
            case .SouGou:       return "sg"
            case .WangYiYun:    return "wy"
            case .MiGu:         return "mg"
        }
    }
}
