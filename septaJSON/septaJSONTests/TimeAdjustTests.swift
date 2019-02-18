//
//  TimeAdjustTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/18/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class TimeAdjustTests: XCTestCase {
  
  override func setUp() {
  }
  
  override func tearDown() {
  }
  
  func testTimeAdjust() {
    let timeAdjust = TimeAdjust()
    var result = timeAdjust.LocalToUTC(dateString: "2019-02-18 04:09:23PM")
    XCTAssert(result == "2019-Feb-18 09:09:23PM", "Should have been 2019-Feb-18 09:09:23PM")
    
    result = timeAdjust.UTCToLocal(UTCDateString: "2019-02-18 04:09:23PM")
    XCTAssert(result == "2019-Feb-18 11:09:23AM", "Should have been 2019-Feb-18 11:09:23AM")
  }
  
  func testPerformanceExample() {
    self.measure {
    }
  }
  
}
