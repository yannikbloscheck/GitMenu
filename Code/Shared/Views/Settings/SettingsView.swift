import SwiftUI




/// View for settings
struct SettingsView: View {
    // MARK: Properties
    
    /// The selected tab
    @State var selectedTab: Int = 2
    
    
    
    /// The actual view
    var body: some View {
        TabView(selection: $selectedTab) {
            SettingsLoginView()
            .tabItem {
                Label("Login", systemImage: "dots.and.line.vertical.and.cursorarrow.rectangle")
            }
            .tag(1)
            
            SettingsRepositoriesView()
            .tabItem {
                Label("Repositories", systemImage: "rectangle.stack")
            }
            .tag(2)
        }
        .frame(minWidth: 800)
        .navigationTitle("Settings")
    }
}
