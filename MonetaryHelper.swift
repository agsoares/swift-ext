import Foundation

extension Double {

    func currency(locale: Locale? = nil) -> String? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = locale ?? Locale.init(identifier: "pt_BR")

        return currencyFormatter.string(from: NSNumber(value: self))
    }
}

extension String {

    func doubleFromCurrency(locale: Locale? = nil) -> Double? {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = locale ?? Locale.init(identifier: "pt_BR")

        let cleanString = self.replacingOccurrences(of: currencyFormatter.currencySymbol, with: "")
                              .trimmingCharacters(in: .whitespaces)
        guard
            let value = Decimal(string: cleanString, locale: locale ?? Locale.init(identifier: "pt_BR"))
        else {
            return nil
        }
        return Double(truncating: value as NSNumber)
    }
}
