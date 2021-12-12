import Foundation

enum NetworkError: Error {
    case internalEror
    case unauthorized
    case custom(description: String)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .custom(description: let description):
            return description
        case .internalEror:
            return "Internal Error"
        case .unauthorized:
            return "Unauthorized"
        }
    }
}
