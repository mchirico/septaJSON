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
  
  func testTrainViewReport() {
    
    let trainViewReport = TrainViewReport()

    let stationArrival = StationArrival()
    let session0 = NetworkSessionFixtureMock(forResource: "arrivalsElkins",
                                             withExtension: "json")
    let trainView = TrainView()
    let session1 = NetworkSessionFixtureMock(forResource: "trainview1",
                                             withExtension: "json")
    
    trainViewReport.refreshStation = NetworkRefresh<StationArrival.SA>(recordResults: stationArrival as RecordResults)
    trainViewReport.refreshStation?.networkManager = NetworkManager(session: session0)
    
    trainViewReport.refreshTrainView = NetworkRefresh<TrainView.TV>(recordResults: trainView as RecordResults)
    trainViewReport.refreshTrainView?.networkManager = NetworkManager(session: session1)
    
    trainViewReport.refresh(trainno: "32", station: "station") { result1, result2 in
      
      XCTAssert(result1[0].Northbound?[0].train_id == "422",
                "Expected 422\nGot: \(String(describing: result1[0].Northbound?[0].train_id))")
      
      var sum = 0
      result2.forEach { sum += Int($0.trainno)! }
      XCTAssert(sum == 61409, "Total sum should be 61409. Got: \(sum)")

      print("RESULT: \(result1)")
      print("RESULT: \(result2)")
      
      self.expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
  }
  
  // RecordResults -- tests
  func testTrainViewProtocol() {
    
    let trainView = TrainView()
    let session = NetworkSessionFixtureMock(forResource: "trainview1",
                                            withExtension: "json")
    
    let networkRefresh = NetworkRefresh<TrainView.TV>(recordResults: trainView as RecordResults)
    networkRefresh.networkManager = NetworkManager(session: session)
    
    networkRefresh.refresh { result in
      
      XCTAssert(result!.tv[0].trainno == "222", "Not correct train")
      
      self.expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
    
  }
  
  func testStationArrivalNetworkRefresh() {
    let stationArrival = StationArrival()
    
    let session = NetworkSessionFixtureMock(forResource: "arrivalsElkins",
                                            withExtension: "json")
    
    let networkRefresh = NetworkRefresh<StationArrival.SA>(recordResults: stationArrival as RecordResults)
    networkRefresh.networkManager = NetworkManager(session: session)
    
    networkRefresh.refresh { result in
      
      XCTAssert(result!.sa![0].Northbound![0].train_id == "422", "Not correct train")
      
      self.expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
    
  }
  
  func testTrainViewNetworkRefresh() {
    let trainView = TrainView()
    let session = NetworkSessionFixtureMock(forResource: "trainview1",
                                            withExtension: "json")
    
    let networkRefresh = NetworkRefresh<TrainView.TV>(recordResults: trainView as RecordResults)
    networkRefresh.networkManager = NetworkManager(session: session)
    
    networkRefresh.refresh { result in
      
      XCTAssert(result!.tv[0].trainno == "222", "Not correct train")
      
      self.expectation.fulfill()
    }
    
    wait(for: [expectation], timeout: 10)
    
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
