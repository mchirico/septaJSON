//
//  NetworkRefresh.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/20/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import Foundation

protocol RecordResults {
  func getRecords<T>() -> T?
  func setURLresults(results: String)
  func getURLresults() -> String
  func setLastGotRequest(time: Date)
  func setLastRequestStatus(status: Int)
  func preParse()
  func parseString(data: String)
  func getRefreshURL() -> String
}

class NetworkRefresh<T> {
  
  var recordResults: RecordResults!
  var networkManager = NetworkManager()
  
  init(recordResults: RecordResults) {
    self.recordResults = recordResults
  }
  
  func refresh ( completionHandler: @escaping(T?) -> Void) {
    
    let url = URL(string: self.recordResults.getRefreshURL())!
    
    networkManager.loadData(from: url) { result in
      
      switch result {
      case .success(let data):
        self.recordResults.setURLresults(results:
          String(data: data, encoding: .utf8) ?? "")
        
        if self.recordResults.getURLresults() != "" {
          self.recordResults.setLastGotRequest(time: Date())
          self.recordResults.setLastRequestStatus(status: 1)

          self.recordResults.preParse()
          self.recordResults.parseString(data: self.recordResults.getURLresults() )
          
        } else {
          self.recordResults.setLastRequestStatus(status: 0)
        }
        
      case .failure:
        self.recordResults.setLastRequestStatus(status: -1)
        print("❌ NetworkRefresh refresh:")
      }
      completionHandler(self.recordResults.getRecords())
    }
  }
  
}
