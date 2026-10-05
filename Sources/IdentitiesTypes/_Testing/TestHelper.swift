//
//  File.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 20/02/2025.
//

import Dependencies
import Foundation

extension Identity._TestDatabase {
    package struct Helper {
        package static let enabled: Bool = true
        /// Creates an isolated test environment for each test
        package static func withIsolatedDatabase<Failure: Swift.Error>(
            _ operation: @escaping () async throws(Failure) -> Void
        ) async throws(Failure) {
            if enabled {
                let database = Identity._TestDatabase()
                try await withDependencies { (values: inout __DependencyValues) throws(Failure) in
                    values[Identity._TestDatabase.self] = database
                    values[Identity.self] = .testValue
                } operation: { () async throws(Failure) in
                    try await operation()
                }
            } else {
                try await operation()
            }
        }
    }
}
