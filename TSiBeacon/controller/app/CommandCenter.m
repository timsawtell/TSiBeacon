//
//  CommandCenter.m
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import "CommandCenter.h"

@implementation CommandCenter

+ (void)startMonitoringRegions:(NSArray *)regions forManager:(CLLocationManager *)locManager
{
    for (TSBeaconRegion *region in regions) {
        [locManager startMonitoringForRegion:region.beaconRegion];
    }
}

+ (void)startRangingBeacons:(NSArray *)beacons forManager:(CLLocationManager *)locManager
{
    for (CLBeaconRegion *region in beacons) {
        [locManager startRangingBeaconsInRegion:region];
    }
}

+ (void)stopRangingBeacons:(NSArray *)beacons forManager:(CLLocationManager *)locManager
{
    for (CLBeaconRegion *region in beacons) {
        [locManager stopRangingBeaconsInRegion:region];
    }
}

+ (void)handleEnterBeaconRegion:(TSBeaconRegion *)beaconRegion
{
    if (nil == beaconRegion.lastNotificationDate || [[NSDate date] timeIntervalSinceDate:beaconRegion.lastNotificationDate] > 60) {
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        notification.alertBody = [NSString stringWithFormat:@"You're near %@", beaconRegion.beaconRegion.identifier];
        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        beaconRegion.lastNotificationDate = [NSDate date];
    }
}

+ (void)handleBeaconRegionRanging:(TSBeaconRegion *)beaconRegion withBeacon:(CLBeacon *)beacon
{
    CLBeaconRegion *region = beaconRegion.beaconRegion;
    NSString *wholeString = [NSString stringWithFormat:@"Beacon:\n%@\nMajor: %d, Minor: %d\nName from webservice: \"%@\"\nStrength: %d\nProbable Distance: %.02fm",
                             beacon.proximityUUID.UUIDString,
                             beacon.major.integerValue,
                             beacon.minor.integerValue,
                             region.identifier,
                             beacon.rssi,
                             beacon.accuracy];
    
    switch (beacon.proximity) {
        case CLProximityFar:
            wholeString = [NSString stringWithFormat:@"%@\n%@", wholeString, @"You are 'Far Away From' the beacon"];
            break;
        case CLProximityNear:
            wholeString = [NSString stringWithFormat:@"%@\n%@", wholeString, @"You are 'Near' the beacon"];
            break;
        case CLProximityImmediate:
            wholeString = [NSString stringWithFormat:@"%@\n%@", wholeString, @"You are 'Immediately Close To' the beacon"];
            break;
        default:
            wholeString = [NSString stringWithFormat:@"%@\n%@", wholeString, @"You are 'Unknown Distance From' the beacon"];
            break;
    }
    if (nil != [Model sharedModel].activeViewController) {
        [Model sharedModel].activeViewController.textView.text = wholeString;
    }
}

+ (void)spawnSomeRegions
{
    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:kUUID];
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                     major:1
                                                                     minor:3
                                                                identifier:@"Your own iBeacon mang!"];
    region.notifyEntryStateOnDisplay = YES;
    TSBeaconRegion *beaconRegion = [TSBeaconRegion new];
    beaconRegion.beaconRegion = region;
    
    [Model sharedModel].beaconRegions = @[beaconRegion];
}

@end
