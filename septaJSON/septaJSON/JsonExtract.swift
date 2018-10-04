//
//  JsonExtract.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/4/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import Foundation

class ParseDeparture {
  
  
  struct AA:Decodable {
    let A:[One]
  }
  
  struct One:Decodable {
    let one:[Stage2]?
    let two:[Stage2]?
  }
  
  struct Stage2:Decodable {
    let id:String?
    let m:String?
  }
  
  
  struct DepartListing:Decodable {
    let depart:[Departures]
    
    private enum CodingKeys: String, CodingKey {
      case depart = "Depart"
    }
  }
  
  struct Departures:Decodable {
    let Northbound:[Train]?
    let Southbound:[Train]?
    
    
  }
  
  
  struct Train:Decodable {
    let direction:String?
    let path:String?
    let train_id:String?
    let origin:String?
    let destination:String?
    let line:String?
    let status:String?
    let service_type:String?
    let next_station:String?
    let sched_time:String?
    let depart_time:String?
    let track:String?
    let track_change:String?
    let platform:String?
    let platform_change:String?
  }
  
  
  private var departListing:DepartListing?
  private var alisting:AA?
  
  
  func parseJSONT() {
    
    if let url = Bundle.main.url(forResource: "a", withExtension: "txt") {
      
      do {
        let data = try Data(contentsOf: url)
        
        
        self.alisting = try JSONDecoder().decode(AA.self, from: data)
        
        if let alisting = self.alisting {
          print(alisting.A[1].two ?? "none")
        }
      } catch {
        print("Error:",error.localizedDescription)
      }
    }
  }
  
  
  func parseJSON() {
    
    if let url = Bundle.main.url(forResource: "depart", withExtension: "json") {
      
      do {
        let data = try Data(contentsOf: url)
        self.departListing = try JSONDecoder().decode(DepartListing.self, from: data)
        
        if let departListing = self.departListing {
          print(departListing.depart[0].Northbound?[0] ?? "none")
        }
      } catch {
        print("Error:",error.localizedDescription)
      }
    }
  }
  
  
}
