//
//  Services.swift
//  GrandTask
//
//  Created by Tawfik Sweedy✌️ on 10/17/23.
//

import Foundation
import Moya


enum Services {
    case matches(matchday : Int)
}

extension Services : URLRequestBuilder {
    var path: String {
        switch self {
        case .matches:
            return SharedEndPoints.matches.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .matches   :
            return .get
        }
    }
    
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .matches(let matchday) :
            return .requestParameters(parameters: ["matchday" : matchday], encoding: URLEncoding.queryString)
      }
    }
}

