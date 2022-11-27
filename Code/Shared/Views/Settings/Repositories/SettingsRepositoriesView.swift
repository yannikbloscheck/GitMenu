import SwiftUI




/// View for repositories in settings
struct SettingsRepositoriesView: View {
    // MARK: Properties
    
    /// The stored repositories
    @AppStorage("Repositories") var repositories: Repositories = Repositories()
    
    
    
    /// The stored default for if new repositories sould use versions
    @AppStorage("ShouldUseVersionsByDefault") var shouldUseVersionsByDefault: Bool = false
    
    
    
    /// The selected repository group id
    @State private var selectedRepositoryGroupId: RepositoryGroup.ID? = nil
    
    
    
    /// The repository group
    @State private var repositoryGroup: RepositoryGroup? = nil
    
    
    
    /// If the repository group is being renamend currently
    @State private var isRenamingRepositoryGroup: Bool = false
    
    
    
    /// The new title of the renamed repository group
    @State private var renamedRepositoryGroupTitle: String = ""
    
    
    
    /// The selected repository id
    @State private var selectedRepositoryId: Repository.ID? = nil
    
    
    
    /// The repository
    @State private var repository: Repository? = nil
    
    
    
    /// The actual view
    var body: some View {
        VStack {
            HSplitView {
                HSplitView {
                    SettingsRepositoryGroupsColumn(repositoryGroups: $repositories.groups, selectedRepositoryGroupId: $selectedRepositoryGroupId, isRenamingRepositoryGroup: $isRenamingRepositoryGroup, selectedRepositoryId: $selectedRepositoryId)
                    
                    SettingsRepositoriesColumn(repositoryGroup: $repositoryGroup, selectedRepositoryId: $selectedRepositoryId)
                }
                
                SettingsRepositoryColumn(repository: $repository)
            }
            .background {
                GroupBox {
                    Spacer()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Toggle("Use versions by default for new repositories", isOn: $shouldUseVersionsByDefault)
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(minHeight: 400)
        .sheet(isPresented: $isRenamingRepositoryGroup, content: {
            SettingsRenameRepositoryGroupView(repositoryGroup: $repositoryGroup, isRenamingRepositoryGroup: $isRenamingRepositoryGroup, renamedRepositoryGroupTitle: $renamedRepositoryGroupTitle)
        })
        .onAppear {
            if selectedRepositoryGroupId == nil {
                selectedRepositoryGroupId = repositories.groups.first?.id
                
                if selectedRepositoryId == nil {
                    selectedRepositoryId = repositories.groups.first?.repositories.first?.id
                }
            }
        }
        .onChange(of: selectedRepositoryGroupId) { changedSelectedRepositoryGroupId in
            repositoryGroup = repositories.groups.first { group in
                changedSelectedRepositoryGroupId == group.id
            }
            selectedRepositoryId = repositoryGroup?.repositories.first?.id
        }
        .onChange(of: selectedRepositoryId) { changedSelectedRepositoryId in
            repository = repositoryGroup?.repositories.first { repository in
                changedSelectedRepositoryId == repository.id
            }
        }
        .onChange(of: repositoryGroup) { changedRepositoryGroup in
            if !isRenamingRepositoryGroup, let changedRepositoryGroup, let index = repositories.groups.firstIndex(where: { group in
                group.id == changedRepositoryGroup.id
            }){
                repositories.groups[index] = changedRepositoryGroup
            }
        }
        .onChange(of: repository) { changedRepository in
            if !isRenamingRepositoryGroup, let changedRepository, let index = repositoryGroup?.repositories.firstIndex(where: { repository in
                repository.id == changedRepository.id
            }){
                repositoryGroup?.repositories[index] = changedRepository
            }
        }
    }
}
