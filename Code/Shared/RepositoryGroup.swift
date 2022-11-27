import Foundation




/// A group of repositories
struct RepositoryGroup: Identifiable, Hashable, Codable {
    // MARK: Properties
    
    /// The id
    var id: UUID = UUID()
    
    
    
    /// The title
    var title: String
    
    
    
    /// The repositories
    var repositories: [Repository]
}
