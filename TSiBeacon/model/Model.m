//
//  Model.m
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import "Model.h"

@implementation Model

#pragma mark - Data

+ (NSString*)savedDataPath
{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"model.dat"];
    return filePath;
}

+ (Model*)savedModel
{
    Model *model = [NSKeyedUnarchiver unarchiveObjectWithFile: [Model savedDataPath]];
    if (!model) {
        model = [Model new];
        model.beaconRegions = [NSArray array];
        return model;
    }
    return model;
}

+ (Model*)sharedModel
{
    static Model* sharedModel = nil;
    @synchronized(self) {
        if (sharedModel == nil) {
            sharedModel = [Model savedModel];
        }
    }
    return sharedModel;
}

- (void)save
{
    @try {
        @synchronized(self)
        {
            [NSKeyedArchiver archiveRootObject: self toFile: [Model savedDataPath]];
        }
    } @catch (NSException *exception) {
    }
}

@end
