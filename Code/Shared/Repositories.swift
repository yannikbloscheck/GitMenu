import Foundation




/// A way to help storing repositories in groups
struct Repositories: Hashable, Codable, RawRepresentable {
    // MARK: Properties
    
    /// The repository groups
    var groups: [RepositoryGroup]
    
    
    
    /// The raw value for storing the repositories
    public var rawValue: String {
        return String(data: try! JSONEncoder().encode(groups), encoding: .utf8)!
    }
    
    
    
    
    // MARK: Initialization
    
    /// Initalizes the repositories from a stored raw value
    /// - Parameter persistence: A raw value storing the repositories
    public init?(rawValue: String) {
        groups = (try? JSONDecoder().decode([RepositoryGroup].self, from: rawValue.data(using: .utf8)!)) ?? []
    }
    
    
    
    /// Initalizes the repositories
    public init() {
        groups = []
    }
}
