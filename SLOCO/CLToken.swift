import Foundation

class CLToken {
    var displayText: String!
    var context:AnyObject?
}

extension CLToken: Equatable {}

func ==(lhs: CLToken, rhs: CLToken) -> Bool {
    if lhs.displayText == rhs.displayText && lhs.context?.isEqual(rhs.context) == true {
        return true
    }
    return false
}