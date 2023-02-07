import Foundation

extension LXAPI.KW {
    static func searchRelatedMusics(page: Int,
                                    limit: Int,
                                    keyword: String) {
        Log.info(msg: "酷我-音乐歌曲基于关键字搜索")
        
        let host = "http://search.kuwo.cn"
        let path = "/r.s"
        let params: [String: CustomStringConvertible] = [
            "client": "kt",
            "uid": "794762570",
            "ver": "kwplayer_ar_9.2.2.1",
            "vipver": "1",
            "show_copyright_off": "1",
            "newver": "1",
            "ft": "music",
            "cluster": "0",
            "strategy": "2012",
            "encoding": "utf8",
            "rformat": "json",
            "vermerge": "1",
            "mobi": "1",
            "issubtitle": "1",
            "pn": page,
            "rn": limit,
            "all": keyword,
        ]
        
        let urlStr = { () -> String in
            var urlComponents = URLComponents(string: host)!
            urlComponents.path = path
            urlComponents.queryItems = [URLQueryItem]()
            params.forEach { (key: String, value: CustomStringConvertible) in
                let item = URLQueryItem(name: key, value: value.description)
                urlComponents.queryItems?.append(item)
            }
            return urlComponents.string!
        }()
        RequestManager.shared.request(url: urlStr,
                                      method: .GET,
                                      handler: { result in
            DispatchQueue.main.async {
                switch (result) {
                case.success(let data):
                    print(String(data: data, encoding: .utf8) ?? "")
                case.failure:
                    Log.debug(msg: "失败")
                }
            }
        })
    }
}
