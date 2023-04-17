//
//  API.swift
//  OpenLibraryTest
//
//  Created by Александр Янчик on 14.04.23.
//

import Foundation
import Moya

enum OpenLibraryAPI {
    case searchBooks
    case getBookDescription(key: String)
}

extension OpenLibraryAPI: TargetType {
    var baseURL: URL {
        switch self {
            case .searchBooks:
                return URL(string: "https://openlibrary.org/search.json")!
            case .getBookDescription(let key):
                return URL(string: "https://openlibrary.org\(key).json")!
        }
        
    }
    
    var path: String {
        switch self {
            case .searchBooks:
                return ""
            case .getBookDescription:
                return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .searchBooks:
                return .get
            case .getBookDescription:
                return .get
        }
    }
    
    var task: Moya.Task {
        guard let parameters else { return .requestPlain}
        
        return .requestParameters(parameters: parameters, encoding: encoding)
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String: Any]? {
        var params = [String: Any]()
        
        switch self {
            case .searchBooks:
                params["q"] = "John Ronald Reuel Tolkien"
            case .getBookDescription:
                return nil
        }
        
        return params
    }
    
    var encoding: ParameterEncoding {
        switch self {
            case .searchBooks:
                return URLEncoding.queryString
            case .getBookDescription:
                return URLEncoding.queryString
        }
    }
    
}

