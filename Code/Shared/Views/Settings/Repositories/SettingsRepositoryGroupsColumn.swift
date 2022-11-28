import SwiftUI




/// View for a column full of repository groups for repositories in settings
struct SettingsRepositoryGroupsColumn: View {
    // MARK: Properties
    
    /// The repository groups
    @Binding var repositoryGroups: [RepositoryGroup]
    
    
    
    /// The selected repository group id
    @Binding var selectedRepositoryGroupId: RepositoryGroup.ID?
    
    
    
    /// If the repository group is being renamend currently
    @Binding var isRenamingRepositoryGroup: Bool
    
    
    
    /// The selected repository id
    @Binding var selectedRepositoryId: Repository.ID?
    
    
    
    /// The actual view
    var body: some View {
        VStack(spacing: 0) {
            if !repositoryGroups.isEmpty {
                List(selection: $selectedRepositoryGroupId) {
                    ForEach($repositoryGroups) { $repositoryGroup in
                        Text(repositoryGroup.title)
                    }
                    .onMove { source, destination in
                        repositoryGroups.move(fromOffsets: source, toOffset: destination)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .frame(minWidth:150, idealWidth: 150, maxWidth: .infinity)
                .background(.white.opacity(0.6))
            } else {
                VStack {
                    Spacer()
                    
                    Text("Add Section")
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
                    let newSection = RepositoryGroup(title: "Untitled", repositories: [])
                    repositoryGroups.append(newSection)
                    selectedRepositoryGroupId = newSection.id
                    isRenamingRepositoryGroup = true
                } label: {
                    Label("Add Section", systemImage: "plus")
                    .padding(8)
                }
                
                Button {
                    repositoryGroups.removeAll { repositoryGroup in
                        repositoryGroup.id == selectedRepositoryGroupId
                    }
                    selectedRepositoryGroupId = repositoryGroups.first?.id
                } label: {
                    Label("Delete Section", systemImage: "minus")
                    .padding(.trailing, 8)
                    .padding([.top, .bottom], 12)
                }
                .disabled(selectedRepositoryGroupId == nil)
                
                Spacer(minLength: 0)
                
                Button {
                    isRenamingRepositoryGroup = true
                } label: {
                    Label("Rename Section", systemImage: "pencil.line")
                    .padding(8)
                }
                .padding(.leading, 4)
            }
            .buttonStyle(.borderless)
            .labelStyle(.iconOnly)
        }
        .frame(maxWidth: .infinity)
        .cornerRadius(3)
        .padding([.leading, .top], 1)
    }
}
