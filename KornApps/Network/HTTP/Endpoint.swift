//
//  HTTPNetworkRoute.swift
//  KornApps
//
//  Created by owner on 23/01/2023.
//

import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum RMCharacterEndpoint {
    case characters(params: String?)
}

extension RMCharacterEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return "https://rickandmortyapi.com/api"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/character"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .characters(let params):
            
            if let params = params {
                
                var paramDictionary: [String: String] = [:]
                _ = params.components(separatedBy: "&").compactMap({
                    let paramParts = $0.components(separatedBy: "=")
                    
                    paramDictionary[paramParts[0]] = paramParts[1]
                })
                
                return .requestParameters(bodyParameters: nil,
                                          bodyEncoding: .urlEncoding,
                                          urlParameters: paramDictionary)
            } else {
                return .request
            }
        }
    }
    
    var headers: HTTPHeaders? {
        return ["Content-Type": "application/json"]
    }
}
