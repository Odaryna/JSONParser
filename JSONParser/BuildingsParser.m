//
//  BuildingsParser.m
//  JSONParser
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BuildingsParser.h"

@implementation BuildingsParser

+ (NSArray *)parseJSONtoDictionary:(NSData *)JSON
{
    NSDictionary *dataFromJSON = nil;
    NSError *error = nil;
    id parsedJSON = [NSJSONSerialization JSONObjectWithData:JSON options:0 error:&error];
    if (!error)
    {
        if ([parsedJSON isKindOfClass:[NSDictionary class]])
        {
            dataFromJSON = (NSDictionary *)parsedJSON;
        }
    }
    else
    {
        NSLog(@"Error parsing JSON data: %@", [error localizedDescription]);
    }
    
    return [dataFromJSON objectForKey:@"Result"];
}

@end
