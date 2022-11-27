import SwiftUI




/// Button for adding chnages to a repository
struct AddChangesButton: View {
    // MARK: Properties
    
    /// The repository
    var repository: Repository
    
    
    
    /// The actual view
    var body: some View {
        Button("Add Changes") {
            let result = Shell.run("git add .", for: repository)
            if let result {
                Notifications.send("Error: " + result, for: repository, andDisappear: false)
            } else {
                Notifications.send("Successfully added changes", for: repository)
            }
        }
    }
}
