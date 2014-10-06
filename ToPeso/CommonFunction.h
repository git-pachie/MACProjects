//
//  CommonFunction.h
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject

+ (NSDate *)mfDateFromDotNetJSONString:(NSString *)string;
+ (NSString *)getToPisoInstallURL;
+ (NSString *)getToPisoEmailAddress;
+ (NSString *)getToPisoFacebookURL;
+ (NSString *)getToPisoTwitterURL;

@end
