//
//  ContentView.swift
//  RCE
//

import SwiftUI
import RollbarNotifier


enum ExampleError: Error {
    case invalidResult
    case outOfBounds
    case invalidInput
}

// See also https://github.com/rollbar/rollbar-apple/blob/master/Demos/macosAppSwift/macosAppSwift/ContentView.swift

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
            
            Button("Handle Swift Error") {
                self.handleSwiftError()
            }
            
            Button("Throw uncaught exception") {
                handleButton()
            }
        }
        .padding()
    }
    
    
    func handleButton() {
        // A hard crash is captured by the crash reporter, The next time
        // the application is started the data is sent to Rollbar
        fatalError("Force a crash");
    }
    func handleSwiftError() {
        
        let extraInfo =  ["item_1": "value_1", "item_2": "value_2"]
        
        // Some different ways to explicitly log an error to Rolbar
        Rollbar.log(RollbarLevel.error, message: "My log message");
        
        Rollbar.log(RollbarLevel.error, error: ExampleError.invalidInput,
                    data: extraInfo,
                    context: "My additional information")
        
        Rollbar.errorMessage("My error message", data:extraInfo)
        Rollbar.errorError(ExampleError.invalidResult,
                           data: extraInfo)
        
        do {
            try doWorkOne()
        }
        catch {
            Rollbar.errorError(error, data: extraInfo)
        }
    }

    
    func doWorkOne() throws{
        
        throw ExampleError.outOfBounds
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
  
        
}







// Declare our error type
enum AppError: Error {
    case problem1
    case problem2
    case limitExceeded(limit: Int)
}

