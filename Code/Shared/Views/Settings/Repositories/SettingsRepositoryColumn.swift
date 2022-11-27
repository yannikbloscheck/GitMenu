import SwiftUI




/// View for a column for a repository for repositories in settings
struct SettingsRepositoryColumn: View {
    // MARK: Properties
    
    /// The repository
    @Binding var repository: Repository?
    
    
    /// The title of the selected repository
    @State private var title: String = ""
    
    
    
    /// If the selected repository uses versions
    @State private var usesVersions: Bool = false
    
    
    
    /// The actual view
    var body: some View {
        if let repository {
            Form {
                TextField("", text: $title, prompt: Text("Title"))
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(repository.url.path(percentEncoded: false))
                    .foregroundColor(.secondary)
                    
                    Button {
                        let openPanelDelegate = SettingsPickRepositoryDelegate()
                        let openPanel = NSOpenPanel()
                        openPanel.delegate = openPanelDelegate
                        openPanel.allowsMultipleSelection = false
                        openPanel.canChooseDirectories = true
                        openPanel.canChooseFiles = false
                        openPanel.canCreateDirectories = false
                        openPanel.treatsFilePackagesAsDirectories = false
                        if openPanel.runModal() == .OK, let url = openPanel.url {
                            self.repository?.url = url
                        }
                    } label: {
                        Text("Change...")
                    }
                }
                .padding(.bottom)
                
                Toggle("Use versions", isOn: $usesVersions)
                
                Spacer(minLength: 0)
            }
            .padding()
            .frame(minWidth:300, idealWidth: 300, maxWidth: .infinity)
            .onAppear {
                title = repository.title
                usesVersions = repository.usesVersions
            }
            .onChange(of: repository) { changedRepository in
                title = changedRepository.title
                usesVersions = changedRepository.usesVersions
            }
            .onChange(of: title) { changedTitle in
                self.repository?.title = changedTitle
            }
            .onChange(of: usesVersions) { changedUsesVersions in
                self.repository?.usesVersions = changedUsesVersions
            }
        } else {
            VStack {
                Spacer()
                
                Text("Select Section")
                .foregroundColor(.secondary)
                
                Spacer()
            }
            .frame(minWidth:300, idealWidth: 300, maxWidth: .infinity)
        }
    }
}
