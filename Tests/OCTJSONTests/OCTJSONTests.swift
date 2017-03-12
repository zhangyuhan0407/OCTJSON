import XCTest
@testable import OCTJSON

class OCTJSONTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(OCTJSON().text, "Hello, World!")
    }


    static var allTests : [(String, (OCTJSONTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
