//
//  ViewControllerModel.swift
//  tui
//
//  Created by Ke Ma on 18/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation

class ViewControllerViewModel {
    
    var environment: Environment
    var worker: FlightConnectionsWorker
    var dispatcher: NetworkDispatcher
    
    typealias ConnectionsCompletion = (_ data: [Connection]) -> Void
    
    init(environmentName: String, url: String, session: URLSessionProtocol = URLSession.shared) {
        self.worker = FlightConnectionsWorker()
        self.environment = Environment(environmentName, baseUrl: url)
        self.dispatcher = NetworkDispatcher(environment: self.environment, session: session)
    }
    
    func fetchFlightConnections(completion: @escaping ConnectionsCompletion) {
        self.worker.exec(dispatcher: self.dispatcher, completion: { (result) in
        
            switch result {
            case Response.success(let data):
                self.cacheFlightConnections(data: data, completion: completion)
            default:
                print("error")
            }
            
        })
    }
    
    private func cacheFlightConnections(data: Data, completion: ConnectionsCompletion) {
        do{
            let json = try JSONDecoder().decode(ConnectionData.self, from: data)
            completion(json.connections)
        } catch (let error){
            print(error)
        }
    }
}
