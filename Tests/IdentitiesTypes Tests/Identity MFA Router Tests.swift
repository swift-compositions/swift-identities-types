//
//  Identity MFA Router Tests Fixed.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 20/02/2025.
//

import Dependencies
import Dependencies_Test_Support
import EmailAddress
import Testing

@testable import IdentitiesTypes

extension Identity.MFA.API {
    @Suite
    struct `MFA API Router Tests` {

        let router = Identity.MFA.API.self

        @Test
        func `Creates correct URL for MFA status get`() throws {
            let mfa: Identity.MFA.API = .status(.get)

            let request = try router.request(for: mfa)
            #expect(request.path == "/status")
            #expect(request.method.rawValue == "GET")

            let match = try router.match(request: request)
            #expect({ if case .status(.get) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA status challenge`() throws {
            let mfa: Identity.MFA.API = .status(.challenge)

            let request = try router.request(for: mfa)
            #expect(request.path == "/status/challenge")
            #expect(request.method.rawValue == "GET")

            let match = try router.match(request: request)
            #expect({ if case .status(.challenge) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA TOTP setup`() throws {
            let mfa: Identity.MFA.API = .totp(.setup)

            let request = try router.request(for: mfa)
            #expect(request.path == "/totp/setup")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .totp(.setup) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA TOTP verification`() throws {
            let verifyRequest = Identity.MFA.TOTP.Verify(
                code: "123456",
                sessionToken: "session-token"
            )
            let mfa: Identity.MFA.API = .totp(.verify(verifyRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/totp/verify")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .totp(.verify) = match { true } else { false } }())
            if case .totp(.verify(let value)) = match {
                #expect(value.code == "123456")
            } else {
                Issue.record("expected totp.verify, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA TOTP disable`() throws {
            let disableRequest = Identity.MFA.DisableRequest(reauthorizationToken: "reauth-token")
            let mfa: Identity.MFA.API = .totp(.disable(disableRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/totp/disable")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .totp(.disable) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA SMS setup`() throws {
            let setupRequest = Identity.MFA.SMS.Setup(phoneNumber: "+1234567890")
            let mfa: Identity.MFA.API = .sms(.setup(setupRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/sms/setup")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .sms(.setup) = match { true } else { false } }())
            if case .sms(.setup(let value)) = match {
                #expect(value.phoneNumber == "+1234567890")
            } else {
                Issue.record("expected sms.setup, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA SMS verification`() throws {
            let verifyRequest = Identity.MFA.SMS.Verify(
                code: "123456",
                sessionToken: "session-token"
            )
            let mfa: Identity.MFA.API = .sms(.verify(verifyRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/sms/verify")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .sms(.verify) = match { true } else { false } }())
            if case .sms(.verify(let value)) = match {
                #expect(value.code == "123456")
            } else {
                Issue.record("expected sms.verify, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA SMS request code`() throws {
            let mfa: Identity.MFA.API = .sms(.requestCode)

            let request = try router.request(for: mfa)
            #expect(request.path == "/sms/request")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .sms(.requestCode) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA SMS disable`() throws {
            let disableRequest = Identity.MFA.DisableRequest(reauthorizationToken: "reauth-token")
            let mfa: Identity.MFA.API = .sms(.disable(disableRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/sms/disable")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .sms(.disable) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA Email setup`() throws {
            let setupRequest = Identity.MFA.Email.Setup(email: "mfa@example.com")
            let mfa: Identity.MFA.API = .email(.setup(setupRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/email/setup")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .email(.setup) = match { true } else { false } }())
            if case .email(.setup(let value)) = match {
                #expect(value.email == "mfa@example.com")
            } else {
                Issue.record("expected email.setup, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA Email verification`() throws {
            let verifyRequest = Identity.MFA.Email.Verify(
                code: "123456",
                sessionToken: "session-token"
            )
            let mfa: Identity.MFA.API = .email(.verify(verifyRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/email/verify")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .email(.verify) = match { true } else { false } }())
            if case .email(.verify(let value)) = match {
                #expect(value.code == "123456")
            } else {
                Issue.record("expected email.verify, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA Email request code`() throws {
            let mfa: Identity.MFA.API = .email(.requestCode)

            let request = try router.request(for: mfa)
            #expect(request.path == "/email/request")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .email(.requestCode) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA Email disable`() throws {
            let disableRequest = Identity.MFA.DisableRequest(reauthorizationToken: "reauth-token")
            let mfa: Identity.MFA.API = .email(.disable(disableRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/email/disable")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .email(.disable) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA Backup Codes regenerate`() throws {
            let mfa: Identity.MFA.API = .backupCodes(.regenerate)

            let request = try router.request(for: mfa)
            #expect(request.path == "/backup-codes/regenerate")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .backupCodes(.regenerate) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA Backup Codes verify`() throws {
            let verifyRequest = Identity.MFA.BackupCodes.Verify(
                code: "backup-code-123",
                sessionToken: "session-token"
            )
            let mfa: Identity.MFA.API = .backupCodes(.verify(verifyRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/backup-codes/verify")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .backupCodes(.verify) = match { true } else { false } }())
            if case .backupCodes(.verify(let value)) = match {
                #expect(value.code == "backup-code-123")
            } else {
                Issue.record("expected backupCodes.verify, got \(match)")
            }
        }

        @Test
        func `Creates correct URL for MFA Web Authn begin registration`() throws {
            let mfa: Identity.MFA.API = .webauthn(.beginRegistration)

            let request = try router.request(for: mfa)
            #expect(request.path == "/webauthn/register/begin")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .webauthn(.beginRegistration) = match { true } else { false } }())
        }

        @Test
        func `Creates correct URL for MFA Web Authn disable`() throws {
            let disableRequest = Identity.MFA.DisableRequest(reauthorizationToken: "reauth-token")
            let mfa: Identity.MFA.API = .webauthn(.disable(disableRequest))

            let request = try router.request(for: mfa)
            #expect(request.path == "/webauthn/disable")
            #expect(request.method.rawValue == "POST")

            let match = try router.match(request: request)
            #expect({ if case .webauthn(.disable) = match { true } else { false } }())
        }
    }
}
