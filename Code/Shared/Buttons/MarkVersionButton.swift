import SwiftUI




/// Button for marking a version in a repository
struct MarkVersionButton: View {
    // MARK: Properties
    
    /// The open window action of the environment
    @Environment(\.openWindow) private var openWindow
    
    
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Mark Version...") {
            NSApp.activate(ignoringOtherApps: true)
            
            openWindow(id: "mark-version", value: repository)
        }
    }
}
