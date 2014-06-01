//
//  Reminder.h
//  LichardEventReminder
//
//  Created by Archie Angeles on 1/6/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Reminder : NSManagedObject

@property (nonatomic, retain) NSString * createdByNo;
@property (nonatomic, retain) NSDate * createdDate;
@property (nonatomic, retain) NSString * createdToNo;
@property (nonatomic, retain) NSString * reminderBody;
@property (nonatomic, retain) NSDate * reminderDate;
@property (nonatomic, retain) NSString * reminderGUID;
@property (nonatomic, retain) NSString * reminderType;
@property (nonatomic, retain) NSString * reminderDateGroup;

@end
