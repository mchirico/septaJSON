//
//  TimeAdjust.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class TimeAdjust {
  
  func timeAppend(time: String) -> Date? {
    let now = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let stringDate = dateFormatter.string(from: now)
    let appendTime = "\(stringDate) \(time)"
    
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mma" //Input Format
    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    let UTCDate = dateFormatter.date(from: appendTime)
    
    return UTCDate
  }
  
  func UTCToLocal(UTCDateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" //Input Format
    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    let UTCDate = dateFormatter.date(from: UTCDateString)
    
    dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ssa" // Output Format
    dateFormatter.timeZone = NSTimeZone(name: "America/New_York")! as TimeZone
    let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
    return UTCToCurrentFormat
  }
  
  func LocalToUTC(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" //Input Format
    dateFormatter.timeZone = NSTimeZone(name: "America/New_York")! as TimeZone
    let localDate = dateFormatter.date(from: dateString)
    
    dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ssa" // Output Format
    dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    
    let outFormat = dateFormatter.string(from: localDate!)
    return outFormat
  }
}
