//
//  RRSchedules.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/6/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class RRSchedules: SeptaJSON {
  
  struct RR:Decodable {
    let rr:[Trains]
  }
  
  struct Trains:Decodable {
    let station:String
    let sched_tm:String
    let est_tm:String
    let act_tm:String
    
  }
  
  var urlResults:String = ""
  var records:RR?
  
  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt,with: "{\"rr\":")
      urlResults = urlResults + "}"
      
    }
  }
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(RR.self, from: data.data(using: .utf8)!)
      
      if let records = self.records {
        print(records.rr[0] )
      }
      
    } catch {
      print("Error:",error.localizedDescription)
    }
    
  }
  
}
