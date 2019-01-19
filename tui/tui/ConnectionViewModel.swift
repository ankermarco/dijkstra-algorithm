//
//  ConnectionModel.swift
//  tui
//
//  Created by Ke Ma on 19/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation


class ConnectionViewModel {
    
    let worker: ConnectionWorker!
    
    init(connections : [Connection]) {
        worker = ConnectionWorker(connections: connections)
    }
    
    func calculateCheapestFlight(from departure: String, to: String) -> ( [String], Float) {
        
        return worker?.cost(from: departure, to: to) ?? ([], Float(0))
    }
}
