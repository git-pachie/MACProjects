//
//  NotificationTableViewController.h
//  ToPeso
//
//  Created by pachie on 15/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NotificationTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong)NSFetchedResultsController *fetched;


@end
