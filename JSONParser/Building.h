//
//  Building.h
//  JSONParser
//
//  Created by Admin on 1/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Building : NSObject

@property (nonatomic, strong) NSString *urlForImage;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionOfBuild;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

-(instancetype)initFromDictionary:(NSDictionary *)data;

@end
