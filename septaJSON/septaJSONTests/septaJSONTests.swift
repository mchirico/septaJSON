//
//  SeptaJSONTests.swift
//  SeptaJSONTests
//
//  Created by Michael Chirico on 10/13/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import XCTest
@testable import SeptaJSON

class SeptaJSONTests: XCTestCase {
  
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
    let p = JsonExtract()
    p.parseJSONTest()
  }
  
  func testStationToStationGetURL() {
    let p = StationToStation()
    
    let url = """
https://www3.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=40
"""
    p.getURL(url: url)
    p.parseString(data: p.urlResults)
    
    if p.records!.sts.count < 3 {
      XCTFail()
    }
  }
  
  func testTrainViewGetURL() {
    let p = TrainView()
    
    let url = """
https://www3.septa.org/hackathon/TrainView/
"""
    p.getURL(url: url)
    p.parseString(data: p.urlResults)
    
    if p.records!.tv.count < 3 {
      XCTFail()
    }
  }
  
  
  func testRRSchedules() {
    
    let p = TrainView()
    
    let url = """
https://www3.septa.org/hackathon/TrainView/
"""
    p.getURL(url: url)
    p.parseString(data: p.urlResults)
    
    let train_no = p.records!.tv[0].trainno
    
    let url2 = "https://www3.septa.org/hackathon/RRSchedules/\(train_no)"
    
    let p2 = RRSchedules()
    p2.getURL(url: url2)
    p2.parseString(data: p2.urlResults)
    
    print(p2.urlResults)
    XCTAssert((p2.records?.rr.count)! > 3, "Not getting trains")
    
    
  }
  
  
  
  func testRRSchedulesBadJSON() {
    
    let p = TrainView()
    
    let url = """
https://www3.septa.org/hackathon/TrainView/
"""
    p.getURL(url: url)
    p.parseString(data: p.urlResults)
    
    let train_no = p.records!.tv[0].trainno
    
    let url2 = "https://www3.septa.org/hackathon/RRSchedules/\(train_no)"
    
    let p2 = RRSchedules()
    p2.getURL(url: url2)
    
    // NOTE: putting in p instead of p2, which is wrong
    p2.parseString(data: p.urlResults)
    
    if p2.records != nil {
      XCTFail()
    }
    
  }
  
  
  
  
  func testStationToStation() {
    
    //String(data: data!, encoding: .utf8)
    if let url = Bundle.main.url(forResource: "stationTostation", withExtension: "json") {
      
      do {
        let data = try Data(contentsOf: url)
        let sdata = String(data: data, encoding: .utf8)
        
        let p = StationToStation()
        p.parseString(data: sdata!)
        
        let train_id = p.records!.sts[0].orig_train
        XCTAssert(train_id == "412")
        
      } catch {
        print("Error:",error.localizedDescription)
        XCTFail()
      }
    }
  }
  
  
  func testParseString() {
    //String(data: data!, encoding: .utf8)
    if let url = Bundle.main.url(forResource: "depart", withExtension: "json") {
      
      do {
        let data = try Data(contentsOf: url)
        let sdata = String(data: data, encoding: .utf8)
        
        let p = JsonExtract()
        p.parseString(data: sdata!)
        
        let train_id = p.departListing!.depart[0].Northbound?[0].train_id
        XCTAssert(train_id == "440")
        
        if let countNorth = p.departListing!.depart[0].Northbound?.count {
          XCTAssert(countNorth == 5)
        } else {
          XCTFail()
        }
        
        if let countSouth = p.departListing!.depart[1].Southbound?.count {
          XCTAssert(countSouth == 5)
        } else {
          XCTFail()
        }
        
        
      } catch {
        print("Error:",error.localizedDescription)
        XCTFail()
      }
    }
  }
  
  
  func testReadStations(){
    
    let r = ReadStations()
    r.readCSV()
    //print(r.data)
    
    let msg = """
Did a new station get added?

"""
    XCTAssert(r.data!.count == 154, msg)
    
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
