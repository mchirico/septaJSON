//
//  Request.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/3/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class Request{
  
  var contents = ""
  
  /*
  func post(url: String, _ locationFile: String, data: Data) {
    
    let TOKEN="abc"
    let size=data.count
    
    let request = NSMutableURLRequest(url: URL(string: url)!)
    
    request.httpMethod = "POST"
    request.setValue("Bearer \(TOKEN)", forHTTPHeaderField: "Authorization")
    request.setValue("{\"path\": \"\(locationFile)\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false}", forHTTPHeaderField: "Dropbox-API-Arg")
    
    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    request.setValue("\(size)", forHTTPHeaderField: "Content-Length")
    request.setValue("100-continue", forHTTPHeaderField: "Expect")
    request.httpBody = data

    let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
      data, response, error in
      
      if error != nil {
        let defaultMessage = "error: URLSession.shared.dataTask"
        print("error=\(error ?? defaultMessage as! Error)")
        return
      }
      
      print("response = \(String(describing: response))")
      
      let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
      print("responseString = \(String(describing: responseString))")
    })
    task.resume()
    
  }
  
  
  
  func getURL2(url: String) {
    let request = NSMutableURLRequest(url: URL(string: url)!)
    request.httpMethod = "GET"
    request.timeoutInterval = 14
    
    let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
      data, response, error in
      
      self.contents = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String
      print(self.contents)
      print("here")
      
    })
    task.resume()
    
  }
  */
  
  func getURL(url: String){
    
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
