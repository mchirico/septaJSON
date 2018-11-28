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
  
  struct TV:Decodable {
    let tv:[Trains]
  }
  
  struct Trains:Decodable {
    let lat:String
    let lon:String
    let trainno:String
    let service:String
    let dest:String
    let nextstop:String
    let line:String
    let consist:String
  }
  
  var urlResults:String = ""
  var records:TV?
  
  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt,with: "{\"tv\":")
      urlResults = urlResults + "}"
      
    }
  }
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(TV.self, from: data.data(using: .utf8)!)
    } catch {
      print("Error:",error.localizedDescription)
    }
    
  }
  
}
