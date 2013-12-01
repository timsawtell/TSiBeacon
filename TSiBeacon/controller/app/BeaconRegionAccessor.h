//
//  BeaconRegionAccessor.h
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BeaconRegionAccessor : NSObject

+ (TSBeaconRegion *)regionWithUUID:(NSString *)uuid
                         withMajor:(NSInteger)major
                         withMinor:(NSInteger)minor;

@end
