//
//  HTTPMethod.swift
//  KornApps
//
//  Created by owner on 23/01/2023.
//

import Foundation

public typealias HTTPParameters = [String: Any]?

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}
