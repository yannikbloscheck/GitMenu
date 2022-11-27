import Foundation




/// A connection to the shell system
struct Shell {
    // MARK: Methods
    
    /// Runs a given command for a given repository
    /// - Parameter command: A command
    /// - Parameter repository: A repository
    /// - Returns: The result of running the command
    @discardableResult
    static func run(_ command: String, for repository: Repository) -> String? {
        let task = Process()
        let pipe = Pipe()
        
        task.standardOutput = pipe
        task.standardError = pipe
        task.arguments = ["-c", "cd \"\(repository.url.path(percentEncoded: false))\"; " + command]
        task.executableURL = URL(fileURLWithPath: "/bin/zsh")
        task.standardInput = nil
        
        var text: String? = nil
        if let _ = try? task.run() {
            let data = pipe.fileHandleForReading.readDataToEndOfFile()
            if let output = String(data: data, encoding: .utf8), !output.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                text = output.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        return text
    }
}
