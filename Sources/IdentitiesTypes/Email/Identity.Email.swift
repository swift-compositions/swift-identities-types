//
//  Identity.Email.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 18/02/2025.
//

import Case_Macro
import Coder
import HTTP
import HTTP_Router

extension Identity {
    /// Namespace for email-related functionality within the Identity system.
    public struct Email: @unchecked Sendable {
        public var change: Identity.Email.Change

        public init(
            change: Identity.Email.Change
        ) {
            self.change = change
        }
    }
}
