//
//  FlightConnectionsEndpoint.swift
//  tui
//
//  Created by Ke Ma on 18/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

public enum FlightConnectionsEndpoint {
    case all
}

extension FlightConnectionsEndpoint: Endpoint {
    var path: String {
        switch self {
        case .all:
            return "connections.json"
        }
    }
    
    var httpMethod: HttpMethod {
        return .get
    }
    
    var task: HttpTask {
        return .request
    }
    
    var headers: HttpHeaders? {
        return nil
    }
    
}
