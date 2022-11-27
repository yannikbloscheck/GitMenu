import SwiftUI




/// View for renaming a repository group for repositories in settings
struct SettingsRenameRepositoryGroupView: View {
    // MARK: Properties
    
    /// The repository group
    @Binding var repositoryGroup: RepositoryGroup?
    
    
    
    /// If the repository group is being renamend currently
    @Binding var isRenamingRepositoryGroup: Bool
    
    
    
    /// The new title of the renamed repository group
    @Binding var renamedRepositoryGroupTitle: String
    
    
    
    /// The actual view
    var body: some View {
        VStack {
            TextField("Title", text: $renamedRepositoryGroupTitle)
            .onSubmit {
                if !renamedRepositoryGroupTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    isRenamingRepositoryGroup = false
                    repositoryGroup?.title = renamedRepositoryGroupTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            
            HStack {
                Spacer()
                
                Button("Cancel", role: .cancel) {
                    isRenamingRepositoryGroup = false
                }
                
                Button("Rename") {
                    isRenamingRepositoryGroup = false
                    repositoryGroup?.title = renamedRepositoryGroupTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                }
                .buttonStyle(.borderedProminent)
                .disabled(renamedRepositoryGroupTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.top, 8)
        }
        .padding()
        .frame(minWidth: 250)
        .onAppear {
            renamedRepositoryGroupTitle = repositoryGroup?.title ?? ""
        }
    }
}
