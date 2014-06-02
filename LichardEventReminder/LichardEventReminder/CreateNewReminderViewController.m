//
//  CreateNewReminderViewController.m
//  LichardEventReminder
//
//  Created by Archie Angeles on 29/5/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CreateNewReminderViewController.h"

@interface CreateNewReminderViewController ()

@end

@implementation CreateNewReminderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _txtRecipient.text = [self.currentReminder createdByNo];
    _txtReminderBody.text = [self.currentReminder reminderBody];
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    _txtReminderDate.text = [dateFormat stringFromDate:[self.currentReminder reminderDate]];
    
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnCancel:(id)sender {
    
    [self.ReminderDelegate AddReminderDidCancel:[self currentReminder]];
}

- (IBAction)btnDone:(id)sender {
    
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    [self.currentReminder setReminderGUID:uuid];
    
    [self.currentReminder setReminderBody:_txtReminderBody.text];
    
    [self.currentReminder setReminderType:@"Birthday"];
    
    [self.currentReminder setCreatedByNo:@"87654321"];
    
    [self.currentReminder setCreatedToNo:@"0987654321"];
    

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    //[self.currentCourse setReleaseDate:[dateFormat dateFromString:_dateField.text]];
    
    [self.currentReminder setReminderDate:[dateFormat dateFromString:_txtReminderDate.text]];
    
    [self.currentReminder setCreatedDate:[dateFormat dateFromString:_txtReminderDate.text]];
    
    
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init] ;
    [inFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *parsed = [inFormat dateFromString:_txtReminderDate.text];
    
    inFormat.dateFormat =@"MMMM - yyyy";
    
    NSString * monthString = [[inFormat stringFromDate:parsed] capitalizedString];
    NSLog(@"Mont String is :%@",monthString);
    [self.currentReminder setReminderDateGroup:monthString];
    [self.ReminderDelegate  AddReminderDidSave];
}
@end
