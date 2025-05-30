//
//  NetworkManager.swift
//  PeakConnect
//
//  Created by 서문가은 on 5/26/25.
//

import Foundation
import Alamofire

struct HistoryListInfo: Codable {
    let address: String
    let leads: [Lead]
    
    struct Lead: Codable {
        let id: Int
        let name: String
        let address: String
        let industry: String
        let latitude: Double
        let longitude: Double
    }
}

struct LeadInfo: Codable {
    let name: String
    let summary: String
    let address: String
    let website: String
    let match_reason: String
    let year_founded: Int
    let ceo_name: String
    let industry: String
}


struct ApiResponse<T: Codable>: Codable {
    let success: Bool
    let data: T?
    let message: String?
}

struct Lead: Codable {
    let id: Int
    let name: String
    let address: String
    let industry: String
    let latitude: Double
    let longitude: Double
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

    struct CompanyInfo: Codable {
        let uuid: String?
        let name: String
        let description: String
    }
    
    struct HistoryInfo: Codable {
        let id: Int
        let created_at: String
        let location: String
        let leads: String
        let count: Int
    }
    


    func registerCompany(
        name: String,
        description: String,
        mode: CreateCompanyMode,
        completion: @escaping (Result<String?, AFError>) -> Void
    ) {
        var endpoint = ""
        var expectsUUID = false

        switch mode {
        case .create:
            endpoint = "company/new"
            expectsUUID = true
        case .edit:
            endpoint = "company/edit"
            expectsUUID = false
        }

        let parameters: Parameters = [
            "name": name,
            "description": description
        ]

        if expectsUUID {
            // 등록: uuid 기대
            request(endpoint: endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default) { (result: Result<UUIDResponse, AFError>) in
                switch result {
                case .success(let response):
                    completion(.success(response.uuid))
                    print("회사 등록 성공")
                case .failure(let error):
                    completion(.failure(error))
                    print("회사 등록 실패")
                    print(error)
                }
            }
        } else {
            // 수정: 응답 없음 또는 바디 없는 성공 처리
            guard let url = URL(string: baseURL + endpoint) else {
                print("Invalid URL")
                return
            }
            AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: commonHeaders)
                .validate(statusCode: 200..<300)
                .response { response in
                    switch response.result {
                    case .success:
                        completion(.success(nil))
                        print("회사 수정 성공")
                    case .failure(let error):
                        completion(.failure(error))
                        print("회사 수정 실패")
                        print(error)
                    }
                }
        }
    }
    
    func requestCompany(completion: @escaping (Result<CompanyInfo, AFError>) -> Void) {
        
        companyUUID = UserDefaults.standard.uuid
        
        let endpoint = "company/info"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseString(encoding: .utf8) { response in
                print("Raw response: \(response.value ?? "nil")")
            }
            .responseDecodable(of: ApiResponse<CompanyInfo>.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let apiResponse):
                    if apiResponse.success, let company = apiResponse.data {
                        completion(.success(company))
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
    
    func requestHistList(completion: @escaping (Result<[HistoryInfo], AFError>) -> Void) {
        
        companyUUID = UserDefaults.standard.uuid
        
        let endpoint = "lead/recommendation/list"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseString(encoding: .utf8) { response in
                print("Raw response: \(response.value ?? "nil")")
            }
            .responseDecodable(of: ApiResponse<[HistoryInfo]>.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let apiResponse):
                    if apiResponse.success, let history = apiResponse.data {
                        completion(.success(history))
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
    
    func requestHistLists(id: Int, completion: @escaping (Result<HistoryListInfo, AFError>) -> Void) {
        
        companyUUID = UserDefaults.standard.uuid
    
        let endpoint = "lead/recommendation/\(id)/list"
        print("📡 requestHistLists 호출 - id: \(id), endpoint: \(endpoint)")
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseString(encoding: .utf8) { response in
                print("Raw response: \(response.value ?? "nil")")
            }
            .responseDecodable(of: ApiResponse<HistoryListInfo>.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let apiResponse):
                    if apiResponse.success, let historyList = apiResponse.data {
                        completion(.success(historyList))
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
    
    func requestLead(id: Int, completion: @escaping (Result<LeadInfo, AFError>) -> Void) {
        
        companyUUID = UserDefaults.standard.uuid
    
        let endpoint = "lead/\(id)/info"
        guard let url = URL(string: baseURL + endpoint) else {
            print("Invalid URL")
            return
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseString(encoding: .utf8) { response in
                print("Raw response: \(response.value ?? "nil")")
            }
            .responseDecodable(of: ApiResponse<LeadInfo>.self, decoder: JSONDecoder()) { response in
                switch response.result {
                case .success(let apiResponse):
                    if apiResponse.success, let leadInfo = apiResponse.data {
                        completion(.success(leadInfo))
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

    struct LeadRecommendationResponse: Codable {
        let recommendation_id: Int
        let leads: [Lead]
    }

    func requestLeadRecommendation(latitude: Double, longitude: Double, location: String, completion: @escaping (Result<LeadRecommendationResponse, AFError>) -> Void) {
        let endpoint = "lead/recommendation/sample-new"
        let parameters: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "location": location
        ]

        AF.request(baseURL + endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: commonHeaders)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ApiResponse<LeadRecommendationResponse>.self) { response in
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
 
