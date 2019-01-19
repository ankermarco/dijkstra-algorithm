//
//  Worker.swift
//  tui
//
//  Created by Ke Ma on 18/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

protocol Worker {
    var endpoint: Endpoint { get }
    
    func exec(dispatcher: Dispatcher, completion: @escaping (Response) -> ())
}

class FlightConnectionsWorker: Worker {
    
    var endpoint: Endpoint {
        return FlightConnectionsEndpoint.all
    }
    
    func exec(dispatcher: Dispatcher, completion: @escaping (Response) -> ()) {
        do {
            try dispatcher.exec(endpoint, completion: { (response) in
                completion(response)
                //completion(response)
            })
        } catch(let error) {
            print(error)
        }
    }
}



