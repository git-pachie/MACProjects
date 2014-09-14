//
//  MyNotification.h
//  ToPeso
//
//  Created by pachie on 15/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Notification1 : NSManagedObject

@property (nonatomic, retain) NSString * agentName;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSString * currencyKey;
@property (nonatomic, retain) NSDate * lastUpdated;
@property (nonatomic, retain) NSString * remittanceGUID;

@end
