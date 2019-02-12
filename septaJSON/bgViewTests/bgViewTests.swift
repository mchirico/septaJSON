//
//  bgViewTests.swift
//  bgViewTests
//
//  Created by Michael Chirico on 11/29/18.
//  Copyright © 2018 Michael Chirico. All rights reserved.
//

import XCTest

class BgC0 {
  private var bgC0: [UIView?] = []
  private var number = 0
  
  init(number: Int) {
    self.number = number
  }
  
  subscript(index: Int) -> UIView? {
    get {
      if number < index && number > 0 {
        return bgC0[index]
      }
      return nil
    }
    set {
      if number < index && number > 0 {
        bgC0[index] = newValue
      }
    }
  }
}

class bgViewTests: XCTestCase {
  
  override func setUp() {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
}
