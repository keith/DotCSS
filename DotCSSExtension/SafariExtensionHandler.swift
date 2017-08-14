import SafariServices

final class SafariExtensionHandler: SFSafariExtensionHandler {
    override func messageReceived(withName messageName: String, from page: SFSafariPage,
                                  userInfo: [String : Any]?)
    {
        if messageName != "get_css" {
            NSLog("Got incorrect message name: \(messageName)")
            return
        }

        guard let urlString = userInfo?["url"] as? String, let host = URL(string: urlString)?.host else {
            NSLog("Didn't get URL with message in: \(userInfo ?? [:])")
            return
        }

        if let css = self.css(for: host) {
            page.dispatchMessageToScript(withName: "loaded_css", userInfo: ["css": css])
        }
    }

    private func css(for host: String) -> String? {
        guard let cHome = getpwuid(getuid())?.pointee.pw_dir else {
            NSLog("Failed to access home directory")
            return nil
        }

        let homeDirectory = URL(fileURLWithPath: String(cString: cHome))
        let cssURL = URL(fileURLWithPath: ".css", isDirectory: true, relativeTo: homeDirectory)
            .resolvingSymlinksInPath()
        let filename = host.replacingOccurrences(of: "www.", with: "").appending(".css")

        do {
            return try String(contentsOf: URL(fileURLWithPath: filename, relativeTo: cssURL))
        } catch let error {
            NSLog("Failed to load css file with error: \(error)")
            return nil
        }
    }
}
