//
//  WebLoading.h
//  JSONParser
//
//  Created by Admin on 1/13/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WebLoading : NSObject

+ (void)loadFromURL:(NSURL*)url callback:(void (^)(UIImage *image))callback;

@end
