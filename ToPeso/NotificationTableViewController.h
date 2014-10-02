//
//  NotificationTableViewController.h
//  ToPeso
//
//  Created by pachie on 15/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface NotificationTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, ADBannerViewDelegate>

@property (nonatomic, strong)NSFetchedResultsController *fetched;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnEdit;

- (IBAction)acEdit:(id)sender;

@end
