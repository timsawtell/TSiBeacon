TSiBeacon
=========

Demo app to handle ranging iBeacons and handling getting near them.


Setup
=========

Download apple's AirLocate sample code from https://developer.apple.com/downloads
You need to be a registered developer. Log in and search for "Air Locate"

Run AirLocate on a different iOS device (iphone 4S+, iOS 7+)
On that device, run AirLocate, choose configuration, choose the E2C56... uuid, 
Major: 1
Minor: 3
Save

Run TSiBeacon.
If your device is iphone 4S+, iOS 7+ and has bluetooth turned on, it should be able to detect the iBeacon running via the AirLocate app on the other device.
