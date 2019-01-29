import Foundation

// MARK: Mapping operator

precedencegroup MappingPrecedence {
    associativity: right
}

infix operator <- : MappingPrecedence

@discardableResult
public func <-<T> (lhs: inout T, rhs: Any?) -> T {

    guard let _rhs = rhs as? T else {

        return lhs
    }

    lhs = _rhs
    return lhs
}
