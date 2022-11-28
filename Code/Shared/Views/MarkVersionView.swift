import SwiftUI




/// View for marking a version
struct MarkVersionView: View {
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
                        
                        TextField("Version:", text: $text, prompt: Text("0.0"))
                        .padding(.leading, 8)
                        .onSubmit {
                            markVersion()
                        }
                    }
                    .padding([.top, .bottom], 4)
                }
                .frame(minWidth: 250, idealWidth: 250)
                
                HStack {
                    Spacer(minLength: 0)
                    
                    Button("Cancel", role: .cancel) {
                        cancel()
                    }
                    
                    Button("Mark Version") {
                        markVersion()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || text.contains(/\s+/))
                }
                .padding([.top, .bottom])
            }
            .padding([.leading, .trailing])
        }
    }
    
    
    
    
    // MARK: Methods
    
    /// Marks version
    func markVersion() {
        if let repository, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let result = Shell.run("git tag -s -a v\(text) -m \"Version \(text.replacingOccurrences(of: "\\", with: "\\\\").replacingOccurrences(of: "\"", with: "\\\""))\"", for: repository)
            if let result, result.contains("already exists") {
                Notifications.send(String(localized: "Version already marked"), for: repository)
            } else if let result {
                Notifications.send(String(localized: "Error: ") + result, for: repository, andDisappear: false)
            } else {
                Notifications.send(String(localized: "Version successfully marked"), for: repository)
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
