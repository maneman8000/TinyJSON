//
//  main.m
//  TinyJSON
//
//  Created by 西谷 明洋 on 11/03/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JsonParser.h"

int main (int argc, const char * argv[])
{

    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

    JsonParser *parser = [[JsonParser alloc] init];
    NSMutableDictionary *result = [parser parseFromString:@"  { \"access_token\" : \"123.4\" }"];
    // insert code here...
    for (id key in [result allKeys]) {
        NSLog(@"%@ -> %@", key, [result objectForKey:key]);
    }

    [pool drain];
    return 0;
}

