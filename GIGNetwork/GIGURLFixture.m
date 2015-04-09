//
//  GIGURLFixture.m
//  gignetwork
//
//  Created by Sergio Baró on 07/04/15.
//  Copyright (c) 2015 Gigigo. All rights reserved.
//

#import "GIGURLFixture.h"

#import "GIGURLBundle.h"


@interface GIGURLFixture ()
<NSCoding>

@end


@implementation GIGURLFixture

- (instancetype)initWithJSON:(NSDictionary *)json bundle:(GIGURLBundle *)bundle
{
    NSString *name = json[@"name"];
    NSString *filename = json[@"filename"];
    NSDictionary *mocks = json[@"mocks"];
    
    if (filename.length > 0)
    {
        NSDictionary *fileMocks = [bundle loadJSONFile:filename rootNode:nil];
        if (fileMocks.count > 0)
        {
            NSMutableDictionary *totalMocks = [fileMocks mutableCopy];
            [totalMocks addEntriesFromDictionary:mocks];
            mocks = [totalMocks copy];
        }
    }
    
    return [self initWithName:name mocks:mocks];
}

- (instancetype)initWithName:(NSString *)name mocks:(NSDictionary *)mocks
{
    self = [super init];
    if (self)
    {
        _name = name;
        _mocks = mocks;
    }
    return self;
}

#pragma mark - PUBLIC

- (BOOL)isEqualToFixture:(GIGURLFixture *)fixture
{
    if (![fixture isKindOfClass:self.class]) return NO;
    
    return ([fixture.name isEqualToString:self.name] && [fixture.mocks isEqualToDictionary:self.mocks]);
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _mocks = [aDecoder decodeObjectForKey:@"mocks"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_mocks forKey:@"mocks"];
}

@end
