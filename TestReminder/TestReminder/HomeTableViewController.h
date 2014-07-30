//
//  HomeTableViewController.h
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *lblReminderName;
@property (weak, nonatomic) IBOutlet UIImageView *image1;


@property (nonatomic, strong)NSString *notificationID;


-(void)CallFromNotification;

@end
