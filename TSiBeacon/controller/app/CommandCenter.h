//
//  CommandCenter.h
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommandCenter : NSObject

+ (void)startMonitoringRegions:(NSArray *)regions forManager:(CLLocationManager *)locManager;

+ (void)startRangingBeacons:(NSArray *)beacons forManager:(CLLocationManager *)locManager;

+ (void)stopRangingBeacons:(NSArray *)beacons forManager:(CLLocationManager *)locManager;

+ (void)handleEnterBeaconRegion:(TSBeaconRegion *)beaconRegion;

+ (void)handleBeaconRegionRanging:(TSBeaconRegion *)beaconRegion withBeacon:(CLBeacon *)beacon;

+ (void)spawnSomeRegions;

@end
