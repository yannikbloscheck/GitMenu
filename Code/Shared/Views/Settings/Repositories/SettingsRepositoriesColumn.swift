import SwiftUI




/// View for a column full of repositoryies for repositories in settings
struct SettingsRepositoriesColumn: View {
    // MARK: Properties
    
    /// The stored default for if new repositories sould use versions
    @AppStorage("ShouldUseVersionsByDefault") var shouldUseVersionsByDefault: Bool = false
    
    
    
    /// The repository group
    @Binding var repositoryGroup: RepositoryGroup?
    
    
    
    /// The selected repository id
    @Binding var selectedRepositoryId: Repository.ID?
    
    
    
    /// The actual view
    var body: some View {
        VStack(spacing: 0) {
            if let repositoryGroup {
                List(selection: $selectedRepositoryId) {
                    ForEach(repositoryGroup.repositories) { repository in
                        Text(repository.title)
                    }
                    .onMove { source, destination in
                        var repositories = repositoryGroup.repositories
                        repositories.move(fromOffsets: source, toOffset: destination)
                        self.repositoryGroup?.repositories = repositories
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .frame(minWidth:150, idealWidth: 150, maxWidth: .infinity)
                .background(.white.opacity(0.6))
            } else {
                VStack {
                    Spacer()
                    
                    Text("Select Section")
                    .foregroundColor(.secondary)
                    
                    Spacer()
                }
                .frame(minWidth:150, idealWidth: 150, maxWidth: .infinity)
                .background(.white.opacity(0.6))
            }
            
            Color.primary
            .opacity(0.1)
            .frame(maxWidth: .infinity, minHeight: 1, idealHeight: 1, maxHeight: 1)
            
            HStack(spacing: 0) {
                Button {
                    let openPanelDelegate = SettingsPickRepositoryDelegate()
                    let openPanel = NSOpenPanel()
                    openPanel.delegate = openPanelDelegate
                    openPanel.allowsMultipleSelection = false
                    openPanel.canChooseDirectories = true
                    openPanel.canChooseFiles = false
                    if openPanel.runModal() == .OK, let url = openPanel.url {
                        let newRepository = Repository(title: url.lastPathComponent, url: url, usesVersions: shouldUseVersionsByDefault)
                        
                        var repositories = repositoryGroup?.repositories ?? []
                        repositories.append(newRepository)
                        repositoryGroup?.repositories = repositories
                        
                        selectedRepositoryId = newRepository.id
                    }
                } label: {
                    Label("Add Repository", systemImage: "plus")
                    .padding(8)
                }
                .disabled(repositoryGroup == nil)
                
                Button {
                    var repositories = repositoryGroup?.repositories ?? []
                    repositories.removeAll { repository in
                        repository.id == selectedRepositoryId
                    }
                    repositoryGroup?.repositories = repositories
                    selectedRepositoryId = repositoryGroup?.repositories.first?.id
                } label: {
                    Label("Delete Repository", systemImage: "minus")
                    .padding(.trailing, 8)
                    .padding([.top, .bottom], 12)
                }
                .disabled(repositoryGroup == nil || selectedRepositoryId == nil)
                
                Spacer(minLength: 0)
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
        }
        .frame(maxWidth: .infinity)
        .padding([.top], 1)
    }
}
