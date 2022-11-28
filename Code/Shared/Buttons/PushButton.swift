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
                Notifications.send(String(localized: "Successfully pushed"), for: repository)
            } else if let result, result.contains("Everything up-to-date") {
                Notifications.send(String(localized: "Nothing to push"), for: repository, andDisappear: false)
            } else if let result {
                Notifications.send(String(localized: "Error: ") + result, for: repository, andDisappear: false)
            } else {
                Notifications.send(String(localized: "Error"), for: repository, andDisappear: false)
            }
        }
    }
}
