//
//  Country.h
//  ToPeso
//
//  Created by pachie on 14/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Country : NSManagedObject

@property (nonatomic, retain) NSString * countryCode;
@property (nonatomic, retain) NSString * countryFlag;
@property (nonatomic, retain) NSString * countryName;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSString * isDeleted1;

@end
