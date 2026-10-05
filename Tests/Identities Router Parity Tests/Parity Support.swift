//
//  Parity Support.swift
//  swift-identities-types
//
//  Batch-0 wire-shape parity corpus support (url-routing-stack migration).
//

import Byte
import HTTP
import HTTP_Router
import IdentitiesTypes
import RFC_3986
import RFC_9110
import Testing

/// Compares a generated corpus against its Swift-embedded reference document.
func assertParity(
    _ corpus: String,
    fixture name: String
) throws {
    let actual = sortJSONBodyLines(corpus)
    guard let expected = ParityCorpus[name] else {
        Issue.record("No Swift-embedded parity corpus named \(name)")
        return
    }
    guard actual != expected else { return }
    let report = difference(expected: expected, actual: actual)
    Issue.record(Comment(rawValue: "Parity mismatch for \(name):\n\(report)"))
}

private func difference(expected: String, actual: String) -> String {
    let expectedLines = expected.split(separator: "\n", omittingEmptySubsequences: false)
    let actualLines = actual.split(separator: "\n", omittingEmptySubsequences: false)
    var differences: [String] = []
    for index in 0..<max(expectedLines.count, actualLines.count) {
        let expected = index < expectedLines.count ? expectedLines[index] : "<absent>"
        let actual = index < actualLines.count ? actualLines[index] : "<absent>"
        if expected != actual {
            differences.append("line \(index + 1):\n  - \(expected)\n  + \(actual)")
        }
        if differences.count >= 40 {
            differences.append("… (further differences truncated)")
            break
        }
    }
    return differences.joined(separator: "\n")
}

enum Parity {
    static func corpus<Route: HTTP.Routable>(
        of routes: [(name: String, route: Route)],
        via _: Route.Type
    ) throws -> String where Route.Router.Output == Route {
        try routes.map { name, route in
            try block(name, HTTP.request(Route.self, for: route))
        }.joined(separator: "\n\n") + "\n"
    }

    static func roundTrips<Route: HTTP.Routable & Equatable>(
        _ route: Route,
        via _: Route.Type
    ) throws -> Bool where Route.Router.Output == Route {
        try HTTP.route(Route.self, HTTP.request(Route.self, for: route)) == route
    }

    private static func block(_ name: String, _ request: HTTP.Router.Request) -> String {
        var lines = ["== \(name) ==", "method: \(request.method.rawValue)"]
        if case .resource(let uri) = request.target {
            lines.append("path: \(uri.path?.description ?? "")")
            for parameter in uri.query?.parameters ?? [] {
                let key = decoded(parameter.key)
                lines.append("query: " + (parameter.value.map { "\(key)=\(decoded($0))" } ?? key))
            }
        } else {
            lines.append("path: <none>")
        }
        for field in request.headers {
            lines.append("header: \(field.name.rawValue.lowercased()): \(field.value.rawValue)")
        }
        lines.append(
            request.content.map {
                "body(utf8): " + String(decoding: $0.map(\.bitPattern), as: UTF8.self)
            }
                ?? "body: <nil>"
        )
        return lines.joined(separator: "\n")
    }

    private static func decoded(_ raw: String) -> String {
        String(decoding: RFC_3986.percentDecode(Array(raw.utf8)), as: UTF8.self)
    }
}
