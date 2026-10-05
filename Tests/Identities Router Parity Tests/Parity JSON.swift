import Foundation

/// Re-serializes JSON-object body lines with sorted keys so multi-key
/// `Body(.json(...))` payloads (plain `JSONEncoder()`, unordered keys on
/// Darwin) cannot key-order-flap between runs. Marker: `body(utf8/sorted-keys):`.
/// Sites: MFA JSON bodies (TOTP verify/disable, SMS, Email, WebAuthn,
/// BackupCodes verify).
func sortJSONBodyLines(_ corpus: String) -> String {
    corpus
        .split(separator: "\n", omittingEmptySubsequences: false)
        .map { line -> String in
            let prefix = "body(utf8): {"
            guard line.hasPrefix(prefix) else { return String(line) }
            let json = String(line.dropFirst("body(utf8): ".count))
            guard
                let object = try? JSONSerialization.jsonObject(with: Data(json.utf8)),
                let sorted = try? JSONSerialization.data(
                    withJSONObject: object,
                    options: [.sortedKeys]
                ),
                let text = String(data: sorted, encoding: .utf8)
            else { return String(line) }
            return "body(utf8/sorted-keys): \(text)"
        }
        .joined(separator: "\n")
}
