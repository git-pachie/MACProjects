//
//  TMListTableViewController.h
//  LichardEventReminder
//
//  Created by pachie on 29/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TMListTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSManagedObjectContext *mangedObjectContext;
@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end
