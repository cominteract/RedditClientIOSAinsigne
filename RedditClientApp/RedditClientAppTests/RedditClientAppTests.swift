//
//  RedditClientAppTests.swift
//  RedditClientAppTests
//
//  Created by Andre Insigne on 11/10/2019.
//  Copyright © 2019 andreinsigne. All rights reserved.
//

import XCTest

class RedditClientAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        XCTAssert(true == true)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidUrl()
    {
        let validation = Validation()
        XCTAssert(validation.isUrl(text: "http://www.facebook.com"))
    }
    
    func testMethod()
    {
        let method1 = EndPoints.method(endpoint: APIEndpoint.ArticleComments)
        XCTAssert(method1 == "GET")
        let method2 = EndPoints.method(endpoint: APIEndpoint.SubmitLink)
        XCTAssert(method2 == "POST")
    }
    
    func testEndpoints()
    {
        
        let endp1 = EndPoints.endpoint(endpoint: APIEndpoint.Best, input: nil)
        XCTAssert(endp1 == "/best")
        let endp2 = EndPoints.endpoint(endpoint: APIEndpoint.SubmitLink, input: nil)
        XCTAssert(endp2 == "/api/submit")
        let endp3 = EndPoints.endpoint(endpoint: APIEndpoint.Home, input: "/trending")
        XCTAssert(endp3 == "/r/home/trending")
    }

    func testMisc()
    {
        let responses =  Responses()
        XCTAssert(responses.submitSuccess().contains("\"name\":") && responses.submitSuccess().contains("\"data\":") && responses.submitSuccess().contains("\"id\":"))
        let val = responses.submitSuccess()
        let dict = val.toDict(text: val)
        
        if let json = dict?["json"] as? [String : Any?],
            let ddata = json["data"] as? [String : Any?], let url = ddata["url"] as? String
        {
            XCTAssert(url.contains("http"))
        }
        else
        {
            XCTAssert(false)
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
