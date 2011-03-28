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
    NSMutableDictionary *result = [parser parseFromString:@"{\"access_token\":\"1/flzfd8dJ7HW0TOd1yArXRwwS51WsrmNKmhHfTNxEWro\",\"expires_in\":3600,\"refresh_token\":\"1/JHOliXZ_XQeX4pLhG7nyWpVwywDYYGrJzqn9XCJfhmA\"}"];
    NSLog(@"%@", [result objectForKey:@"access_token"]);
    NSLog(@"%f", [[result objectForKey:@"expires_in"] doubleValue]);
    NSLog(@"%@", [result objectForKey:@"refresh_token"]);
    NSMutableDictionary *result2 = [parser parseFromString:@"{\"access_token\":\"1/flzfd8dJ7HW0TOd1yArXRwwS51WsrmNKmhHfTNxEWro\",\"expires_in\":3600,\"refresh_token\":\"1/JHOliXZ_XQeX4pLhG7nyWpVwywDYYGrJzqn9XCJfhmA\"}"];
    NSLog(@"%@", [result2 objectForKey:@"access_token"]);
    NSLog(@"%f", [[result2 objectForKey:@"expires_in"] doubleValue]);
    NSLog(@"%@", [result2 objectForKey:@"refresh_token"]);
//    NSMutableDictionary *result = [parser parseFromString:@"  { \"access_token\" : \"123.4\", \"hge\" : [ 1, 2, 3], }"];
//    NSMutableArray *ar = [result objectForKey:@"hge"];
//    for (id e in [result objectForKey:@"hge"]) {
//        NSLog(@"%f", [e doubleValue]);
//    }

    [pool drain];
    return 0;
}

