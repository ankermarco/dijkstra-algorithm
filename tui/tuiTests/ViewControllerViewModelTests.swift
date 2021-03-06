//
//  ViewControllerViewModelTests.swift
//  tuiTests
//
//  Created by Ke Ma on 19/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import XCTest

class ViewControllerViewModelTests: XCTestCase {
    
    var viewModel: ViewControllerViewModel!
    var mockedSession: MockURLSession!

    override func setUp() {
        mockedSession = MockURLSession()
        viewModel = ViewControllerViewModel(environmentName: TEST_ENV_NAME, url: MOCKED_BASEURL, session: mockedSession)
        
    }

    override func tearDown() {
        viewModel = nil
        mockedSession = nil
    }
    
    func testCanGetFlightConnectionData() {
        
        let expectedConnections = "{}".data(using: .utf8)
        
        mockedSession.nextData = expectedConnections
        
        viewModel.fetchFlightConnections { (connections) in
            print(connections)
            //XCTAssertEqual(connections, expectedConnections)
        }
    }

}
