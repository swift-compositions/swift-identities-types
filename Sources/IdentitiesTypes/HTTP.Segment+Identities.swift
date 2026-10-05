public import HTTP
public import HTTP_Router

extension HTTP.Segment {

    public static var request: Self { Self("request") }

    public static var api: Self { Self("api") }

    public static var apiKey: Self { Self("api-key") }

    public static var verify: Self { Self("verify") }

    public static var refresh: Self { Self("refresh") }

    public static var access: Self { Self("access") }

    public static var cancel: Self { Self("cancel") }

    public static var confirm: Self { Self("confirm") }

    public static var reauthorization: Self { Self("reauthorization") }

    public static var reauthorize: Self { Self("reauthorize") }

    public static var create: Self { Self("create") }

    public static var authenticate: Self { Self("authenticate") }

    public static var update: Self { Self("update") }

    public static var delete: Self { Self("delete") }

    public static var login: Self { Self("login") }

    public static var credentials: Self { Self("credentials") }

    public static var logout: Self { Self("logout") }

    public static var password: Self { Self("password") }

    public static var email: Self { Self("email") }

    public static var change: Self { Self("change") }

    public static var verification: Self { Self("verification") }

    public static var reset: Self { Self("reset") }

    public static var mfa: Self { Self("reset") }

    public static var oauth: Self { Self("reset") }

    public static var setup: Self { Self("setup") }

    public static var initialize: Self { Self("initialize") }

    public static var challenge: Self { Self("challenge") }

    public static var recovery: Self { Self("recovery") }

    public static var generate: Self { Self("generate") }

    public static var count: Self { Self("count") }

    public static var configuration: Self { Self("configuration") }

    public static var disable: Self { Self("disable") }

    public static var multifactor: Self { Self("multifactor") }

    public static var manage: Self { Self("manage") }
}
