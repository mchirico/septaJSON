//
//  JSONdecode.swift
//  septaJSON
//
//  Created by Michael Chirico on 10/5/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//
/*
 https://www3.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=40
 */

import Foundation

protocol SeptaJSON {
  func getURL(url: String)
  func parseString(data: String)
}

class Travel {
  let sts = [StationToStation(), StationToStation()]
  let recTimer = [RecTimer(), RecTimer()]
  let trainView = TrainView()
  let stationArrival = StationArrival()
  
  // Currently onluy using Suburban
  var station_url = "https://www3.septa.org/hackathon/Arrivals/Suburban%20Station/15/"
  var trainView_url = "https://www3.septa.org/hackathon/TrainView/"
  var url0 = "https://www3.septa.org/hackathon/NextToArrive/?req1=Elkins%20Park&req2=Suburban%20Station&req3=14"
  var url1 = "https://www3.septa.org/hackathon/NextToArrive/?req1=Suburban%20Station&req2=Elkins%20Park&req3=14"
    
  init(trainView_url: String, url0: String, url1: String, station_url: String) {
    self.trainView_url = trainView_url
    self.url0 = url0
    self.url1 = url1
    self.station_url = station_url
    refresh()
  }
  
  init() {
    refresh()
  }
  
  func refresh() {
    
    stationArrival.getURL(url: station_url)
    stationArrival.parseString(data: stationArrival.urlResults)
    
    trainView.getURL(url: trainView_url)
    trainView.parseString(data: trainView.urlResults)
    
    sts[0].getURL(url: url0)
    sts[0].parseString(data: sts[0].urlResults)
    
    recTimer[0].stringTime(s: (sts[0].records?.sts[0].orig_departure_time)!)
    
    sts[1].getURL(url: url1)
    sts[1].parseString(data: sts[1].urlResults)
    
    recTimer[1].stringTime(s: (sts[1].records?.sts[0].orig_departure_time)!)
  }
  
  func nextStations() -> String {
    var nextStationNorth = ""
    var nextStationSouth = ""
    
    if let trainno = sts[0].records?.sts[0].orig_train {
      nextStationSouth = self.nextStationSouth(trainno: trainno)
    }
    
    if let trainno = sts[1].records?.sts[0].orig_train {
      nextStationNorth = self.nextStationNorth(trainno: trainno)
    }
    
    return " \(nextStationSouth) ,\t \(nextStationNorth)"
  }
  
  func nextStationNorth(trainno: String) -> String {
    if let trains_N = stationArrival.records?.sa?[0].Northbound {
      for train in trains_N {
        if trainno == train.train_id {
          if let station = train.next_station {
            return station
          }
        }
      }
    }
    return ""
  }
  
  func nextStationSouth(trainno: String) -> String {
    if let trains_N = stationArrival.records?.sa?[1].Southbound {
      for train in trains_N {
        if trainno == train.train_id {
          if let station = train.next_station {
            return station
          }
        }
      }
    }
    return ""
  }
  
  func plannedTrackNorth(trainno: String) -> String {
    if let trains_N = stationArrival.records?.sa?[0].Northbound {
      for train in trains_N {
        if trainno == train.train_id {
          if let track = train.track {
            if let platform = train.platform {
              return "\(track)\(platform)"
            }
            return track
          }
        }
      }
    }
    return ""
  }
  
  // This is from train view.. while arriving at station
  func track(trainno: String, nextstop: String) -> String {
    if let records = trainView.records {
      for train in records.tv {
        if trainno == train.trainno && nextstop == train.nextstop {
          return train.TRACK
        }
      }
    }
    return ""
  }
  
  func getMinutes() -> [Int] {
    
    var min0 = 3600
    var min1 = 3600
    
    if recTimer[0].hours == 0 {
      recTimer[0].delay(s: (sts[0].records?.sts[0].orig_delay))
      min0 = recTimer[0].minutes
    }
    
    if recTimer[1].hours == 0 {
      recTimer[1].delay(s: (sts[1].records?.sts[0].orig_delay))
      min1 = recTimer[1].minutes
    }
    
    return [min0, min1]
    
  }
  
  func count(index: Int) -> Int {
    if let count = sts[index].records?.sts.count {
      return count
    }
    return 0
    
  }
  
  func msg(index: Int, row: Int) -> String {
    if let depart = sts[index].records?.sts[row].orig_departure_time,
      let train = sts[index].records?.sts[row].orig_train,
      let delay = sts[index].records?.sts[row].orig_delay {
      
      let txt = "\(train) \t \(depart) \t \(delay)"
      
      return txt
    }
    return "No data"
  }
  
  // TODO: Next
  func msgTrack(index: Int, row: Int, nextstop: String) -> String {
    if let depart = sts[index].records?.sts[row].orig_departure_time,
      let train = sts[index].records?.sts[row].orig_train,
      let delay = sts[index].records?.sts[row].orig_delay,
      let orig_arrive = sts[index].records?.sts[row].orig_arrival_time {
      
      if row == 0 {
        let track = self.track(trainno: train, nextstop: "Suburban Station")
        if track != "" {
          
          return "\(train) \t \(depart) \t \(delay) \t *\(track)* \t\(orig_arrive)"
        }
      }
      
      let track = plannedTrackNorth(trainno: train)
      
      let txt = "\(train) \t \(depart) \t \(delay) \t \(track) \t\(orig_arrive)"
      return txt
    }
    return "No data"
  }
  
}

class StationToStation: SeptaJSON {
  
  struct S2S: Decodable {
    let sts: [Trains]
  }
  
  struct Trains: Decodable {
    let orig_train: String
    let orig_line: String
    let orig_departure_time: String
    let orig_arrival_time: String
    let orig_delay: String
    let isdirect: String
  }
  
  var urlResults: String = ""
  var records: S2S?
  
  func getURL(url: String) {
    let r = Request()
    r.getURL(url: url)
    
    urlResults = String(r.contents)
    
    let startOfpt = urlResults.startIndex
    
    if let endOfpt = urlResults.firstIndex(of: "[") {
      
      urlResults.replaceSubrange(startOfpt..<endOfpt, with: "{\"sts\":")
      urlResults += "}"
      
    }
  }
  
  func parseString(data: String) {
    
    do {
      self.records = try JSONDecoder().decode(S2S.self, from: data.data(using: .utf8)!)
      
    } catch {
      print("Error (StationToStation):", error.localizedDescription)
    }
    
  }
  
}
