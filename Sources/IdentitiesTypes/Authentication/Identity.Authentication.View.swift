//
//  Identity.Authentication.Route.swift
//  swift-identities
//
//  Feature-based routing for Authentication functionality
//

import Case_Macro
import Coder
import HTTP
import HTTP_Router

extension Identity.Authentication {
    /// View routes for authentication pages.
    ///
    /// Provides frontend routes for different authentication methods.
    @Prisms
    @Folds
    @Cases
    public enum View: Sendable, Hashable, Codable {
        /// Credentials-based login page (username/password)
        case credentials

        // Future authentication methods can be added here:
        // case oauth(provider: OAuthProvider)
        // case sso
        // case passwordless
    }
}

extension Identity.Authentication.View: HTTP.Routable {
    /// Router for authentication view endpoints.
    ///
    /// Maps view routes to their URL paths:
    /// - Credentials: `/login` or `/credentials` (both map to same page)
    public static var router: some HTTP.Router.`Protocol`<Identity.Authentication.View> {
        Coder::Case(Self.cases.credentials.prism, Self.cases.credentials.fold, absent: .mismatch) {
            HTTP.Method.get
            HTTP.Segment("login")
            HTTP.Segment.End()
        }
        Coder::Case(Self.cases.credentials.prism, Self.cases.credentials.fold, absent: .mismatch) {
            HTTP.Method.get
            HTTP.Segment("credentials")
            HTTP.Segment.End()
        }
    }
}
