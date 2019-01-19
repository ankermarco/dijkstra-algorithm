//
//  NetworkDispatcherTests.swift
//  tuiTests
//
//  Created by Ke Ma on 17/01/2019.
//  Copyright © 2019 Ke Ma. All rights reserved.
//

import XCTest
@testable import tui

class NetworkDispatcherTests: XCTestCase {
    
    var networkDispatcher: NetworkDispatcher!
    let testingEnv = Environment(TEST_ENV_NAME, baseUrl: MOCKED_BASEURL)
    let mockedSession = MockURLSession()
    let testEndpoint = MockedEndpoint()
    var testUrl: URL!
    
    override func setUp() {
        super.setUp()
        
        networkDispatcher = NetworkDispatcher(environment: testingEnv, session: mockedSession)
        
        guard let url = URL(string: MOCKED_BASEURL + MOCKED_PATH) else {
            fatalError("URL can't be empty")
        }
        testUrl = url
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetRequestWithURL() {

        try? networkDispatcher.exec(testEndpoint) { (response) in
            // Return data
        }
        
        XCTAssert(mockedSession.lastURL == testUrl)
    }
    
    func testGetResumeCalled() {
        
        let dataTask = MockURLSessionDataTask()
        mockedSession.nextDataTask = dataTask
        
        try? networkDispatcher.exec(testEndpoint) { (response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func testGetShouldReturnData() {
        let expectedData = "{}".data(using: .utf8)
        
        mockedSession.nextData = expectedData
        
        var actualData: Response?
        
        try? networkDispatcher.exec(testEndpoint) { (response) in
            actualData = response
        }
        
        XCTAssertNotNil(actualData)
    }
    
}
