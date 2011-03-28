//
//  JsonParserTest.m
//  TinyJSON
//
//  Created by 西谷 明洋 on 11/03/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonParserTest.h"


@implementation JsonParserTest

- (void)setUp
{
    [super setUp];

    // Set-up code here.
    pool = [[NSAutoreleasePool alloc] init];
    parser = [[JsonParser alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    [parser release];
    [pool drain];
    
    [super tearDown];
}

- (void)testCreate {
    STAssertNotNil(parser, @"create");
}

- (void)testParse1 {
    NSMutableDictionary *result = [parser parseFromString:@"  { \"access_token\" : 123.4, \"hge\" : \"aa\", }"];
    STAssertNotNil(result, @"parse success");
    STAssertTrue([result count] == 2, @"result count");    
    STAssertEqualObjects([result objectForKey:@"access_token"], [NSNumber numberWithDouble:123.4], @"result 1");
    STAssertEqualObjects([result objectForKey:@"hge"], @"aa", @"result 2");
}

- (void)testParse2 {
    NSMutableDictionary *result = [parser parseFromString:@"{\"access_token\":\"1/flzfd8dJ7HW0TOd1yArXRwwS51WsrmNKmhHfTNxEWro\",\"expires_in\":3600,\"refresh_token\":\"1/JHOliXZ_XQeX4pLhG7nyWpVwywDYYGrJzqn9XCJfhmA\"}"];
    STAssertNotNil(result, @"parse success");
    STAssertTrue([result count] == 3, @"result count");    
    STAssertEqualObjects([result objectForKey:@"access_token"], @"1/flzfd8dJ7HW0TOd1yArXRwwS51WsrmNKmhHfTNxEWro", @"result 1");
    STAssertEqualObjects([result objectForKey:@"expires_in"], [NSNumber numberWithInt:3600], @"result 2");
    STAssertEqualObjects([result objectForKey:@"refresh_token"], @"1/JHOliXZ_XQeX4pLhG7nyWpVwywDYYGrJzqn9XCJfhmA", @"result 1");
}

@end
