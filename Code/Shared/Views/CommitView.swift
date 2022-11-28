import SwiftUI




/// View for commiting
struct CommitView: View {
    // MARK: Properties
    
    /// The repository
    @Binding var repository: Repository?
    
    
    
    /// The text
    @State var text: String = ""
    
    
    
    /// The actual view
    var body: some View {
        if let repository {
            VStack(spacing: 0) {
                GroupBox {
                    Form {
                        LabeledContent("Repository:") {
                            Text(repository.title)
                            .bold()
                        }
                        .padding(.leading, 8)
                        
                        TextField("Message:", text: $text, prompt: Text("Text"))
                        .padding(.leading, 8)
                        .onSubmit {
                            commit()
                        }
                    }
                    .padding([.top, .bottom], 4)
                }
                .frame(minWidth: 300, idealWidth: 300)
                
                HStack {
                    Spacer(minLength: 0)
                    
                    Button("Cancel", role: .cancel) {
                        cancel()
                    }
                    
                    Button("Commit") {
                        commit()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
                .padding([.top, .bottom])
            }
            .padding([.leading, .trailing])
        }
    }
    
    
    
    
    // MARK: Methods
    
    /// Commits
    func commit() {
        if let repository, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let result = Shell.run("git commit -m \"\(text.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\""))\"", for: repository)
            if let result, result.contains("nothing to commit") {
                Notifications.send(String(localized: "Nothing to commit"), for: repository, andDisappear: false)
            } else if let result, result.contains("file changed") || result.contains("files changed") {
                Notifications.send(String(localized: "Successfully committed"), for: repository)
            } else if let result {
                Notifications.send(String(localized: "Error: ") + result, for: repository, andDisappear: false)
            } else {
                Notifications.send(String(localized: "Error"), for: repository, andDisappear: false)
            }
            
            cancel()
        }
    }
    
    
    
    /// Close window
    func cancel() {
        for window in NSApp.windows {
            if window.className != "NSStatusBarWindow" {
                window.close()
            }
        }
    }
}
