import Foundation




/// A repository
struct Repository: Identifiable, Hashable, Codable {
    // MARK: Properties
    
    /// The id
    var id: UUID = UUID()
    
    
    
    /// The title
    var title: String
    
    
    
    /// The url
    var url: URL
    
    
    
    /// If it uses versions
    var usesVersions: Bool
}
