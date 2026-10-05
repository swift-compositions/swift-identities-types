//
//  Identity Simple Router Tests.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 20/02/2025.
//

import Dependencies
import Dependencies_Test_Support
import EmailAddress
import Testing

@testable import IdentitiesTypes

extension Identity.API {
    @Suite
    struct `API Router Tests` {

        let router = Identity.API.self

        @Test
        func `Creates correct URL for authenticate credentials`() throws {
            let api: Identity.API = .authenticate(
                .credentials(
                    .init(username: "user@example.com", password: "password123")
                )
            )

            let request = try router.request(for: api)
            #expect(request.path == "/authenticate")
            #expect(request.method.rawValue == "POST")

            // Round-trip test
            let match = try router.match(request: request)
            #expect({ if case .authenticate(.credentials) = match { true } else { false } }())
            if case .authenticate(.credentials(let value)) = match {
                #expect(value.username == "user@example.com")
            } else {
                Issue.record("expected authenticate.credentials, got \(match)")
            }
            if case .authenticate(.credentials(let value)) = match {
                #expect(value.password == "password123")
            } else {
                Issue.record("expected authenticate.credentials, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for logout`() throws {
            let api: Identity.API = .logout(.current)

            let request = try router.request(for: api)
            #expect(request.path == "/logout")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .logout(.current) = match { true } else { false } }())
        }
    }
}
