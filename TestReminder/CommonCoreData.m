//
//  CommonCoreData.m
//  TestReminder
//
//  Created by pachie on 31/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CommonCoreData.h"
#import "AppDelegate.h"

@implementation CommonCoreData


+ (NSArray *)GetReminderArray:(NSPredicate *)FilterPredicate
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =   [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Reminders1"   inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    
    //    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(reminderDate >= %@)", [NSDate dateWithTimeIntervalSinceNow:1]];
    //
    //    [request setPredicate:predicate];
    
    
    if (FilterPredicate != nil) {
        [request setPredicate:FilterPredicate];
    }
    
    NSError *error;
    
    //dataArray = [[NSArray alloc]init];
    
   return  [context executeFetchRequest:request error:&error];

}

@end
