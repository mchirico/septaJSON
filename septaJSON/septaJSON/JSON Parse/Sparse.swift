//
//  Sparse.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/4/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class Sparse {
  
  var date: Date?
  var stringDate: String?
  var orig: String = ""
  
  var offset: Int?
  
  var json: String = "{}"
  
  func secondsFromGMT() -> Int {
    return Int(TimeZone.current.secondsFromGMT())
  }
  
  func process(s: String) {
    getTime(s: s)
    makeValidJSON(s: s)
  }
  
  func getTime(s: String) {
    
    orig = String(s)
    
    var startOfpt = s.firstIndex(of: ":")!
    var endOfpt = s.firstIndex(of: "[")!
    
    let ss = s[startOfpt...endOfpt]
    
    startOfpt = ss.firstIndex(of: " ")!
    endOfpt = ss.firstIndex(of: "\"")!
    
    startOfpt = ss.index(startOfpt, offsetBy: 1)
    endOfpt = ss.index(endOfpt, offsetBy: -1)
    
    let time = ss[startOfpt...endOfpt]
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM d, yyyy, m:mm a"
    //dateFormatter.timeZone =  TimeZone(identifier: "EDT")
    
    date = dateFormatter.date(from: String(time))
    offset = Int(date?.timeIntervalSinceNow ?? 0)
    
    date = date?.addingTimeInterval(TimeInterval(secondsFromGMT()))
    stringDate =  String(time)

  }
  
  func makeValidJSON(s: String) {
    
    json = String(s)
    let startOfpt = json.firstIndex(of: "\"")!
    let endOfpt = json.firstIndex(of: "[")!
    json.replaceSubrange(startOfpt..<endOfpt, with: "\"Depart\":")
    
  }
  
}
