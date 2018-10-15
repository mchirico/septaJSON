import UIKit

var str = "Hello, playground"
var someDict:[Int:String] = [1:"One", 2:"Two", 3:"Three"]

var p:[String:String] = ["one":"some","two":"2"]

for (k,v) in p.enumerated() {
  print(k,v)
}

if let p = p["one"] {
  print(p)
}
print(p["one"])
