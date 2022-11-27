import SwiftUI
import ServiceManagement




/// View for login in settings
struct SettingsLoginView: View {
    // MARK: Properties
    
    /// The stored setting for if the app should automatically launched on login
    @AppStorage("ShouldLaunchOnLogin") var shouldLaunchOnLogin: Bool = false
    
    
    
    /// The actual view
    var body: some View {
        HStack(spacing: 0) {
            Toggle("Launch this app automatically on login", isOn: $shouldLaunchOnLogin)
        }
        .padding()
        .onChange(of: shouldLaunchOnLogin) { changedShouldLaunchOnLogin in
            let service = SMAppService()
            if changedShouldLaunchOnLogin {
                try? service.register()
            } else {
                try? service.unregister()
            }
        }
    }
}
