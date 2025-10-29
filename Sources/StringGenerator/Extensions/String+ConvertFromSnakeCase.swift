import Foundation

extension String {
    fileprivate static let invalidKeyCharacters = CharacterSet.alphanumerics.inverted

    /// Converts snake case joins to camel case joins
    func snakeCaseConverted(_ convert: Bool) -> String {
        convertFromSnakeCase(self)
    }
    
    var uppercasingFirst: String {
        return prefix(1).uppercased() + dropFirst().lowercased()
    }

    var lowercasingFirst: String {
        return lowercased()
    }

    var camelized: String {
        guard !isEmpty else {
            return ""
        }
        
        let parts = self.components(separatedBy: Self.invalidKeyCharacters)
        let first = String(describing: parts.first!).lowercasingFirst
        let rest = parts.dropFirst().map({ String($0).uppercasingFirst })

        return ([first] + rest).joined(separator: "")
    }
    
    var stripSnakeCase: String {
        return replacingOccurrences(of: "_", with: " ").lowercased()
    }
}

// From: https://github.com/swiftlang/swift-foundation/blob/4d74f7a425b3edb48ebec04105a06eb99771a519/Sources/FoundationEssentials/JSON/JSONDecoder.swift#L121-L165
// Modified to assume components separated by underscore is already camel case
fileprivate func convertFromSnakeCase(_ stringKey: String) -> String {
    guard !stringKey.isEmpty, stringKey.contains("_") else { return stringKey }
    
    let sanitizedKey: String = stringKey
        .stripSnakeCase
        .camelized
    
    return sanitizedKey
}
