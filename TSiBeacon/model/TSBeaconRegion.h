//
//  TSBeaconRegion.h
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TSBeaconRegion : NSObject

@property (nonatomic, strong) CLBeaconRegion *beaconRegion;
@property (nonatomic, strong) NSDate *lastNotificationDate;
@property (nonatomic, strong) NSDate *lastRangingActionDate;

@end
