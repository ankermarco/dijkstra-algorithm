//
//  ConnectionViewModelTests.swift
//  tuiTests
//
//  Created by Ke Ma on 19/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import XCTest

class ConnectionViewModelTests: XCTestCase {
    
    var viewModel: ConnectionViewModel!
    var mockedConnections = [Connection]()
    
    override func setUp() {
        let con1 = Connection(from: "London", to: "Cape Town", price: 700)
        let con2 = Connection(from: "Cape Town", to: "Tokyo", price: 600)
        let con3 = Connection(from: "London", to: "Tokyo", price: 1600)
        mockedConnections.append(con1)
        mockedConnections.append(con2)
        mockedConnections.append(con3)
        viewModel = ConnectionViewModel(connections: mockedConnections)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAddedCorrectCities() {
        XCTAssertEqual(viewModel.cityNodes.count, 3)
    }
    
    func testAddedGraphNode() {
        guard let graphNodes = viewModel.cityGraph.nodes else {
            XCTFail("graph nodes number shouldn't be zero")
            return
        }
        XCTAssertEqual(3, graphNodes.count)
    }
    
    func testNodeShouldHaveConnectedNodes() {
        guard let node = viewModel.cityNodeTracker["London"] else {
            return
        }
        
        XCTAssertEqual(2, node.travelCost.count)
    }
    
    func testCanFindCheapestPath() {
        let expectResult = (["London", "Cape Town", "Tokyo"], Float(1300))
        let cheapestFlight = viewModel.calculateCheapestFlight(from: "London", to: "Tokyo")
        XCTAssertEqual(expectResult.0, cheapestFlight.0)
        XCTAssertEqual(expectResult.1, cheapestFlight.1)
    }


}
