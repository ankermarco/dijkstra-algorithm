//
//  Response.swift
//  tui
//
//  Created by Ke Ma on 18/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

enum NetworkResponse: Error {
    case authenticationError
    case badRequest
    case outdated
    case failed
    case noData
    case unableToDecode
}

public enum Response {
    case success(_: Data)
    case error(_ :Int?, _ :Error?)
    
    init(_ response: (r: HTTPURLResponse?, d: Data?, e: Error?)) {
        
        guard response.r?.statusCode == 200, response.e == nil else {
            self = .error(response.r?.statusCode, response.e)
            return
        }
        
        guard let data = response.d else {
            self = .error(response.r?.statusCode, NetworkResponse.noData)
            return
        }
        
        self = .success(data)
    }
}
