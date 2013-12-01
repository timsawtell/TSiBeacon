//
//  ViewController.m
//  TSiBeacon
//
//  Created by Tim Sawtell on 2/12/2013.
//  Copyright (c) 2013 Sawtell Software. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [Model sharedModel].activeViewController = self;
    
}

- (void)dealloc
{
    [Model sharedModel].activeViewController = nil;
}

@end
