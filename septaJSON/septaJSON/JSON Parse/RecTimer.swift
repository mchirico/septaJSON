//
//  RecTimer.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class RecTimer {
  var date:Date?
  
  var ti=0
  var ms=0
  var seconds=0
  var minutes=0
  var hours=0
  
  
  
  func stringTime(s: String){
    
    let d = Date()
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" // Output Format
    dateFormatter.dateFormat = "yyyy-MM-dd" // Output Format
    dateFormatter.timeZone = TimeZone.current
    let ds = dateFormatter.string(from: d)
    
    print(s)
    
    let dateString = "\(ds) \(s)"
    dateFormatter.dateFormat = "yyyy-MM-dd h:mma" //Input Format
    dateFormatter.timeZone = TimeZone.current
    let enterDate = dateFormatter.date(from: dateString)
    
    ti = NSInteger((enterDate?.timeIntervalSinceNow)!)
    ms = ti * 1000
    seconds = ti % 60
    minutes = (ti / 60) % 60
    hours = (ti / 3600)
   
  }
  
}
