//
//  EntMessages.h
//  TestCorData2
//
//  Created by pachie on 8/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface EntMessages : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSString * deletedBy;
@property (nonatomic, retain) NSDate * deletedDate;
@property (nonatomic, retain) NSNumber * isDeleted1;
@property (nonatomic, retain) NSNumber * isRead;
@property (nonatomic, retain) NSString * messageID;
@property (nonatomic, retain) NSString * pickupLineAnswer;
@property (nonatomic, retain) NSString * pickupLineContent;
@property (nonatomic, retain) NSString * pickupLineGUID;
@property (nonatomic, retain) NSDate * readDate;
@property (nonatomic, retain) NSString * senderPhoneNumber;
@property (nonatomic, retain) NSString * toPhoneNumber;

@end
