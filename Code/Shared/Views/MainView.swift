import SwiftUI
import UserNotifications




/// Main view
struct MainView: View {
    // MARK: Properties
    
    /// The actual view
    var body: some View {
        ProgressView()
        .padding(.top, 4)
        .padding([.leading, .trailing, .bottom], 18)
        .task {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) { _, _ in
                // Do nothing
            }
            
            for window in NSApp.windows {
                if window.className != "NSStatusBarWindow" {
                    window.close()
                }
            }
        }
    }
}
