//
//  StanApi.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation

import Moya
import Alamofire
import UIKit

class StanApi {
    
    private static func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data
        }
    }
    
    static let provider = MoyaProvider<ApiService>(requestClosure: MoyaProvider<ApiService>.requestClosure(), plugins: [
        NetworkLoggerPlugin(configuration: .init(logOptions: .verbose)),
    ])
    
}

enum ApiService {
    case removeTransaction(_ id: Int64)
    case createTransaction(request: NewTransaction)
    case getTransactions
}

extension ApiService: TargetType {
    
    // will be env url depends on prod/dev server
    var baseURL: URL {
        return URL(string: "https://x8ki-letl-twmt.n7.xano.io/api:O8qF4MsJ/")!
    }
    
    var path: String {
        switch self {
        case .removeTransaction(let id):
            return "transactions/\(id)"
        case .createTransaction:
            return "transactions"
        case .getTransactions:
            return "transactions"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createTransaction: return .post
        case .removeTransaction: return .delete
        case .getTransactions: return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .createTransaction(let request):
            return .requestJSONEncodable(request)
            
        default:
            return .requestPlain
        }
    }
    
    // usually I put token here
    var headers: [String: String]? {
        return ["token":""]
    }
}

extension MoyaProvider {
    static var provider: MoyaProvider<ApiService> {
        return MoyaProvider<ApiService>()
    }
    
    static func requestClosure() -> MoyaProvider<Target>.RequestClosure {
        return { endpoint, closure in
            let request = try! endpoint.urlRequest()
            closure(.success(request))
            
        }
    }
}
