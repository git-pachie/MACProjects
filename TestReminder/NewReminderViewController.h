//
//  NewReminderViewController.h
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface NewReminderViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDate;
- (IBAction)insertReminder:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *reminderDescription;

@end
