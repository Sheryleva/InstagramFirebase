//
//  ProjectFirebaseTests.swift
//  ProjectFirebaseTests
//
//  Created by Sheryl Evangelene Pulikandala on 8/12/20.
//  Copyright © 2020 Sheryl Evangelene Pulikandala. All rights reserved.
//

import XCTest
@testable import ProjectFirebase

class iGramTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFirebaseManagerInstance(){
        let instance = FirebaseManager.shared
        XCTAssertNotNil(instance)
    }
    
    func testgetAllPosts(){
      let testExpectation = expectation(description: "We should get successful response with the Dictionary of Post")
        FirebaseManager.shared.getAllPosts() { (snapshot) in
            testExpectation.fulfill()
            
        }
      wait(for: [testExpectation], timeout: 20)
    }

    func testgetUsersPosts(){
          let testExpectation = expectation(description: "We should get successful response with the Dictionary of Post")
        FirebaseManager.shared.getUsersPosts() { (snapshot) in
//                let value = snapshot.value as? NSDictionary
//                if value == nil{
//                    XCTFail("Test Failed")
//                }
                testExpectation.fulfill()

            }
          wait(for: [testExpectation], timeout: 20)
        }

    

}
