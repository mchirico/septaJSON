//
//  Request.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/3/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

// TODO: Take a look at: https://www.swiftbysundell.com/posts/mocking-in-swift
// https://github.com/mchirico/MockMock/blob/master/MockMock/MockMock/Network.swift
import Foundation

class Request {
  
  var contents = ""
    
  func getURL(url: String) {
    
    // Maybe
    // https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory
    // Also
    // https://www.raywenderlich.com/567-urlsession-tutorial-getting-started
    
    if let url = URL(string: url) {
      
      do {
        contents = try String(contentsOf: url)
      } catch {
        print("Contents could not be loaded")
      }
    } else {
      print("The URL was bad")
    }
  }
  
}
