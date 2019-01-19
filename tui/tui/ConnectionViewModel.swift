//
//  ConnectionModel.swift
//  tui
//
//  Created by Ke Ma on 19/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import Foundation
import GameplayKit

class ConnectionViewModel {
    
    var connections: [Connection]
    let cityGraph = GKGraph()
    var cityNodeTracker: [String: City] = [:]
    var cityNodes: [City] = []
    
    init(connections : [Connection]) {
        self.connections = connections
        
        addAllCities()
    }
    
    private func addAllCities() {
        var citiesWithDuplicates = [String]()
        var cities = [String]()
        
        // Get all unique city names
        for connection in connections {
            citiesWithDuplicates.append(connection.from)
            citiesWithDuplicates.append(connection.to)
            cities = citiesWithDuplicates.orderedSet
        }
        
        // Create Graph Node
        for city in cities {
            let node = City(name: city)
            cityNodeTracker[city] = node
            cityNodes.append(node)
        }
        cityGraph.add(cityNodes)
        
        for node in cityNodes {
            //Swift.print(node)
            addNodeConnections(for: node)
        }
        
    }
    
    // Add Graph Node Connection
    private func addNodeConnections(for node: City) {
        for connection in connections {
            if node.name == connection.from {
                // find the node from cityNodes
                if let city = findCityByName(name: connection.to) {
                    node.addConnection(to: city, bidirectional: false, weight: connection.price)
                }
            }
        }
    }
    
    private func findCityByName(name: String) -> City? {
        return cityNodes.filter{ $0.name == name }.first
    }
    
    func print(_ path: [GKGraphNode]) -> [String] {
        return path.compactMap({ $0 as? City}).compactMap { $0.name }
    }
    
    func cost(for path: [GKGraphNode]) -> Float {
        var total: Float = 0
        for i in 0..<(path.count-1) {
            total += path[i].cost(to: path[i+1])
        }
        return total
    }
    
    func calculateCheapestFlight(from departure: String, to: String) -> ( [String], Float) {
        
        if let from = cityNodeTracker[departure], let to = cityNodeTracker[to] {
            let path = cityGraph.findPath(from: from, to: to)
            if path.count > 0 {
               return (print(path), cost(for: path))
            }
        }
        
        return ([], Float(0))
    }
}
