import UIKit

typealias Constraint = (UIView, UIView) -> NSLayoutConstraint

// MARK: NSLayoutAnchor

func equal<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return equal(to, to, constant: constant)
}

func equal<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], constant: constant)
    }
}

func greaterThanOrEqual<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return greaterThanOrEqual(to, to, constant: constant)
}

func greaterThanOrEqual<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(greaterThanOrEqualTo: view2[keyPath: to], constant: constant)
    }
}

func lessThanOrEqual<L, Axis>(_ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return lessThanOrEqual(to, to, constant: constant)
}

func lessThanOrEqual<L, Axis>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, constant: CGFloat = 0) -> Constraint where L: NSLayoutAnchor<Axis> {
    return { view1, view2 in
        view1[keyPath: from].constraint(lessThanOrEqualTo: view2[keyPath: to], constant: constant)
    }
}

// MARK: NSLayoutDimension

func equal<L>(_ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return equal(to, to, multiplier: multiplier, constant: constant)
}

func equal<L>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return { view1, view2 in
        view1[keyPath: from].constraint(equalTo: view2[keyPath: to], multiplier: multiplier, constant: constant)
    }
}

func greaterThanOrEqual<L>(_ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return greaterThanOrEqual(to, to, multiplier: multiplier, constant: constant)
}

func greaterThanOrEqual<L>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return { view1, view2 in
        view1[keyPath: from].constraint(greaterThanOrEqualTo: view2[keyPath: to], multiplier: multiplier, constant: constant)
    }
}

func lessThanOrEqual<L>(_ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return lessThanOrEqual(to, to, multiplier: multiplier, constant: constant)
}

func lessThanOrEqual<L>(_ from: KeyPath<UIView, L>, _ to: KeyPath<UIView, L>, multiplier: CGFloat = 1, constant: CGFloat = 0) -> Constraint where L: NSLayoutDimension {
    return { view1, view2 in
        view1[keyPath: from].constraint(lessThanOrEqualTo: view2[keyPath: to], multiplier: multiplier, constant: constant)
    }
}

func equal<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(equalToConstant: constant)
    }
}

func greaterThanOrEqual<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(greaterThanOrEqualToConstant: constant)
    }
}

func lessThanOrEqual<L>(_ keyPath: KeyPath<UIView, L>, constant: CGFloat) -> Constraint where L: NSLayoutDimension {
    return { view1, _ in
        view1[keyPath: keyPath].constraint(lessThanOrEqualToConstant: constant)
    }
}

extension UIView {
    func addSubview(_ other: UIView, constraints: [Constraint]) {
        other.translatesAutoresizingMaskIntoConstraints = false
        addSubview(other)
        addConstraints(constraints.map { $0(other, self) })
    }
}
