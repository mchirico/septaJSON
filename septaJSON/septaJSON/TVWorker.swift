//
//  TVWorker.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import Foundation

class TVWorker {

  let trainView = TrainView()
  var networkRefresh: NetworkRefresh<TrainView.TV>!
  
  init(session: NetworkSession = URLSession.shared ) {
    networkRefresh = NetworkRefresh<TrainView.TV>(recordResults: trainView as RecordResults)
    networkRefresh.networkManager = NetworkManager(session: session)
  }
  
  func refresh ( completionHandler: @escaping(Int) -> Void) {
    
    if let r = networkRefresh {
      r.refresh { result in

        if let result = result {
          completionHandler(result.tv.count)
        }
       
      }
      
    }
    
  }
}
