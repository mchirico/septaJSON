//
//  SeptaJSONTrainViewV2.swift
//  SeptaJSONUITests
//
//  Created by Michael Chirico on 2/18/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class SeptaJSONTrainViewV2: XCTestCase {
  
  var expectation: XCTestExpectation!
  
  override func setUp() {
    expectation = XCTestExpectation(description: "networking")
  }
  
  override func tearDown() {
  }
  
  func testTrainViewRefresh() {
    
    let trainView = TrainView()
    let session = NetworkSessionFixtureMock(forResource: "trainview",
                                            withExtension: "json")
    
    trainView.session = session
    trainView.networkManager = NetworkManager(session: session)
    
    let expected = "Jefferson Station"
    let expectedTrain = "1502"
    
    trainView.refresh { result in
      print("\(String(describing: result?.tv[0].trainno))")
      
      XCTAssert( result?.tv[0].nextstop == expected, "Failed ")
      XCTAssert( result?.tv[0].trainno == expectedTrain, "Failed ")
      
       self.expectation.fulfill()
    }
   wait(for: [expectation], timeout: 10)
    
  }
  
  func testTrainViewNetworkManager() {
    
    let trainView = TrainView()
    let session = NetworkSessionFixtureMock(forResource: "trainview",
                                            withExtension: "json")
    
    trainView.networkManager(url: "blank", session: session)
    sleep(1)
    
    XCTAssert(trainView.lastRequestStatus == 1, "Fail")
    print(trainView.urlResults)
  }
  
  func testTrainViewNetworkManagerFail() {
    let trainView = TrainView()
    let session = NetworkSessionFixtureMock(forResource: "fail",
                                            withExtension: "json")
    
    trainView.networkManager(url: "blank", session: session)
    sleep(1)
    
    XCTAssert(trainView.lastRequestStatus == -1, "Fail")
    
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
