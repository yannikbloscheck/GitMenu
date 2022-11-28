import SwiftUI




/// Button for reseting changes in a repository
struct ResetChangesButton: View {
    // MARK: Properties
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Reset Changes") {
            let result = Shell.run("git reset", for: repository)
            if let result, result.contains("Unstaged changes after reset") {
                Notifications.send(String(localized: "Successfully reset changes"), for: repository, andDisappear: false)
            } else if let result {
                Notifications.send(String(localized: "Error: ") + result, for: repository, andDisappear: false)
            } else {
                Notifications.send(String(localized: "Nothing to reset"), for: repository)
            }
        }
    }
}
