//
//  TrainViewReport.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/19/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import Foundation

class TrainViewReport {

  var refreshStation: NetworkRefresh<StationArrival.SA>?
  var refreshTrainView: NetworkRefresh<TrainView.TV>?
  
  func refresh(trainno: String, station: String,
               completionHandler:
               @escaping([StationArrival.Arrival], [TrainView.Trains]) -> Void) {
    
    if let rS = refreshStation, let rTV = refreshTrainView {
      rS.refresh { resultS in
        
        rTV.refresh { resultTV in
          
          completionHandler(resultS!.sa!, resultTV!.tv)
      }
    }
    
  }
}
}
