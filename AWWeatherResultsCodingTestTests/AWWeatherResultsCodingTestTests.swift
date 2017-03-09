//
//  AWWeatherResultsCodingTestTests.swift
//  AWWeatherResultsCodingTestTests
//
//  Created by Augustus on 3/8/17.
//  Copyright © 2017 Augustus. All rights reserved.
//

import XCTest
@testable import AWWeatherResultsCodingTest

class AWWeatherResultsCodingTestTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testClassNil() {
        let object = AWWeatherResults.init()
        XCTAssertNotNil(object)
    }


   
    
}
