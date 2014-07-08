//
//  EditReminderViewController.h
//  LichardEventReminder
//
//  Created by Archie Angeles on 2/6/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder.h"
#import "CreateNewReminderViewController.h"






@interface EditReminderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtRecipientNo;
@property (weak, nonatomic) IBOutlet UITextField *txtReminderDate;
@property (weak, nonatomic) IBOutlet UITextView *txtReminderBody;

@property (strong, nonatomic) Reminder *selectedReminder;


- (IBAction)done:(id)sender;



@end

