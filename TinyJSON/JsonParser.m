//
//  JsonParser.m
//  TinyJSON
//
//  Created by 西谷 明洋 on 11/03/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonParser.h"
#import "TokenStream.h"

@implementation JsonParser

- (id)init {
    if ((self = [super init]) != nil) {
        
    }
    return self;
}

- (void)dealloc {
    [tokenStream release];
    [super dealloc];
}

/* [Grammar]
 *
 * OBJECT -> "{" OBJECT-CONTENTS "}"
 *
 * OBJECT-CONTENTS -> STRING ":" VALUE "," OBJECT-CONTENTS
 * OBJECT-CONTENTS -> STRING ":" VALUE
 * OBJECT-CONTENTS -> ""
 *
 * ARRAY -> "[" ARRAY-CONTENTS "]"
 * ARRAY-CONTENTS -> VALUE "," ARRAY-CONTENTS
 * ARRAY-CONTENTS -> ""
 *
 * VALUE -> STRING
 * VALUE -> NUMBER
 * VALUE -> OBJECT
 * VALUE -> ARRAY
 * VALUE -> "true" | "false" | "null"
 */

- (id)value {
    // stub
    return nil;
}

- (NSMutableDictionary*)objectContents:(NSMutableDictionary*)dict {
    Token *t = [tokenStream getToken];
    if (!t) return nil;

    t = [tokenStream getToken];
    if (!t || t->kind != 's') return nil;
    NSLog(@"objectContetns : find string : %@", t->value);

    t = [tokenStream getToken];
    if (!t || t->kind != ':') return nil;

    id val = [self value];
    // add 
    
    return nil;
}

- (NSMutableDictionary*)object {
    Token *t = [tokenStream getToken];
    if (!t || t->kind != '{') return nil;

    NSMutableDictionary *result = [[[NSMutableDictionary alloc] init] autorelease];
    [self objectContents:result];

    t = [tokenStream getToken];
    if (!t || t->kind != '}') return nil;
    return result;
}

- (NSDictionary*)parseFromString:(NSString*)input {
    tokenStream = [[TokenStream alloc] initWithString:input];
    return [self object];
}

@end
