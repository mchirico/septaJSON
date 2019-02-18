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

class TrainView: SeptaJSON {
  
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
  
  func refresh( completionHandler: @escaping(TV?) -> Void) {

    let url = URL(string: refreshURL)!
    
    networkManager.loadData(from: url) { result in
      switch result {
      case .success(let data):
        self.urlResults = String(data: data, encoding: .utf8) ?? ""
        if self.urlResults != "" {
          self.lastGotRequest = Date()
          self.lastRequestStatus = 1
          self.parseString(data: self.urlResults)

        } else {
          self.lastRequestStatus = 0
        }
        
      case .failure:
        self.lastRequestStatus = -1
        print("❌ Error TrainView (networkManager): ")
      }
      
      completionHandler(self.records)
    }
  }
  
  func networkManager(url: String,
                      session: NetworkSession = URLSession.shared) {
    
    let network = NetworkManager(session: session)
    let url = URL(string: url)!
    
    network.loadData(from: url) { result in
      switch result {
      case .success(let data):
        self.urlResults = String(data: data, encoding: .utf8) ?? ""
        if self.urlResults != "" {
          self.lastGotRequest = Date()
          self.lastRequestStatus = 1
          self.parseString(data: self.urlResults)
        } else {
           self.lastRequestStatus = 0
        }

      case .failure:
        self.lastRequestStatus = -1
        print("❌ Error TrainView (networkManager): ")
      }

    }
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
