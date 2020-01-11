//
//  BaseMockService.swift
//  Rock-TracksTests
//
//  Created by Rufus on 11/01/2020.
//  Copyright © 2020 Rufus. All rights reserved.
//

import Foundation
@testable import Rock_Tracks

public class BaseMockService {
    
    private var numAttemptsBeforeError: Int
    
    public init(forceErrorAfterNAttempts: Int = -1) {
        self.numAttemptsBeforeError = forceErrorAfterNAttempts
    }
    
    internal typealias ResultFunc<T> = (Result<T,Error>) -> ()
    
    internal func loadFromBundledJson<T: Decodable>(named: String, withExtension ext: String) -> T {
        let url = Bundle(for: BaseMockService.self).url(forResource: named, withExtension: ext)!
        let testData = try! Data(contentsOf: url)
        let jsonDecoder = JSONDecoder()
        let result = try! jsonDecoder.decode(T.self, from: testData)
            return result
    }
    
    internal func executeCompletionOrSimulateError<T>(object: T, completion:@escaping ResultFunc<T>) {
        let delay = 0.5
        if numAttemptsBeforeError == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { completion(.failure(WebClient.WebClientError.webResponseCodeError)) }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) { completion(.success(object)) }
        }
        numAttemptsBeforeError -= 1
    }
}
