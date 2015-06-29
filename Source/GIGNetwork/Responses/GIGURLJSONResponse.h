//
//  GIGURLJSONResponse.h
//  GiGLibrary
//
//  Created by Sergio Baró on 29/06/15.
//  Copyright (c) 2015 Gigigo SL. All rights reserved.
//

#import <GIGLibrary/GIGLibrary.h>


@interface GIGURLJSONResponse : GIGURLResponse

@property (strong, nonatomic) id json;

- (instancetype)initWithJSON:(id)json;

@end