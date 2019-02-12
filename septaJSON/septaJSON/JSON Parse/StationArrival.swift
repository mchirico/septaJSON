//
//  StationArrival.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/11/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

/*
 http://www3.septa.org/hackathon/Arrivals/Suburban%20Station/5/
 
 */

import Foundation

class StationArrival: SeptaJSON {
  struct SA: Decodable {
    let sa: [Arrival]?
  }
  
  struct Arrival: Decodable {
    let Northbound: [Train]?
    let Southbound: [Train]?
  }
  
  struct Train: Decodable {
    let direction: String
    let path: String
    let train_id: String
    let origin: String?
    let destination: String?
    let line: String?
    let status: String?
    let service_type: String?
    let next_station: String?
    let sched_time: String?
    let depart_time: String?
    let track: String?
    let track_change: String?
    let platform: String?
    let platform_change: String?
    
  }
  
  var urlResults: String = ""
  // var records:SA?
  var records: SA?
  
  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt, with: "{\"sa\":")
      
    }
  }
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(SA.self, from: data.data(using: .utf8)!)
    } catch {
      print("Error (StationArrival):", error.localizedDescription)
    }
    
  }
  
}
