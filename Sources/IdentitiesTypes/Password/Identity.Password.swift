//
//  Identity.Password.swift
//  swift-identities
//
//  Created by Coen ten Thije Boonkkamp on 28/01/2025.
//

import Case_Macro
import Coder
import HTTP
import HTTP_Router

extension Identity {
    /// Namespace for password-related functionality within the Identity system.
    public struct Password: @unchecked Sendable {
        public var change: Identity.Password.Change
        public var reset: Identity.Password.Reset

        public init(
            change: Identity.Password.Change,
            reset: Identity.Password.Reset
        ) {
            self.change = change
            self.reset = reset
        }
    }
}
