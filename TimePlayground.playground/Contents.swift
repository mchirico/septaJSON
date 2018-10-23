import UIKit

var str = " 3:00pm"


func secondsFromGMT() -> Int {
  return Int(TimeZone.current.secondsFromGMT())
}

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MMMM d, yyyy, mm:mm.SSS a"

let now = Date()

dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSa"
let stringDate = dateFormatter.string(from: now)


print(stringDate)


//let date = now.addingTimeInterval(TimeInterval(secondsFromGMT()))
print(TimeZone.current)

func UTCToLocal(UTCDateString: String) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" //Input Format
  dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
  let UTCDate = dateFormatter.date(from: UTCDateString)
  
  dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ssa" // Output Format
  dateFormatter.timeZone = TimeZone.current
  let UTCToCurrentFormat = dateFormatter.string(from: UTCDate!)
  return UTCToCurrentFormat
}

func LocalToUTC(dateString: String) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" //Input Format
  dateFormatter.timeZone = TimeZone.current
  let localDate = dateFormatter.date(from: dateString)
  
  dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ssa" // Output Format
  dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone

  let outFormat = dateFormatter.string(from: localDate!)
  return outFormat
}

// 
func Local(dateString: String) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ssa" //Input Format
  dateFormatter.timeZone = TimeZone.current
  let localDate = dateFormatter.date(from: dateString)
  
  dateFormatter.dateFormat = "yyyy-MMM-dd hh:mm:ssa" // Output Format
  //dateFormatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
  
  let outFormat = dateFormatter.string(from: localDate!)
  return outFormat
}

let septaInput="11:59PM"


let dateString = "2017-10-10 9:56:25pm"
print( LocalToUTC(dateString: dateString))
print( UTCToLocal(UTCDateString: dateString))

print( Local(dateString: dateString))





