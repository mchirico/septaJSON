//
//  ExecTimer.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 2/24/19.
//  Copyright © 2019 Michael Chirico. All rights reserved.
//

import Foundation

protocol ExecForTimer {
  func refresh ( completionHandler: @escaping(Int) -> Void)
  var  trainView: TrainView { get }
}

protocol ExecInView {
  func viewExec()
}

extension TVWorker: ExecForTimer {
  
}

class ExecTimer {
  
  var timer: Timer!
  var execForTimer: ExecForTimer
  var view: ExecInView
  
  var count: Int = 0
  var records: TrainView.TV?
  
  init(execForTimer: ExecForTimer, view: ExecInView ) {
    self.execForTimer = execForTimer
    self.view = view
  }
  
  func startTimer() {
    stopTimer()
    timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    timer.fire()
  }
  
  func stopTimer() {
    if timer != nil {
      timer.invalidate()
    }
    timer = nil
  }
  
  @objc func refreshData() {
    self.execForTimer.refresh { result in
      self.count = result
      self.records = self.execForTimer.trainView.records
      self.view.viewExec()
      
    }
  }
  
}
