//
//  DetailsViewController.h
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (nonatomic,strong) NSString *messageGUID;
@property (weak, nonatomic) IBOutlet UILabel *reminderName;
@property (weak, nonatomic) IBOutlet UILabel *reminderDate;

@end
