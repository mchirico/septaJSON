//
//  RecTimer.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

extension String
{
  func mins() -> [Int?]
  {
    if let regex = try? NSRegularExpression(pattern: "[a-z0-9]+ mins", options: .caseInsensitive)
    {
      let string = self as NSString
      
      return regex.matches(in: self, options: [], range: NSRange(location: 0, length: string.length)).map {
        Int(string.substring(with: $0.range).replacingOccurrences(of: " mins", with: ""))
      }
    }
    
    return []
  }
}



class RecTimer {
  var date:Date?
  
  var ti=0
  var ms=0
  var seconds=0
  var minutes=0
  var hours=0
  
  var delay=0
  
  
  func delay(s: String?){
    
    if let s = s {
      
      if s.mins().count == 0 {
        self.delay = 0
        return
      }
      
      if let delay = s.mins()[0] {
        self.delay = delay
      } else {
        delay = 0
      }
    } else {
      delay = 0
    }
    
  }
  
  
  func stringTime(s: String){
    
    let d = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" // Output Format
    dateFormatter.dateFormat = "yyyy-MM-dd" // Output Format
    dateFormatter.timeZone = TimeZone.current
    let ds = dateFormatter.string(from: d)
    
    let dateString = "\(ds) \(s)"
    dateFormatter.dateFormat = "yyyy-MM-dd h:mma" //Input Format
    dateFormatter.timeZone = TimeZone.current
    let enterDate = dateFormatter.date(from: dateString)
    
    ti = NSInteger((enterDate?.timeIntervalSinceNow)!)
    ms = ti * 1000
    seconds = ti % 60
    minutes = (ti / 60) % 60 + delay
    hours = (ti / 3600)
    
  }
  
}
