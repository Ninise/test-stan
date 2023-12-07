//
//  StanApiGenerics.swift
//  TestStan
//
//  Created by Nikita on 06.12.2023.
//

import Foundation
import Moya

// MARK: - Response handling support


extension StanApi {
    
    static func objectData<T: Codable>(of result: Result<Moya.Response, MoyaError>) -> Result<T, SError> {
        switch result {
        case .success(let data):
            do {
                let successData = try data.filterSuccessfulStatusCodes()
                let response = try successData.map(T.self)
                
                return .success(response)
            } catch {
                let err = error as! MoyaError
                
                return .failure(SError(reason: err.localizedDescription))
            }
        case .failure(let error):
            return .failure(SError(reason: error.localizedDescription))
        }
    }
    
}
