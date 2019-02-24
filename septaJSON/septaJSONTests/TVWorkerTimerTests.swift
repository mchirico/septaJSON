//
//  TVWorkerTimerTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class TVWorkerTimerTests: XCTestCase {
  var expectation: XCTestExpectation!
  
  override func setUp() {
    expectation = XCTestExpectation(description: "networking")
  }
  
  override func tearDown() {
  }
   
  func testTimer() {
    let session = NetworkSessionFixtureMock(forResource: "trainview1",
                                            withExtension: "json")
    
    let tvWorker = TVWorker(session: session)
    let execTimer = ExecTimer(execForTimer: tvWorker)
    
    execTimer.startTimer()
    sleep(10)
    XCTAssert(execTimer.count == 32, "Should have been 32")
    
    if let records = execTimer.records {
      XCTAssert(records.tv[0].trainno == "222", "Should be 222")
    } else {
      XCTFail()
    }
    
  }
  
  func testTVWorker() {
    
    let session = NetworkSessionFixtureMock(forResource: "trainview1",
                                            withExtension: "json")
    
    let tvWorker = TVWorker(session: session)
    
    tvWorker.refresh { result in
      
      XCTAssert(result == 32, "Result: \(result)")
      self.expectation.fulfill()
      
    }
    wait(for: [expectation], timeout: 10)
  }

}
