//
//  TextAnalysisInteractorTests.swift
//  NewlyTests
//
//  Created by Ikmal Azman on 29/10/2021.
//

import XCTest
@testable import Newly

class TextAnalysisInteractorTests: XCTestCase {

    let sut = TextAnalysisInteractor()
    
    func testTextPredictions() {
        let result = sut.predictText("Liverpool lost against barcelona")
        XCTAssertEqual(result?.capitalized, "Sport")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
//https://developer.apple.com/library/archive/documentation/DeveloperTools/Conceptual/testing_with_xcode/chapters/05-running_tests.html
