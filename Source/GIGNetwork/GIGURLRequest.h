//
//  GIGURLRequest.h
//  gignetwork
//
//  Created by Sergio Baró on 26/02/15.
//  Copyright (c) 2015 Gigigo. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GIGConstants.h"
#import "GIGURLFile.h"
#import "GIGURLResponse.h"

@class GIGURLConnectionBuilder;
@class GIGURLRequestLogger;
@class GIGURLManager;


extern NSTimeInterval const GIGURLRequestTimeoutDefault;
extern NSTimeInterval const GIGURLRequestFixtureDelayDefault;
extern NSTimeInterval const GIGURLRequestFixtureDelayNone;


typedef void(^GIGURLRequestCompletion)(id response);
typedef void(^GIGURLRequestProgress)(float progress); // 0.0 to 1.0
typedef NSURLCredential* (^GIGURLRequestCredential)(NSURLAuthenticationChallenge *challenge);


@interface GIGURLRequest : NSObject
<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSString *method;
@property (strong, nonatomic) NSString *url;
@property (assign, nonatomic) NSURLRequestCachePolicy cachePolicy;
@property (assign, nonatomic) NSTimeInterval timeout;
@property (strong, nonatomic) NSDictionary *headers;
@property (strong, nonatomic) NSDictionary *parameters;
@property (strong, nonatomic) NSArray *files; // GIGURLFile instances
@property (strong, nonatomic) NSDictionary *json;
@property (strong, nonatomic) Class responseClass; // GIGURLResponse or subclass

@property (strong, nonatomic) NSString *requestTag;
@property (assign, nonatomic) GIGLogLevel logLevel;
@property (assign, nonatomic) NSTimeInterval fixtureDelay;
@property (assign, nonatomic) BOOL ignoreSSL;

@property (copy, nonatomic) GIGURLRequestCompletion completion;
@property (copy, nonatomic) GIGURLRequestProgress downloadProgress;
@property (copy, nonatomic) GIGURLRequestProgress uploadProgress;
@property (copy, nonatomic) GIGURLRequestCredential authentication;

- (instancetype)initWithMethod:(NSString *)method url:(NSString *)url;
- (instancetype)initWithMethod:(NSString *)method url:(NSString *)url manager:(GIGURLManager *)manager;
- (instancetype)initWithMethod:(NSString *)method url:(NSString *)url
             connectionBuilder:(GIGURLConnectionBuilder *)connectionBuilder
                 requestLogger:(GIGURLRequestLogger *)requestLogger
                       manager:(GIGURLManager *)manager NS_DESIGNATED_INITIALIZER;

- (void)send;
- (void)cancel;

- (void)setHTTPBasicUser:(NSString *)user password:(NSString *)password;

@end