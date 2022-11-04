//
//  RCEApp.swift
//  RCE
//

import SwiftUI
import RollbarSwift
import RollbarNotifier
import RollbarPLCrashReporter

class FSAppDelegate: NSObject, UIApplicationDelegate {
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    // ...

      initRollbar();
      
    return true
  }
    
    func initRollbar() {
        
        // Dynamically read these settings from your config settings on application startup
        let accessToken = "********"  // Rollbar post_client_item access token
        let environment = "staging"
        let codeVersion = "e27a6f245"  // Ideally codeVersion is commit SHA https://docs.rollbar.com/docs/versions

        // Initialize a configuration object and add configuration settings as needed
        let config =  RollbarConfig.init()

        
        config.destination.accessToken = accessToken
        config.destination.environment = environment
        config.loggingOptions.codeVersion = codeVersion
        

        // config.loggingOptions.captureIp = RollbarCaptureIpType.anonymize // Optionally anonymize the IP address
        // config.developerOptions.suppressSdkInfoLogging = true // Suppress Rollbar event being logged (e.g. in XCode debug logs)
        
        config.telemetry.enabled = true;
        config.telemetry.captureLog = true;
        config.telemetry.maximumTelemetryData = 10
        
        config.modifyRollbarData = self.transform(payload:)
        
        // Optionally dont send certain occurrences based on some aspect of the payload contents
        // config.checkIgnoreRollbarData = self.checkIgnore(payload:)
    
        // List of fields to scrub - Make sure to test this if you are overriding the default scrub list
        // config.dataScrubber.scrubFields = ["accessToken", "cpu", "key_y"]
        
        
        config.person.id = "12345" // optionally add data about the user to improve error response
        config.customData = [ "customer_type": "enterprise"] // additional custom data to add to every occurrence sent
        
        
        // Initialize a Rollbar shared instance with a crash collector
        let crashCollector = RollbarPLCrashCollector()
        Rollbar.initWithConfiguration(config, crashCollector: crashCollector)
        
    
        // Note the ability to add aditional key/value pairs to the occurrence data for extra context
        Rollbar.infoMessage("Rollbar is up and running! Enjoy your remote error and log monitoring...",
                            data: ["key_x": "value_x", "key_y": "value_y"]);
        
    }
    
    
    func checkIgnore(payload:Rollbar) -> Bool {
        
        // return true means DO NOT send the data to Rollbar (i.e. ignore)
        // return false means DO send the data to Rollbar
        return false
    }
    
    func transform(payload:RollbarData) -> RollbarData {
        /*
         Transform the occurrence payload just before the data is sent
         This allows data to be added/removed from the payload basd on some aspect of the
         payload data
         
         This method is often used to do advanced data scrubbing or to add
         additional data to the payload that is only available at the time
         the error occurs
         */
        
        // context is an indexed fast search field in the Rollbar web UI
        // The items timeline view can be filtered by context
        // https://docs.rollbar.com/docs/search-items#context

        payload.context = "owner#ui_team"
        return payload
    }
    

    
    
}



@main
struct RCEApp: App {
    @UIApplicationDelegateAdaptor var delegate: FSAppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
