//
//  File.swift
//  swift-identities-types
//
//  Created by Coen ten Thije Boonkkamp on 30/08/2025.
//

import Case_Macro
import Coder
import Foundation
import HTTP
import HTTP_Router
import Tagged

extension Identity {
    public typealias ID = Tagged<Identity, UUID>
}
