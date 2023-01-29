//
//  BaseService.swift
//  KornApps
//
//  Created by owner on 24/01/2023.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    func request<T: Codable>(_ route: EndPoint, expecting: T.Type, completion: @escaping (Result<T, Error>) -> ())
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request<T: Codable>(_ route: EndPoint,
                             expecting: T.Type,
                             completion: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession.shared
        do {
            
            let request = try self.buildRequest(from: route)
//            NetworkLogger.log(request: request)
            task = session.dataTask(with: request,
                                    completionHandler: { data, response, error in
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                guard let returnedData = data else {
                    completion(.failure(HTTPNetworkError.noData))
                    return
                }
                
                do {
                    let decodeData = try JSONDecoder().decode(expecting, from: returnedData)
                    completion(.success(decodeData))
                } catch {
                    completion(.failure(HTTPNetworkError.decodingFailed))
                }
            })
        } catch {
            completion(.failure(error))
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .requestParameters(let bodyParameters,let bodyEncoding,let urlParameters):
            
            do {
                switch bodyEncoding {
                case .jsonEncoding:
                    try bodyEncoding.encode(urlRequest: &request,
                                            bodyParameters: bodyParameters,
                                            urlParameters: urlParameters)
                case .urlEncoding:
                    try bodyEncoding.encode(urlRequest: &request,
                                            bodyParameters: bodyParameters,
                                            urlParameters: urlParameters)
                case .urlAndJsonEncoding:
                    break
                }
            } catch {
                throw error
            }
        case .requestParametersAndHeaders(_, _, _, _):
            break
        }
        return request
    }
}
