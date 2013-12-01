//
//  Model.h
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"

@interface Model : NSObject

@property (nonatomic, strong) NSArray *beaconRegions;
@property (nonatomic, weak) ViewController *activeViewController;

+ (Model*)sharedModel;

@end
