//
//  BeaconRegionAccessor.m
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import "BeaconRegionAccessor.h"

@implementation BeaconRegionAccessor

+ (TSBeaconRegion *)regionWithUUID:(NSString *)uuid
                         withMajor:(NSInteger)major
                         withMinor:(NSInteger)minor
{
    __block TSBeaconRegion *foundRegion = nil;
    [[Model sharedModel].beaconRegions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        TSBeaconRegion *region = (TSBeaconRegion *)obj;
        if ([region.beaconRegion.proximityUUID.UUIDString isEqualToString:uuid]) {
            if (region.beaconRegion.major.integerValue == major) {
                if (region.beaconRegion.minor.integerValue == minor) {
                    foundRegion = region;
                    stop = (BOOL*)YES;
                }
            }
        }
    }];
    return foundRegion;
}

@end
