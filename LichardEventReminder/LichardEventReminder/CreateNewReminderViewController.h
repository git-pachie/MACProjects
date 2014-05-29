//
//  CreateNewReminderViewController.h
//  LichardEventReminder
//
//  Created by Archie Angeles on 29/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reminder.h"

@protocol AddReminderDelegate;


@interface CreateNewReminderViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *txtRecipient;
@property (weak, nonatomic) IBOutlet UITextField *txtReminderDate;
@property (weak, nonatomic) IBOutlet UITextView *txtReminderBody;

@property (nonatomic,strong) Reminder *currentReminder;

@property (nonatomic,weak) id <AddReminderDelegate> ReminderDelegate;

- (IBAction)btnCancel:(id)sender;
- (IBAction)btnDone:(id)sender;

@end

@protocol AddReminderDelegate

-(void)AddReminderDidSave;
-(void)AddReminderDidCancel:(Reminder *)reminderDelete;



@end
