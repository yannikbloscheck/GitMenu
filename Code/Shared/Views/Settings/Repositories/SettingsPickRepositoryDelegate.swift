import AppKit




/// Delegate to help pick a repository with an open panel in settings
class SettingsPickRepositoryDelegate: NSObject, NSOpenSavePanelDelegate {
    // MARK: Methods
    
    @MainActor func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        let directories = (try? FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [.skipsPackageDescendants, .skipsSubdirectoryDescendants]).filter(\.hasDirectoryPath)) ?? []
        
        for directory in directories {
            if directory.lastPathComponent == ".git" || panel(sender, shouldEnable: directory) {
                return true
            }
        }
        
        return false
    }
    
    
    
    @MainActor func panel(_ sender: Any, validate url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.appending(component: ".git", directoryHint: .isDirectory).path(percentEncoded: false)) {
            throw URLError(.cannotOpenFile, userInfo: [NSLocalizedDescriptionKey : "This folder doesn't include a repository"])
        }
    }
}
