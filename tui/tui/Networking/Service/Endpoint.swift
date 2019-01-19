//
//  API.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

protocol Endpoint{
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var task: HttpTask { get }
    var headers: HttpHeaders? { get }
}
