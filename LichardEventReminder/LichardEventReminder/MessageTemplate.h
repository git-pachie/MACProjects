//
//  MessageTemplate.h
//  LichardEventReminder
//
//  Created by pachie on 28/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MessageTemplate : NSManagedObject

@property (nonatomic, retain) NSString * templateBody;
@property (nonatomic, retain) NSNumber * templateId;

@end
