//
//  AppDelegate.m
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconRegionAccessor.h"

@interface AppDelegate()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    
    //clear out any old ones
    for (CLRegion *region in self.locationManager.monitoredRegions) {
        [self.locationManager stopMonitoringForRegion:region];
    }
    
    //start giving a shit about these iBeacons
    [CommandCenter spawnSomeRegions];
    [CommandCenter startMonitoringRegions:[Model sharedModel].beaconRegions forManager:self.locationManager];
    
    return YES;
}
							
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    // CoreLocation will call this delegate method at 1 Hz with updated range information.
    
    for (CLBeacon *beacon in beacons) {
        
        if ([region isKindOfClass:[CLBeaconRegion class]]) {
            CLBeaconRegion *beaconRegionInstance = (CLBeaconRegion *)region;
            TSBeaconRegion *beaconRegion = [BeaconRegionAccessor regionWithUUID:beaconRegionInstance.proximityUUID.UUIDString
                                                                    withMajor:beaconRegionInstance.major.integerValue
                                                                    withMinor:beaconRegionInstance.minor.integerValue];
            if (nil == beaconRegion) {
                return;
            }
            [CommandCenter handleBeaconRegionRanging:beaconRegion withBeacon:beacon];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // A user can transition in or out of a region while the application is not running.
    // When this happens CoreLocation will launch the application momentarily, call this delegate method
    // and we will let the user know via a local notification.
    
    if(state == CLRegionStateInside) {
        [CommandCenter startRangingBeacons:@[region] forManager:manager];
        
        if ([region isKindOfClass:[CLBeaconRegion class]]) {
            CLBeaconRegion *bearconRegionInstance = (CLBeaconRegion *)region;
            TSBeaconRegion *beaconRegion = [BeaconRegionAccessor regionWithUUID:bearconRegionInstance.proximityUUID.UUIDString
                                                                    withMajor:bearconRegionInstance.major.integerValue
                                                                    withMinor:bearconRegionInstance.minor.integerValue];
            if (nil == beaconRegion) {
                return;
            }
            
            [CommandCenter handleEnterBeaconRegion:beaconRegion];
        }
        
    } else if(state == CLRegionStateOutside) {
        [CommandCenter stopRangingBeacons:@[region] forManager:manager];
    }
}

@end
