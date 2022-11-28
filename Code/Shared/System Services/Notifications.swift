import Foundation
import UserNotifications




/// A connection to the notification system
struct Notifications {
    // MARK: Methods
    
    /// Sends the given message for the given repository (and optionally disappears after being displayed)
    /// - Parameter message: A message
    /// - Parameter repository: A repository
    /// - Parameter isTemporary: If the message should disappear  after being displayed
    static func send(_ message: String, for repository: Repository, andDisappear isTemporary: Bool = true) {
        let content = UNMutableNotificationContent()
        content.title = repository.title
        content.body = message
        content.interruptionLevel = .timeSensitive
        content.threadIdentifier = repository.id.uuidString
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request)
        
        Task {
            if isTemporary {
                try? await Task.sleep(nanoseconds: 5_000_000_000)
            } else {
                try? await Task.sleep(nanoseconds: 240_000_000_000)
            }
            
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [request.identifier])
        }
    }
}
