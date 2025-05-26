//
//  NetworkManager.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/26/25.
//

import Foundation
import Alamofire

struct ApiResponse<T: Codable>: Codable {
    let success: Bool
    let data: T?
    let message: String?
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}

    private let baseURL = "https://peak-connect.vercel.app/api/"
    
    var companyUUID: String?

    private var commonHeaders: HTTPHeaders {
        var headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        if let uuid = companyUUID {
            headers.add(name: "X-Company-ID", value: uuid)
        }
        return headers
    }
    
    func request<T: Codable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = JSONEncoding.default,
        completion: @escaping (Result<T, AFError>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<T>.self) { response in
                switch response.result {
                case .success(let apiResponse):
                    if apiResponse.success, let data = apiResponse.data {
                        completion(.success(data))
                    } else {
                        let errorMsg = apiResponse.message ?? "Unknown API error"
                        print("API Error: \(errorMsg)")
                        completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

extension NetworkManager {
    
    struct UUIDResponse: Codable {
        let uuid: String
    }

    func registerCompany(
        name: String,
        industry: String,
        description: String,
        mode: CreateCompanyMode,
        completion: @escaping (Result<String, AFError>) -> Void
    ) {
        var endpoint = ""

        switch mode {
        case .create:
            endpoint = "company/new"
        case .edit(_):
            endpoint = "company/edit"
        }
        
        let parameters: Parameters = [
            "name": name,
            "industry": industry,
            "description": description
        ]

        request(endpoint: endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default) { (result: Result<UUIDResponse, AFError>) in
            switch result {
            case .success(let response):
                completion(.success(response.uuid))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
 
