import UIKit

var str = "8 mins"



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



str.mins()

