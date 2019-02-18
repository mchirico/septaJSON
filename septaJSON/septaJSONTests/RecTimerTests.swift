//
//  RecTimerTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/18/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class RecTimerTests: XCTestCase {
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testExample() {
  }
  
  func testRecTimer() {
    let recTimer = RecTimer()
    recTimer.stringTime(s: "8:50PM")
    
    var result = "3 mins".mins()
    XCTAssert(result == [3], "Should get [3]")
    
    result = "3 min".mins()
    XCTAssert(result == [], "Should get []")
    
    recTimer.delay(s: "3 mins")
    XCTAssert(recTimer.delay == 3, "Should get 3 (Int)")
    
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
  
}
