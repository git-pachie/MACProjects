//
//  Remittance.h
//  ToPeso
//
//  Created by pachie on 14/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Remittance : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDate * asofDate;
@property (nonatomic, retain) NSString * contact;
@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * currencyKey;
@property (nonatomic, retain) NSString * emailAddress;
@property (nonatomic, retain) NSDate * lastupdated;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * remittanceName;
@property (nonatomic, retain) NSString * remmittanceGUID;
@property (nonatomic, retain) NSString * isDeleted1;

@end
