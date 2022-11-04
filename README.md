# apple-swift-app
iOS Swift app that showcases  Rollbar's Apple SDK configuration
Thsi application uses cocoapods as it's package manager

# What this application contains

See following 2 files show Rollbar configuration and usage
app/RCE/RCEApp.swift
app/RCE/ContentView.swift

## RCEApp.swift

Shows Rollbar being configured in the didFinishLaunchingWithOptions event handler

The method initRollbar() includes the following configurations

1. Initilization with post_client_item Rollbar Project access token
2. environment - Name of the environment the app is running in
3. codeVersion - The git commit SHA, release tag etc. of the code running  
This allows you to immediately see which code version an error was first seen in.
It is also used in the Rollbar source control code context integration

4. IP address being anonymized if needed
5. Suppressing detailed Rollbar logging when debugging in XCode
6. checkIgnoreRollbarData - Define a method that will be called before the data is sentto Rollbar.
In this method to can decide to not sent the data to Rollbar
7. modifyRollbarData - Define a method that will be called just before the data is sentto Rollbar
This will allow you to add, remove, modify data in the payload just befoe it is sent.
It is often used for advanced data scrubbing, adding additional data to the payload, or moving data to a different location in the payload

8. person - Included details about the user 
9. customData - Custom data fields that will be added to every occurrence sent to Rollbar
Often used to send data to help understand the business impact of an error
10. Crash Collector - Defining the crash collector that will be used 

NOTE: The data about a crash will only be sent to Rollbar the next tim ethe user starts the application


## ContentView.swift

Logging to Rollbar is various ways


# Build Instructions 

## Step 1
Download the source code from the repository https://github.com/RollbarCustomerEng/apple-swift-app


## Step 2

Open a terminal and cd to the download folder
cd app

Step 3
Edit the Podfile as needed, to use the latest version of the Rollbar Apple SDK
See https://github.com/rollbar/rollbar-apple/releases


Edit the Podfile Rollbar dependency versions as needed 
Save Podfile
Execute the following command to install the dependencies

pod install

## Step 3
Open the project in XCode using the RCE.xcworkspace file so that the dependencies 

DO NOT open it using RCE.xcodeproj (as the cocpods dependencies will not be read correctly)

## Step 4
In Xcode click on the Product\Build menu item

