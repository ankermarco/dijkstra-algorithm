//
//  MockedEndpoint.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

struct MockedEndpoint: Endpoint {
    var path: String {
        return MOCKED_PATH
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
