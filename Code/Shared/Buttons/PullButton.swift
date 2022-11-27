import SwiftUI




/// Button for pulling a repository
struct PullButton: View {
    // MARK: Properties
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Pull") {
            let result = Shell.run("git pull", for: repository)
            if let result, result.contains("Already up to date.") {
                Notifications.send("Successfully pulled", for: repository)
            } else if let result {
                Notifications.send("Error: " + result, for: repository, andDisappear: false)
            } else {
                Notifications.send("Error", for: repository, andDisappear: false)
            }
            
        }
    }
}
