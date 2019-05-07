import Foundation

public struct GenericError : ErrorBase {
    public var message: String
    public init(_ message: String) {
        self.message = message
    }
    public var description: String {
        return message
    }
}
