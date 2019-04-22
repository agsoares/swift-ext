import UIKit

class KeyboardObserver {

    typealias ConstraintObserver = (
        constraint: NSLayoutConstraint,
        noKeyboardConst: CGFloat,
        keyboardConst: CGFloat
    )

    private static var instance = KeyboardObserver()
    private var observers: [ConstraintObserver] = []

    private init() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardObserver.keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardObserver.keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    static func addConstraint(_ constraint: NSLayoutConstraint,
                              noKeyboardConst: CGFloat,
                              keyboardConst: CGFloat? = nil) {

        let constraint = ConstraintObserver(
            constraint: constraint,
            noKeyboardConst: noKeyboardConst,
            keyboardConst: keyboardConst ?? noKeyboardConst
        )

        instance.observers.append(constraint)
    }

    static func removeConstraint(_ constraint: NSLayoutConstraint) {

        instance.observers = instance.observers.filter({ $0.constraint != constraint })
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard
            let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height,
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else {
            return
        }

        observers.forEach { observer in
            UIView.animate(withDuration: animationDuration) {
                observer.constraint.constant = -(keyboardHeight + observer.keyboardConst)
                (observer.constraint.firstItem as? UIView)?.superview?.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        observers.forEach { observer in
            UIView.animate(withDuration: animationDuration) {
                observer.constraint.constant = -(observer.noKeyboardConst)
                (observer.constraint.firstItem as? UIView)?.superview?.layoutIfNeeded()
            }
        }
    }
}
