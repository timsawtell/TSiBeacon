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
    for (TSBeaconRegion *region in [Model sharedModel].beaconRegions) {
        if ([region.beaconRegion.proximityUUID.UUIDString isEqualToString:uuid]) {
            if (region.beaconRegion.major.integerValue == major) {
                if (region.beaconRegion.minor.integerValue == minor) {
                    return region;
                }
            }
        }
    }
    
    return nil;
}

@end
