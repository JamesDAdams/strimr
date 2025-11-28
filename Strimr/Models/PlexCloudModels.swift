import Foundation

struct PlexCloudResource: Codable, Equatable {
    struct Connection: Codable, Equatable {
        let scheme: String
        let address: String
        let port: Int
        let uri: URL
        let isLocal: Bool
        let isRelay: Bool
        let isIPv6: Bool

        private enum CodingKeys: String, CodingKey {
            case scheme = "protocol"
            case address
            case port
            case uri
            case isLocal = "local"
            case isRelay = "relay"
            case isIPv6 = "IPv6"
        }
    }

    let name: String
    let clientIdentifier: String
    let accessToken: String
    let connections: [Connection]
}

struct PlexCloudUser: Codable, Equatable {
    struct Subscription: Codable, Equatable {
        let active: Bool
        let subscribedAt: String?
        let status: String?
        let paymentService: String?
        let plan: String?
        let features: [String]?
    }

    struct Roles: Codable, Equatable {
        let roles: [String]
    }

    let id: Int
    let uuid: String
    let username: String
    let title: String
    let email: String
    let friendlyName: String
    let locale: String?
    let confirmed: Bool
    let joinedAt: String
    let authToken: String
    let subscription: Subscription
    let roles: Roles
}

struct PlexCloudPin: Codable, Equatable {
    struct Location: Codable, Equatable {
        let code: String
        let country: String
    }

    let id: Int
    let code: String
    let product: String
    let trusted: Bool
    let clientIdentifier: String
    let location: Location
    let expiresIn: Int
    let createdAt: String
    let expiresAt: String
    let authToken: String?
    let newRegistration: Bool?
}
