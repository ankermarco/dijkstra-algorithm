//
//  Connection.swift
//  tui
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation


struct Connection: Codable {
    let from: String
    let to: String
    let price: Float
}

extension Connection {
    
    enum CodingKeys: String, CodingKey {
        case from
        case to
        case price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decode(String.self, forKey: .from)
        to = try container.decode(String.self, forKey: .to)
        price = try container.decode(Float.self, forKey: .price)
 
    }
}
