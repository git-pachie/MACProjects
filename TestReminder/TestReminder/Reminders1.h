//
//  Reminders1.h
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminders1 : NSManagedObject

@property (nonatomic, retain) NSDate * reminderDate;
@property (nonatomic, retain) NSString * reminderName;
@property (nonatomic, retain) NSString * messageGUID;

@end
