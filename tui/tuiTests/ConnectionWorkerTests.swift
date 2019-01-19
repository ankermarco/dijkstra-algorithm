//
//  ConnectionWorkerTests.swift
//  tuiTests
//
//  Created by Ke Ma on 19/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import XCTest

class ConnectionWorkerTests: XCTestCase {

    var cwt: ConnectionWorker!
    var mockedConnections = [Connection]()
    
    override func setUp() {
        let con1 = Connection(from: "London", to: "Cape Town", price: 700)
        let con2 = Connection(from: "Cape Town", to: "Tokyo", price: 600)
        let con3 = Connection(from: "London", to: "Tokyo", price: 1600)
        mockedConnections.append(con1)
        mockedConnections.append(con2)
        mockedConnections.append(con3)
        cwt = ConnectionWorker(connections: mockedConnections)
    }

    override func tearDown() {
        cwt = nil
    }
    
    func testAddedCorrectCities() {
        XCTAssertEqual(cwt.cityNodes.count, 3)
    }
    
    func testAddedGraphNode() {
        guard let graphNodes = cwt.cityGraph.nodes else {
            XCTFail("graph nodes number shouldn't be zero")
            return
        }
        XCTAssertEqual(3, graphNodes.count)
    }
    
    func testNodeShouldHaveConnectedNodes() {
        guard let node = cwt.cityNodeTracker["London"] else {
            return
        }
        
        XCTAssertEqual(2, node.travelCost.count)
    }
    
    

}
