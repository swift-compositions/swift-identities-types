import Foundation

func jsonRoundTrip<Value: Codable>(_ value: Value) throws -> Value {
    try JSONDecoder().decode(Value.self, from: JSONEncoder().encode(value))
}

func url(_ string: String) -> URL? {
    URL(string: string)
}

func now() -> Date {
    Date()
}
