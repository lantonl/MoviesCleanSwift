//
//  NetworkingServiceBase.swift.swift
//  MoviesCleanSwift
//
//  Created by Anton Gutkin on 16.01.2022.
//

import Foundation

typealias APICallback = (Result<Data?, Error>) -> Void

protocol BaseNetworkingService {
    var baseUrl: URL! { get }
    var sessionManager: URLSessionProtocol { get }
    
    init(baseUrlString: String, sessionManager: URLSessionProtocol)
    
    func get(path: String, params: [String: String]?, headerParams: [String: String]?, result: @escaping APICallback)
}

extension BaseNetworkingService {
    func get(path: String, params: [String: String]?, headerParams: [String: String]? = nil, result: @escaping APICallback) {
        let urlRequest = self.createGetRequest(path: path, params: params, headerParams: headerParams)
        self.dataTask(with: urlRequest, result: result).resume()
    }
    
    private func createGetRequest(path: String, params: [String: String]?, headerParams: [String: String]?) -> URLRequest {
        let urlComponents = self.urlComponents(with: path)
        urlComponents.queryItems = params?.map { (key, value) -> URLQueryItem in URLQueryItem(name: key, value: value) }
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        headerParams?.forEach { header in urlRequest.setValue(header.value, forHTTPHeaderField: header.key) }
        
        return urlRequest
    }
    
    private func urlComponents(with path: String) -> NSURLComponents {
        let urlComponents = NSURLComponents()
        urlComponents.scheme = baseUrl.scheme
        urlComponents.host = baseUrl.host
        urlComponents.path = baseUrl.path + path
        
        return urlComponents
    }
    
    private func dataTask(with urlRequest: URLRequest, result: @escaping APICallback) -> URLSessionDataTask {
        return sessionManager.dataTask(with: urlRequest) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            guard error == nil else {
                result(.failure(NetworkResponseError.noInternerConnection))
                return
            }
            
            if let httpUrlResponse = urlResponse as? HTTPURLResponse {
                switch HTTPURLResponseHandler.handle(response: httpUrlResponse) {
                case .success:
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        }
    }
}
