import SwiftUI




/// Main for the application
@main
struct Main: App {
    // MARK: Properties
    
    /// The stored repositories
    @AppStorage("Repositories") var repositories: Repositories = Repositories()
    
    
    
    /// The actual scene
    var body: some Scene {
        MenuBarExtra("GitMenu", image: "Symbol") {
            ForEach(repositories.groups) { repositoryGroup in
                Section(repositoryGroup.title) {
                    ForEach(repositoryGroup.repositories) { repository in
                        Menu(repository.title) {
                            PullButton(repository: repository)
                            
                            Divider()
                            
                            AddChangesButton(repository: repository)
                            
                            ResetChangesButton(repository: repository)
                            
                            Divider()
                            
                            CommitButton(repository: repository)
                            
                            Divider()
                            
                            if repository.usesVersions {
                                MarkVersionButton(repository: repository)
                                
                                Divider()
                            }
                            
                            PushButton(repository: repository)
                        }
                    }
                }
            }
            
            Button("Settings...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                NSApp.activate(ignoringOtherApps: true)
            }
            .keyboardShortcut(",", modifiers: .command)
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("Q", modifiers: .command)
        }
        
        WindowGroup {
            MainView()
        }
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .defaultPosition(.center)
        
        WindowGroup("Commit", id: "commit", for: Repository.self) { $repository in
            CommitView(repository: $repository)
        }
        .commandsRemoved()
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .defaultPosition(.center)
        .defaultSize(width: 320, height: 250)
        
        WindowGroup("Mark Version", id: "mark-version", for: Repository.self) { $repository in
            MarkVersionView(repository: $repository)
        }
        .commandsRemoved()
        .windowResizability(.contentSize)
        .windowStyle(.hiddenTitleBar)
        .defaultPosition(.center)
        .defaultSize(width: 270, height: 250)
        
        Settings {
            SettingsView()
        }
        .defaultPosition(.center)
    }
}
