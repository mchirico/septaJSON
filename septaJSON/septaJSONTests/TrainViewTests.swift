//
//  TrainViewTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class TrainViewTests: XCTestCase {
  var expectation: XCTestExpectation!
  
  override func setUp() {
    expectation = XCTestExpectation(description: "networking")
  }

    override func tearDown() {
    }
  
    func testTrainView() {
      
      let trainView = TrainView()
      let session = NetworkSessionFixtureMock(forResource: "trainview1",
                                               withExtension: "json")
      
      let networkRefresh = NetworkRefresh<TrainView.TV>(recordResults: trainView as RecordResults)
      
      // Need only for Mock
      networkRefresh.networkManager = NetworkManager(session: session)
      
      networkRefresh.refresh { result in
        let expected = "222"
        let got = result!.tv[0].trainno
        XCTAssert(expected == got, "Expected \(expected)\nGot: \(got) ")
         self.expectation.fulfill()
      }
      
      wait(for: [expectation], timeout: 10)
    }

}
