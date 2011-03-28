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
    parser = [[JsonParser alloc] init];
}

- (void)tearDown
{
    // Tear-down code here.
    [parser release];
    
    [super tearDown];
}

- (void)testCreate {
    STAssertNotNil(parser, @"create");
}

- (void)testParse1 {
    NSMutableDictionary *result = [parser parseFromString:@"  { \"access_token\" : 123.4, \"hge\" : \"aa\", }"];
    STAssertNotNil(result, @"parse success");
    NSUInteger cnt = [result count];
    STAssertTrue(cnt == 2, @"result count");    
    STAssertEqualObjects([result objectForKey:@"access_token"], [NSNumber numberWithDouble:123.4], @"result 1");
    STAssertEqualObjects([result objectForKey:@"hge"], @"aa", @"result 2");
}

@end
