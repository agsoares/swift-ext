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

// MARK: Composition operator

precedencegroup SingleTypeComposition {
    associativity: left
}

infix operator <>: SingleTypeComposition

public func <> <A: AnyObject>(f: @escaping (A) -> Void, g: @escaping (A) -> Void) -> (A) -> Void {
    return { a in
        f(a)
        g(a)
    }
}
