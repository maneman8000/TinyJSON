//
//  JsonParserTest.m
//  TinyJSON
//
//  Created by 西谷 明洋 on 11/03/28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TokenStreamTest.h"


@implementation TokenStreamTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testCreate {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@""];
    STAssertNotNil(tokenStream, @"test create");
}

- (void)testGetTokenZeroLength {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@""];
    Token *t = [tokenStream getToken];
    STAssertNil(t, @"getToken nil");
}

- (void)testGetTokenOnlyWhite {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"  \n\r\t "];
    Token *t = [tokenStream getToken];
    STAssertNil(t, @"getToken nil");
}

- (void)testGetTokenSymbols1 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" {\n : } "];
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == '{', @"kind %c", t->kind);
    STAssertNil(t->value, @"value nil");
    
    t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == ':', @"kind %c", t->kind);
    STAssertNil(t->value, @"value nil");

    t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == '}', @"kind %c", t->kind);
    STAssertNil(t->value, @"value nil");

    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenSymbols2 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" [\n ] "];
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == '[', @"kind %c", t->kind);
    STAssertNil(t->value, @"value nil");
    
    t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == ']', @"kind %c", t->kind);
    STAssertNil(t->value, @"value nil");
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenNumbers1 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"  -123.456789"];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 'n', @"kind %c", t->kind);
    STAssertEquals([t->value doubleValue], -123.456789, @"value %f", [t->value doubleValue]);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenNumbers2 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"0.000009"];

    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 'n', @"kind %c", t->kind);
    STAssertEquals([t->value doubleValue], 0.000009, @"value %f", [t->value doubleValue]);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenNumbers3 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" 0.00000 -12"];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 'n', @"kind %c", t->kind);
    STAssertEquals([t->value doubleValue], 0.0, @"value %f", [t->value doubleValue]);

    t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 'n', @"kind %c", t->kind);
    STAssertEquals([t->value doubleValue], -12.0, @"value %f", [t->value doubleValue]);

    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenNumbers4 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"0"];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 'n', @"kind %c", t->kind);
    STAssertEquals([t->value doubleValue], 0.0, @"value %f", [t->value doubleValue]);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString1 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" \"abcde\""];
   
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"abcde"], @"value %@", t->value);

    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString2 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" \"abcde\"  \"a\""];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"abcde"], @"value %@", t->value);
    
    t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"a"], @"value %@", t->value);

    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString3 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"\"\""];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@""], @"value %@", t->value);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString4 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"\"abcd"];
    
    Token *t = [tokenStream getToken];
    STAssertNil(t, @"error string");

    t = [tokenStream getToken];
    STAssertNil(t, @"error string 2");
}

- (void)testGetTokenString5 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@"\""];
    
    Token *t = [tokenStream getToken];
    STAssertNil(t, @"error string");
    
    t = [tokenStream getToken];
    STAssertNil(t, @"error string 2");
}

- (void)testGetTokenString6 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" \"123.0\"  "];

    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"123.0"], @"value %@", t->value);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString7 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" \"I am\n :dog,\""];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"I am\n :dog,"], @"value %@", t->value);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

- (void)testGetTokenString8 {
    TokenStream *tokenStream = [[TokenStream alloc] initWithString:@" \"abc\\\"hoge\\\"\"  "];
    
    Token *t = [tokenStream getToken];
    STAssertNotNil(t, @"not nil");
    STAssertTrue(t->kind == 's', @"kind %c", t->kind);
    STAssertTrue([t->value isEqualToString:@"abc\"hoge\""], @"value %@", t->value);
    
    t = [tokenStream getToken];
    STAssertNil(t, @"getToken end");
}

@end
