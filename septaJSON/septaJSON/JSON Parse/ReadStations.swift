//
//  ReadStations.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/5/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

/*
 You get new stations from the following:
 
 https://www3.septa.org/hackathon/Arrivals/station_id_name.csv
 
 */

import Foundation

class ReadStations {
  
  var data:[String]?
  
  func readCSV(){
    if let url = Bundle.main.url(forResource: "stations", withExtension: "csv") {
      
      do {
        let data = try Data(contentsOf: url)
        let t = String(data: data, encoding: .utf8)
        self.data = t?.components(separatedBy: "\n")
        
      } catch {
        print("Error:",error.localizedDescription)
        
      }
      
    }
  }
}
