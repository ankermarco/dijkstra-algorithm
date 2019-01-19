//
//  NetworkDispatcher.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

public struct Environment {
    public var name: String
    public var baseUrl: String
    public var baseURL: URL {
        guard let url = URL(string: baseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public init(_ name: String, baseUrl: String) {
        self.name = name
        self.baseUrl = baseUrl
    }
}

typealias NetworkResponseCompletion = (Response) -> Void

protocol Dispatcher {
    init(environment: Environment, session: URLSessionProtocol)
    func exec(_ endpoint: Endpoint, completion: @escaping NetworkResponseCompletion) throws
}

class NetworkDispatcher: Dispatcher {
    
    private let session: URLSessionProtocol
    private let environment: Environment
    
    required init(environment: Environment, session: URLSessionProtocol) {
        self.environment = environment
        self.session = session
    }
    
    func exec(_ endpoint: Endpoint, completion: @escaping NetworkResponseCompletion) throws {
      
        let apiRequest = try self.buildRequest(from: endpoint)
        let task = session.dataTask(with: apiRequest, completionHandler: { data, response, error in
            let response = Response((r: response as? HTTPURLResponse, d: data, e: error))
            completion(response)
        })

        task.resume()
    }
    
    fileprivate func buildRequest(from endpoint: Endpoint) throws -> URLRequest {
        
        var apiRequest = URLRequest(url: environment.baseURL.appendingPathComponent(endpoint.path),
                                    cachePolicy: environment.cachePolicy,
                                    timeoutInterval: 10.0)
        
        apiRequest.httpMethod = endpoint.httpMethod.rawValue
        
        do {
            switch endpoint.task {
            case .request:
                apiRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &apiRequest)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &apiRequest)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &apiRequest)
            }
            return apiRequest
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HttpHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}
