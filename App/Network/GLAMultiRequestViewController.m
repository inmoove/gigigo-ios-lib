//
//  GLAMultiRequestViewController.m
//  GIGLibrary
//
//  Created by Sergio Baró on 30/09/15.
//  Copyright © 2015 Gigigo SL. All rights reserved.
//

#import "GLAMultiRequestViewController.h"


@interface GLAMultiRequestViewController ()

@property (strong, nonatomic) GIGURLCommunicator *communicator;

@end


@implementation GLAMultiRequestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.communicator = [[GIGURLCommunicator alloc] init];
}

#pragma mark - ACTIONS

- (IBAction)tapMultirequestButton
{
    GIGURLManager *manager = [GIGURLManager sharedManager];
    manager.useFixture = YES;
    [manager loadFixturesFile:@"fixtures.json"];
    manager.fixture = manager.fixtures[1];
    
    GIGURLRequest *request = [[GIGURLRequest alloc] init];
    request.requestTag = @"config";
    
    NSDictionary *requests = @{request.requestTag: request};
    
    [self.communicator sendRequests:requests completion:^(NSDictionary *responses) {
        NSLog(@"responses: %@", responses);
    }];
}

@end
