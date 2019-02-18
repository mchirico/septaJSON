//
//  TrainView.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/6/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

/*
 
 https://www3.septa.org/hackathon/TrainView/
 */

import Foundation

class TrainView: SeptaJSON, RecordResults {
  
  struct TV: Decodable {
    let tv: [Trains]
  }
  
  struct Trains: Decodable {
    let lat: String
    let lon: String
    let trainno: String
    let service: String
    let dest: String
    let nextstop: String
    let line: String
    let consist: String
    let heading: Double?
    let late: Int
    let SOURCE: String
    let TRACK: String
    let TRACK_CHANGE: String
    
  }
  
  var urlResults: String = ""
  var records: TV?
  var lastGotRequest: Date?
  var lastRequestStatus = 0
  var networkManager = NetworkManager()
  var session: NetworkSession = URLSession.shared
  
  var refreshURL = "https://www3.septa.org/hackathon/TrainView/"
  
  func getRecords<T>() -> T {
    return self.records as! T
  }
  
  func setURLresults(results: String) {
    self.urlResults = results
  }
  
  func getURLresults() -> String {
    return self.urlResults
  }
  
  func setLastGotRequest(time: Date) {
    self.lastGotRequest = time
  }
  
  func setLastRequestStatus(status: Int) {
    self.lastRequestStatus = status
  }
  
  func preParse() {
    
    let startOfpt = urlResults.startIndex
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt, with: "{\"tv\":")
      urlResults += "}"
      
    }
  }
  
  func getRefreshURL() -> String {
    return self.refreshURL
  }

  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt, with: "{\"tv\":")
      urlResults += "}"
      
    }
  }
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(TV.self, from: data.data(using: .utf8)!)
    } catch {
      print("Error (TrainView):", error.localizedDescription)
    }
    
  }
  
}
