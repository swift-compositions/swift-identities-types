//
//  Identity.MFA.Verify.API.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 21/08/2025.
//

import Case_Macro
import Coder
import Foundation
import HTML_Form_Coder_Codable
import HTTP
import HTTP_Router

extension Identity.MFA {
    /// General MFA verification request during login.
    ///
    /// This endpoint handles MFA challenges after initial authentication.
    /// The client sends the session token received during login along with
    /// the verification code from their chosen MFA method.
    public struct Verify: Codable, Equatable, Sendable {
        /// Session token from the MFA challenge
        public let sessionToken: String

        /// MFA method to use for verification
        public let method: Identity.MFA.Method

        /// Verification code (e.g., TOTP code, SMS code, backup code)
        public let code: String

        public init(
            sessionToken: String,
            method: Identity.MFA.Method,
            code: String
        ) {
            self.sessionToken = sessionToken
            self.method = method
            self.code = code
        }
    }
}

extension Identity.MFA.Verify: HTTP.Routable {
    /// Router for the MFA verify endpoint.
    public static var router: some HTTP.Router.`Protocol`<Identity.MFA.Verify> {
        Coder::Coder(HTTP.Router.Request.self, HTTP.Router.Request.self) {
            HTTP.Method.post
            HTTP.Body.Coded(HTML.Form.Coder.Value(Identity.MFA.Verify.self, decoder: .identities))
            HTTP.Segment.End()
        }
    }
}
