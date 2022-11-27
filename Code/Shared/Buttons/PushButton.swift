import SwiftUI




/// Button for pushing a repository
struct PushButton: View {
    // MARK: Properties
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Push") {
            let result = Shell.run("git push; git push --tags", for: repository)
            if let result, result.contains("->") {
                Notifications.send("Successfully pushed", for: repository)
            } else if let result, result.contains("Everything up-to-date") {
                Notifications.send("Nothing to push", for: repository, andDisappear: false)
            } else if let result {
                Notifications.send("Error: " + result, for: repository, andDisappear: false)
            } else {
                Notifications.send("Error", for: repository, andDisappear: false)
            }
        }
    }
}
