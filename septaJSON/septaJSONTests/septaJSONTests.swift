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
  
  // For now skip
  /*
   func testFailure() {
   let p = StationToStation()
   
   let url = """
   https://www4.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=40
   """
   p.getURL(url: url)
   p.parseString(data: p.urlResults)
   
   
   } */
  
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
    
    print(p.records!.sts)
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
    // let track = p.records!.tv[0].TRACK
    
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
        print("Error:", error.localizedDescription)
        XCTFail()
      }
    }
  }
  
  func testRecTimer() {
    
    if let url = Bundle.main.url(forResource: "stationTostation", withExtension: "json") {
      
      do {
        let data = try Data(contentsOf: url)
        let sdata = String(data: data, encoding: .utf8)
        
        let p = StationToStation()
        p.parseString(data: sdata!)
        
        let train_id = p.records!.sts[0].orig_train
        XCTAssert(train_id == "412")
        
        print(p.records!.sts[0].orig_departure_time)
        
        let r = RecTimer()
        
        r.stringTime(s: "8:50PM")
        
        // Very simple... just check we got a value
        XCTAssert(r.ti != 0)
        
      } catch {
        print("Error:", error.localizedDescription)
        XCTFail()
      }
    }
    
  }
  
  func testStationToStationLive() {
    let url = "https://www3.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=40"
    
    let sts = StationToStation()
    sts.getURL(url: url)
    sts.parseString(data: sts.urlResults)
    
    print(sts.records!)
    XCTAssert(sts.records!.sts.count >= 3, "This is live data. May not work after 11pm")
  }
  
  // Swift - How do you mock http calls?
  // https://github.com/kylef/Mockingjay
  func testTravel() {
    if let url = Bundle.main.url(forResource: "trainView_url", withExtension: "url") {
      
      do {
        let data = try Data(contentsOf: url)
        let sdata = String(data: data, encoding: .utf8)
        
        print("here", sdata)
        
      } catch {
        print("Error:", error.localizedDescription)
        XCTFail()
      }
      
    }
  }
  
  // TODO: Create a lot more tests
  func testTravelStatic() {
    let trainView_url = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/trainView_url.json"
    let url0 = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/url0.json"
    let url1 = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/url1.json"
    let station_url = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/station_url.json"
    
    let t = Travel(trainView_url: trainView_url, url0: url0, url1: url1, station_url: station_url)
    
    XCTAssert(t.sts[0].records!.sts[0].orig_train == "467")
    XCTAssert(t.sts[0].records!.sts[0].orig_departure_time == " 8:28PM")
    XCTAssert(t.sts[0].records!.sts[3].orig_departure_time == " 9:47PM")
    XCTAssert(t.trainView.records!.tv[3].line == "Media/Elwyn")
    XCTAssert(t.trainView.records!.tv[0].lat == "39.964317833333")
    
    let track = t.plannedTrackNorth(trainno: "390")
    XCTAssert(track == "2A")
    
    let msg = t.msgTrack(index: 0, row: 0, nextstop: "30th St")
    //XCTAssert(msg == "467:  8:28PM On time   ")
    
    let train = t.msgTrack(index: 0, row: 0, nextstop: "30th St")
    
    print("\n\n\n ********* \n\n ->\(msg)<-")
    
    XCTAssert(t.count(index: 0) == 7)
    XCTAssert(t.trainView.records!.tv.count == 34)
    XCTAssert(t.sts.count > 0)
    
  }
  
  func testNext() {
    
    let trainView_url = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/trainView_url.json"
    let url0 = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/url0.json"
    let url1 = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/url1.json"
    let station_url = "https://github.com/mchirico/septaJSON/raw/develop/fixtures/station_url.json"
    
    let t = Travel(trainView_url: trainView_url, url0: url0, url1: url1, station_url: station_url)
    
    XCTAssert("Temple U" == t.nextStationSouth(trainno: "465"))
    XCTAssert("Jenkintown-Wyncote" == t.nextStationSouth(trainno: "581"))
    
    XCTAssert("30th St" == t.nextStationNorth(trainno: "390"))
    
    let r = t.sts[0].records!.sts[0].orig_train
    print("\n\nr==\(r)")
    
    let expected = "  ,\t "
    XCTAssert(t.nextStations() == expected)
  }
  
  func testParseString() {
    // String(data: data!, encoding: .utf8)
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
        print("Error:", error.localizedDescription)
        XCTFail()
      }
    }
  }
  
  func testReadStations() {
    
    let r = ReadStations()
    r.readCSV()
    //print(r.data)
    
    let msg = """
Did a new station get added?

"""
    XCTAssert(r.data!.count == 154, msg)
    
  }
  
  func testTime() {
    let t = TimeAdjust()
    let s = "7:23PM"
    
    XCTAssert(t.timeAppend(time: s) != nil, "Time not converting")
    
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
  
  func testStationArrivalLiveTest() {
    let url = "https://www3.septa.org/hackathon/Arrivals/Suburban%20Station/5/"
    
    let sa = StationArrival()
    sa.getURL(url: url)
    sa.parseString(data: sa.urlResults)
    XCTAssert((sa.records?.sa!.count)! > 1, "No Records")
    
    if let trains_N = sa.records?.sa?[0].Northbound {
      for train in trains_N {
        print("train_id: \(train.train_id)")
        print("train_id: \(String(describing: train.track))")
      }
    }
    
  }
  
  func testStationArriveWithFixture() {
    
    if let url = Bundle.main.url(forResource: "StationArrive", withExtension: "json") {
      
      do {
        let data = try Data(contentsOf: url)
        let sdata = String(data: data, encoding: .utf8)
        
        let sa = StationArrival()
        sa.parseString(data: sdata!)
        
        XCTAssert((sa.records?.sa!.count)! == 2,
                  "Need both Northbound and Southbound")
        
      } catch {
        print("Error:", error.localizedDescription)
        XCTFail()
      }
    }
  }

}
