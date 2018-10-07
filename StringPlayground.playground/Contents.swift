import UIKit

func secondsFromGMT() -> Int {
  return Int(TimeZone.current.secondsFromGMT())
}

var s = """
{"Elkins Park Departures: October 4, 2018, 7:52 am":[{"Northbound"
"""



var startOfpt = s.firstIndex(of: ":")!
var endOfpt = s.firstIndex(of: "[")!

var ss = s[startOfpt...endOfpt]

startOfpt = ss.firstIndex(of: " ")!
endOfpt = ss.firstIndex(of: "\"")!

startOfpt = ss.index(startOfpt, offsetBy: 1)
endOfpt = ss.index(endOfpt, offsetBy: -1)

let dateTime = ss[startOfpt...endOfpt]

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MMMM d, yyyy, m:mm a"
//dateFormatter.timeZone =  TimeZone(identifier: "EDT")

var date = dateFormatter.date(from: String(dateTime))
let offset = Int(date?.timeIntervalSinceNow ?? 0)

 date = date?.addingTimeInterval(TimeInterval(secondsFromGMT()))
let stringDate =  String(dateTime)





print(stringDate)
