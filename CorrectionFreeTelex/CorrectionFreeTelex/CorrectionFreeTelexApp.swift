import Cocoa
import InputMethodKit
import SwiftUI

@main
struct CorrectionFreeTelexApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

	var body: some Scene {
		WindowGroup {}
	}

	class AppDelegate: NSObject, NSApplicationDelegate {
		var server = IMKServer()
		var candidates = IMKCandidates()

		func applicationDidFinishLaunching(_ notification: Notification) {
			server = IMKServer(
				name: Bundle.main.infoDictionary?["InputMethodConnectionName"] as? String,
				bundleIdentifier: Bundle.main.bundleIdentifier
			)
			candidates = IMKCandidates(
				server: server,
				panelType: kIMKSingleRowSteppingCandidatePanel,
				styleType: kIMKMain
			)
		}

		func applicationWillTerminate(_ notification: Notification) {}
	}
}
