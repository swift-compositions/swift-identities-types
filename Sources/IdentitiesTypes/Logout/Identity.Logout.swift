//
//  Identity.Logout.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 22/08/2025.
//

import Case_Macro
import Coder
import HTTP
import HTTP_Router

extension Identity {
    /// Namespace for logout functionality.
    ///
    /// Logout handles the termination of user sessions and clearing of authentication tokens.
    public struct Logout: @unchecked Sendable {
        public var client: Identity.Logout.Client

        public init(
            client: Identity.Logout.Client
        ) {
            self.client = client
        }
    }
}
