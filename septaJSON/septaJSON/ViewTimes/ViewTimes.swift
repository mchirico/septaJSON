//
//  ViewTimes.swift
//  SeptaJSON
//
//  Created by Michael Chirico on 10/14/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import UIKit

class ViewTimes: UIViewController {
  
  @IBOutlet weak var tableView0: UITableView!
  
  @IBOutlet weak var tableView1: UITableView!
  
  @IBOutlet weak var label0: UILabel!
  
  
  let travel = Travel()
  
  
  var timer: Timer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    delegates()
    startTimer()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    stopTimer()
  }
  
  
  
  func delegates() {
    tableView0.delegate = self
    tableView1.delegate = self
    
    tableView0.dataSource = self
    tableView1.dataSource = self
  }
  
  
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(refreshData), userInfo: nil, repeats: true)
    timer.fire()
  }
  
  func stopTimer() {
    timer.invalidate()
    timer = nil
  }
  
  
  @objc func refreshData() {
    
    travel.refresh()
    tableView0.reloadData()
    tableView1.reloadData()
    
    print("update timer\n")
    
    label0.text = "\(travel.getMinutes())"
    
    
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension ViewTimes: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    print("\n*****\nhere\n\n\n")
    
    if tableView == tableView0 {
      return travel.count(index: 0)
    }
    
    if tableView == tableView1 {
      return travel.count(index: 1)
    }
    
    return 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    if tableView == tableView0 {
      
      if let cell = tableView.dequeueReusableCell(withIdentifier: "cell0") {
        
        let bgView: UIView = UIView(frame: CGRect(x: 2, y: 0, width: cell.bounds.width - 4, height: (cell.bounds.height)-2))
        
        bgView.backgroundColor = UIColor.gray
        bgView.layer.borderWidth = 3
        bgView.alpha = 1
        bgView.layer.cornerRadius = 9
        bgView.tag = 100
        
        bgView.center.x -=  view.bounds.width
        
        let label = UILabel(frame: CGRect(x:0, y:10, width:200, height:15))
        //label.center = CGPointMake(160, 284)
        label.textAlignment = NSTextAlignment.center
        
        label.textColor = UIColor.black
        label.backgroundColor = UIColor.clear
        label.alpha = 10
        
        label.text = travel.msg(index: 0,row: indexPath.row)
        
        if travel.getMinutes()[0] < 6 && indexPath.row == 0 {
          if travel.getMinutes()[0] < 4 {
            bgView.backgroundColor = UIColor.red
          } else {
            bgView.backgroundColor = UIColor.green
          }
        } else {
          bgView.backgroundColor = UIColor.lightGray
        }
        
        //label.text = "title: \(indexPath.row)"
        label.tag = 101
        label.font  = UIFont(name: "Avenir", size: 17.0)
        
        bgView.addSubview(label)
        
        cell.addSubview(bgView)
        
        UIView.animate(withDuration: 0.5) {
          bgView.center.x += self.view.bounds.width
        }
        return cell
      }
      
    }
    
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
    
    
    let bgView: UIView = UIView(frame: CGRect(x: 15, y: 0, width: cell!.bounds.width - 20, height: 40))
    
    bgView.backgroundColor = UIColor.green
    bgView.layer.borderWidth = 1
    bgView.alpha = 1
    bgView.layer.cornerRadius = 9
    
    bgView.tag = 100
    
    bgView.center.x -=  view.bounds.width
    
    let bgViewM: UIView = UIView(frame: CGRect(x: 20, y: 3.4, width: 190, height: 29))
    
    bgViewM.backgroundColor = UIColor.white
    bgViewM.layer.borderWidth = 1
    bgViewM.alpha = 1
    bgViewM.layer.cornerRadius = 9
    bgViewM.tag = 300
    
    let label = UILabel(frame: CGRect(x:10, y:10, width:180, height:15))
    
    label.textAlignment = NSTextAlignment.center
    
    label.textColor = UIColor.black
    label.backgroundColor = UIColor.clear
    label.alpha = 10
    
    label.text = travel.msg(index: 1,row: indexPath.row)
    
    if travel.getMinutes()[1] < 6 && indexPath.row == 0 {
      if travel.getMinutes()[1] < 4 {
        bgView.backgroundColor = UIColor.red
      } else {
        bgView.backgroundColor = UIColor.green
      }
    } else {
      bgView.backgroundColor = UIColor.lightGray
    }
    
    print("\n\nWHAT\n")
    print(travel.getMinutes()[1])
    
    
    label.tag = 102
    label.font  = UIFont(name: "Avenir", size: 17.0)
    
    
    bgViewM.addSubview(label)
    bgView.addSubview(bgViewM)
    
    UIView.animate(withDuration: 0.5) {
      bgView.center.x += self.view.bounds.width
    }
    
    cell!.addSubview(bgView)
    
    return cell!
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    print("seleced")
  }
  
  
  
}





