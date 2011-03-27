//
//  JsonParser.m
//  TinyJSON
//
//  Created by 西谷 明洋 on 11/03/27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JsonParser.h"

@interface Token : NSObject {
@public
    // kind of value
    // 's' : string
    // 'n' : number
    // 't' : boolean true
    // 'f' : boolean false
    // '0' : null
    // ':' ',' '{' '}' '[' ']' : symbols
    char kind;
    id value;
}
- (id)initWithKind:(char)k value:(id)v;
+ (id)tokenWithKind:(char)k value:(id)v;
@end

@implementation Token

- (id)initWithKind:(char)k value:(id)v {
    if ((self = [super init]) != nil) {
        kind = k;
        value = [v retain];
    }
    return self;
}

- (void)dealloc {
    [value release];
    [super dealloc];
}

+ (id)tokenWithKind:(char)k value:(id)v {
    return [[[Token alloc] initWithKind:k value:v] autorelease];
}

@end

@interface TokenStream : NSObject {
@private
    NSString *inputString;
    NSRange searchRange;
    NSCharacterSet *notSpaceSet;
    NSCharacterSet *notNumberSet;
    NSCharacterSet *notStringSet;
}
- (id)initWithString:(NSString*)input;
- (Token*)getToken;
@end

@implementation TokenStream

- (id)initWithString:(NSString*)input {
    if ((self = [super init]) != nil) {
        inputString = [input retain];
        searchRange.length = [input length];
        notSpaceSet = [[NSCharacterSet whitespaceAndNewlineCharacterSet] invertedSet];
        notNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@".-0123456789"] invertedSet];
        notStringSet = [[NSCharacterSet characterSetWithCharactersInString:@"\t\r\n\" .,-0123456789:{}[]"] retain];
    }
    return self;
}

- (void)dealloc {
    [inputString release];
    [notSpaceSet release];
    [notNumberSet release];
    [notStringSet release];
    [super dealloc];
}

#define UPDATE_SEARCH_RANGE(SR, R) \
    SR.length -= R.location + R.length - SR.location; \
    SR.location = R.location + R.length;

- (Token*)getToken {
    // skip whitespace
    NSRange r = [inputString rangeOfCharacterFromSet:notSpaceSet options:0 range:searchRange];
    if (r.location >= [inputString length]) return nil;
    UPDATE_SEARCH_RANGE(searchRange, r);
    NSLog(@"{%lu, %lu}", searchRange.location, searchRange.length);
    switch ([inputString characterAtIndex:r.location]) {
        // symbols
        case 0x0022:
            return [Token tokenWithKind:'"' value:nil];
        case 0x002C:
            return [Token tokenWithKind:',' value:nil];
        case 0x003A:
            return [Token tokenWithKind:':' value:nil];
        case 0x005B:
            return [Token tokenWithKind:'[' value:nil];
        case 0x005D:
            return [Token tokenWithKind:']' value:nil];
        case 0x007B:
            return [Token tokenWithKind:'{' value:nil];
        case 0x007D:
            return [Token tokenWithKind:'}' value:nil];
        // number
        case 0x002D:
        case 0x0030: case 0x0031: case 0x0032: case 0x0033: case 0x0034:
        case 0x0035: case 0x0036: case 0x0037: case 0x0038: case 0x0039:
        {
            r = [inputString rangeOfCharacterFromSet:notNumberSet options:0 range:searchRange];
            if (r.location >= [inputString length]) return nil;
            NSRange rr = { searchRange.location - 1, r.location - searchRange.location + 1 };
            UPDATE_SEARCH_RANGE(searchRange, rr);
            return [Token tokenWithKind:'n'
                                  value:[NSNumber numberWithDouble:[[inputString substringWithRange:rr] doubleValue]]];
        }
        // 'unicode string' or 'true' or 'false' or 'null'
        default:
        {
            r = [inputString rangeOfCharacterFromSet:notStringSet options:0 range:searchRange];
            if (r.location >= [inputString length]) return nil;
            NSRange rr = { searchRange.location - 1, r.location - searchRange.location + 1 };
            UPDATE_SEARCH_RANGE(searchRange, rr);
            NSString *result = [inputString substringWithRange:rr];
            if ([result isEqualToString:@"true"]) {
                return [Token tokenWithKind:'t' value:nil];
            }
            else if ([result isEqualToString:@"false"]) {
                return [Token tokenWithKind:'n' value:nil];
            }
            else if ([result isEqualToString:@"null"]) {
                return [Token tokenWithKind:'0' value:nil];
            }
            return [Token tokenWithKind:'s' value:[inputString substringWithRange:rr]];
        }
    }
    return nil;
}

@end

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

- (NSDictionary*)object {
    Token *t = [tokenStream getToken];
    if (t->kind != '{') {
        // TODO: raise error
    }
}

- (NSDictionary*)parseFromString:(NSString*)input {
    tokenStream = [[TokenStream alloc] initWithString:input];
    return [self object];
}

/*
Token *tk = [tokenStream getToken];
if (!tk) { NSLog(@"END1"); return; }
NSLog(@"%c", tk->kind);

tk = [tokenStream getToken];
if (!tk) { NSLog(@"END2"); return; }
NSLog(@"%c", tk->kind);

tk = [tokenStream getToken];
if (!tk) { NSLog(@"END3"); return; }
NSLog(@"%c, %@", tk->kind, tk->value);

tk = [tokenStream getToken];
if (!tk) { NSLog(@"END4"); return; }
NSLog(@"%c", tk->kind);
 */

@end
