import Foundation
import AsyncHTTPClient
import NIOHTTP1
import Logging
import NIOCore

extension RequestManager {
    enum Method {
        case GET
        case POST
        
        var method : HTTPMethod {
            switch (self) {
            case .GET: return HTTPMethod.GET
            case .POST: return HTTPMethod.POST
            }
        }
        
    }
}

extension RequestManager {
    enum RequestResult {
        case success(Data)
        case failure
    }
}

class RequestManager {
    
    private let httpClient = HTTPClient(eventLoopGroupProvider: .createNew)
    
    private let requestLog = Logger(label: "com.MusicBox.Request")
    
    static let shared = RequestManager()
    
    func request(url: String,
                 method: Method,
                 headers: [String: CustomStringConvertible]? = nil,
                 timeout: Int64 = 15,
                 handler: @escaping (RequestResult) -> Void) {
        do {
            var request = try HTTPClient.Request(
                url: url,
                method: method.method,
                headers: HTTPHeaders(),
                body: nil)
            if let headers = headers {
                headers.forEach { (key: String, value: CustomStringConvertible) in
                    request.headers.add(name: key, value: value.description)
                }
            }
            
            self.httpClient.execute(request: request,
                                    deadline: (NIODeadline.now() + .seconds(timeout)),
                                    logger: self.requestLog)
            .whenComplete { [weak self] result in
                switch(result) {
                case .failure(let error):
                    self?.requestLog.error("Request Result Error: \(error)")
                    handler(.failure)
                case .success(let response):
                    if (response.status == .ok) {
                        if var body = response.body,
                           let data = body.readData(length: body.readableBytes) {
                            handler(.success(data))
                        } else {
                            handler(.failure)
                            self?.requestLog.error("Request N Error: \(response.status)")
                        }
                    } else {
                        handler(.failure)
                        self?.requestLog.error("Request Response Error: \(response.status)")
                    }
                }
            }
        } catch {
            self.requestLog.error("Create Request Error: \(error)")
        }
    }
}
