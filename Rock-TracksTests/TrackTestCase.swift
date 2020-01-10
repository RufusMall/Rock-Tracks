//
//  TrackTestCase.swift
//  Rock-TracksTests
//
//  Created by Rufus on 10/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
import XCTest
import Rock_Tracks

class TrackTestCase: XCTestCase {
    let testEnviornment = Environment.dev
}

extension XCTestCase {
    
    /// create an expectation witth a description. Defaultst to calling function name.
    /// In the logs this makes it easy to match failing expectations to tests
    /// - Parameter callingMethod: the description to use. This will default to the calling method if ommited
     func expectation(callingMethod: String = #function) -> XCTestExpectation {
        return self.expectation(description:"TestName:" + callingMethod)
    }
}
