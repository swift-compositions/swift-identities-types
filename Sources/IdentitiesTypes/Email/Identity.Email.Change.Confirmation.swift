//
//  File.swift
//  swift-identities-types
//
//  Created by Coen ten Thije Boonkkamp on 11/09/2025.
//

import Case_Macro
import Coder
import HTML_Form_Coder_Codable
import HTTP
import HTTP_Router

extension Identity.Email.Change {
    /// Confirmation data for completing an email change.
    ///
    /// This type represents the final step in the email change flow where
    /// a user confirms their new email address using a verification token.
    public struct Confirmation: Codable, Hashable, Sendable {
        /// The verification token received via email.
        public let token: String

        /// Creates a new email change confirmation.
        ///
        /// - Parameter token: The verification token received via email.
        public init(
            token: String = ""
        ) {
            self.token = token
        }

        /// Keys for coding and decoding Confirmation instances.
        public enum CodingKeys: String, CodingKey {
            case token
        }
    }
}

extension Identity.Email.Change.Confirmation: HTTP.Routable {
    /// Router for handling email change confirmation endpoints.
    ///
    /// Routes POST requests to the "/confirm" path with form-encoded body.
    public static var router: some HTTP.Router.`Protocol`<Identity.Email.Change.Confirmation> {
        Coder::Coder(HTTP.Router.Request.self, HTTP.Router.Request.self) {
            HTTP.Method.post
            HTTP.Segment("confirm")
            HTTP.Body.Coded(
                HTML.Form.Coder.Value(Identity.Email.Change.Confirmation.self, decoder: .identities)
            )
            HTTP.Segment.End()
        }
    }
}

extension Identity.Email.Change.Confirmation {
    /// The response type for a successful email change confirmation.
    ///
    /// This typealias indicates that after confirming an email change,
    /// the user receives a new set of authentication credentials.
    public typealias Response = Identity.Authentication.Response
}
