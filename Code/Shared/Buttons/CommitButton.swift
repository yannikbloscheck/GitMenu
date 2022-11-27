import SwiftUI




/// Button for commiting a repository
struct CommitButton: View {
    // MARK: Properties
    
    /// The open window action of the environment
    @Environment(\.openWindow) private var openWindow
    
    
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Commit...") {
            NSApp.activate(ignoringOtherApps: true)
            
            openWindow(id: "commit", value: repository)
        }
    }
}
