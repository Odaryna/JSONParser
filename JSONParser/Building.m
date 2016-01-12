//
//  Building.m
//  JSONParser
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "Building.h"

@implementation Building

-(instancetype)initFromDictionary:(NSDictionary *)data
{
    if (self = [super init])
    {
        self.title = [data objectForKey:@"Title"];
        self.descriptionOfBuild = [data objectForKey:@"Description"];
        self.urlForImage = [data objectForKey:@"ImageUrl"];
        self.latitude = [[data objectForKey:@"Latitude"] doubleValue];
        self.longitude = [[data objectForKey:@"longitude"] doubleValue];
    }
    
    return self;
}

@end
