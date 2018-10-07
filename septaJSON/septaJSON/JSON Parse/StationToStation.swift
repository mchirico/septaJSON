//
//  JSONdecode.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/5/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//
/*
 https://www3.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=40
 */


import Foundation

protocol SeptaJSON {
  func getURL(url: String)
  func parseString(data: String)
}



class StationToStation: SeptaJSON {
  
  struct S2S:Decodable {
    let sts:[Trains]
  }
  
  struct Trains:Decodable {
    let orig_train:String
    let orig_line:String
    let orig_departure_time:String
    let orig_arrival_time:String
    let orig_delay:String
    let isdirect:String
  }
  
  var urlResults:String = ""
  var records:S2S?
  
  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt,with: "{\"sts\":")
      urlResults = urlResults + "}"
      
    }
  }
  
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(S2S.self, from: data.data(using: .utf8)!)
      
      if let records = self.records {
        print(records.sts[0] )
      }
      
    } catch {
      print("Error:",error.localizedDescription)
    }
    
  }
  
}
