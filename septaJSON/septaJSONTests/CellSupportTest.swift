//
//  CellSupportTest.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class CellSupportTest: XCTestCase {
  
  override func setUp() {
    
  }
  
  override func tearDown() {
    
  }
  
  func exec() {
    print("RAN EXEC!!!")
  }
  
  func testCellSupport() {
    
    let cellSupport = CellSupport(number: 10)
    
    cellSupport.setCellBounds(bounds: CGRect(x: 0, y: 0, width: 10, height: 50))
    
    cellSupport.setViewBounds(bounds: CGRect(x: 0, y: 0, width: 10, height: 50))
    
    XCTAssert(cellSupport.cellBounds.width == 10, "Expected 10")
    
    let resultV = cellSupport.fill(row: 0, text: "stuff")
    
    let result = cellSupport.bgVF.labelContainer0[0].text
    
    XCTAssert(result == "stuff", "Got: \(String(describing: result))")
    
    let expected = "stuff"
    
    XCTAssert(resultV.subviews.description.contains(expected), "Put in expected")
    
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
