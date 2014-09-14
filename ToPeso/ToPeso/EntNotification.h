//
//  EntNotification.h
//  ToPeso
//
//  Created by pachie on 15/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntNotification : NSObject

@property (nonatomic, strong) NSString * agentName;
@property (nonatomic, strong) NSString * countryCode;
@property (nonatomic, strong) NSString * countryName;
@property (nonatomic, strong) NSString * currencyKey;
@property (nonatomic, strong) NSDate * lastUpdated;
@property (nonatomic, strong) NSString * remittanceGUID;

@end
