//
//  BuildingsParser.h
//  JSONParser
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuildingsParser : NSObject

+ (NSArray *)parseJSONtoDictionary:(NSData *)JSON;

@end
