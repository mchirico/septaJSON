//
//  septaJSONTests.swift
//  septaJSONTests
//
//  Created by Michael Chirico on 10/3/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import XCTest
@testable import septaJSON

class septaJSONTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  
  func testParse() {
    let r = Request()
    let url = "https://www3.septa.org/hackathon/Arrivals/Elkins%20Park"
    
    r.getURL(url: url)
    let sparse = Sparse()
    sparse.process(s: r.contents)
    
    XCTAssert(sparse.offset! < 65, "No offset")
    
    print(sparse.json)
  }
  
  func testParseJSONT() {
    
    let p = ParseDeparture()
    p.parseJSONT()
  }
  
  func testParseJSON() {
    
    let p = ParseDeparture()
    p.parseJSON()
  }
  
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
