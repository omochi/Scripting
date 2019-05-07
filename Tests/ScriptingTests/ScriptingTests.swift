import XCTest
import Scripting

final class ScriptingTests: XCTestCase {
    func test1() throws {
        try system(command: "swift", args: ["--version"])
    }
}
