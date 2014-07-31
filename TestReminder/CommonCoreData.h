//
//  CommonCoreData.h
//  TestReminder
//
//  Created by pachie on 31/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonCoreData : NSObject

+ (NSArray *)GetReminderArray:(NSPredicate *)FilterPredicate;

@end
