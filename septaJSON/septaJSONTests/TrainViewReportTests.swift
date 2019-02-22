//
//  TrainViewReportTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/19/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON
class TrainViewReportTests: XCTestCase {

  var expectation: XCTestExpectation!
  
  override func setUp() {
    expectation = XCTestExpectation(description: "networking")
  }
    override func tearDown() {
    }
  
//  func testTrainViewReport() {
//    
//    let trainViewReport = TrainViewReport()
//
//    let session = NetworkSessionFixtureMock(forResource: "trainview",
//                                            withExtension: "json")
//    
//    trainViewReport.trainView.session = session
//    trainViewReport.trainView.networkManager = NetworkManager(session: session)
//    
//    let expected = "Elkins Park"
//    let expectedTrain = "500"
//    
//    trainViewReport.refresh(trainno: "500") { result in
//      print("\(String(describing: result?.trainno))")
//      
//      XCTAssert( result?.nextstop == expected, "Failed ")
//      XCTAssert( result?.trainno == expectedTrain, "Failed ")
//      
//      self.expectation.fulfill()
//    }
//    wait(for: [expectation], timeout: 10)
//    
//  }

    func testExample() {
    }

    func testPerformanceExample() {
        self.measure {

        }
    }

}
