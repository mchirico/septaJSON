import UIKit

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

let sdate = ss[startOfpt...endOfpt]

let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "hh:mm"
var date = dateFormatter.date(from: "00:00")


print(ss)
