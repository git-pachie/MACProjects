//
//  EditReminderViewController.m
//  LichardEventReminder
//
//  Created by Archie Angeles on 2/6/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "EditReminderViewController.h"
#import "AppDelegate.h"
#import "EditReminderViewController.h"


@interface EditReminderViewController ()

@end

@implementation EditReminderViewController

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
    _txtRecipientNo.text = [self.selectedReminder createdToNo];
    _txtReminderBody.text = [self.selectedReminder reminderBody];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"yyyy-MM-dd"];
    
    _txtReminderDate.text = [df stringFromDate:[self.selectedReminder reminderDate]];
    
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

//- (IBAction)btnCancel:(id)sender {
//    //[self AddReminderDidCancel:[self selectedReminder]];
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}

//- (IBAction)btnDone:(id)sender {
//    
//    //[self.selectedReminder setReminderGUID:uuid];
//    
//    [self.selectedReminder  setReminderBody:_txtReminderBody.text];
//    
//    [self.selectedReminder  setReminderType:@"Birthday"];
//    
//    [self.selectedReminder  setCreatedByNo:@"87654321"];
//    
//    [self.selectedReminder  setCreatedToNo:_txtRecipientNo.text];
//    
//    
//    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    
//    //[self.currentCourse setReleaseDate:[dateFormat dateFromString:_dateField.text]];
//    
//    [self.selectedReminder  setReminderDate:[dateFormat dateFromString:_txtReminderDate.text]];
//    
//    [self.selectedReminder  setCreatedDate:[dateFormat dateFromString:_txtReminderDate.text]];
//    
//    
//    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init] ;
//    [inFormat setDateFormat:@"yyyy-MM-dd"];
//    NSDate *parsed = [inFormat dateFromString:_txtReminderDate.text];
//    
//    inFormat.dateFormat =@"MMMM - yyyy";
//    
//    NSString * monthString = [[inFormat stringFromDate:parsed] capitalizedString];
//    NSLog(@"Mont String is :%@",monthString);
//    [self.selectedReminder  setReminderDateGroup:monthString];
//    //[self.ReminderDelegate  AddReminderDidSave];
//    
//    AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
//    [myApp saveContext];
//    
//    //[self dismissModalViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//}
- (IBAction)done:(id)sender {
      [self.selectedReminder  setReminderBody:_txtReminderBody.text];
    
        [self.selectedReminder  setReminderType:@"Birthday"];
    
        [self.selectedReminder  setCreatedByNo:@"87654321"];
    
        [self.selectedReminder  setCreatedToNo:_txtRecipientNo.text];
    
    
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];

        //[self.currentCourse setReleaseDate:[dateFormat dateFromString:_dateField.text]];
    
        [self.selectedReminder  setReminderDate:[dateFormat dateFromString:_txtReminderDate.text]];
    
        [self.selectedReminder  setCreatedDate:[dateFormat dateFromString:_txtReminderDate.text]];
    
    
        NSDateFormatter *inFormat = [[NSDateFormatter alloc] init] ;
        [inFormat setDateFormat:@"yyyy-MM-dd"];
        NSDate *parsed = [inFormat dateFromString:_txtReminderDate.text];
    
        inFormat.dateFormat =@"MMMM - yyyy";
    
        NSString * monthString = [[inFormat stringFromDate:parsed] capitalizedString];
        NSLog(@"Mont String is :%@",monthString);
        [self.selectedReminder  setReminderDateGroup:monthString];
        //[self.ReminderDelegate  AddReminderDidSave];
    
        AppDelegate *myApp = (AppDelegate *) [[UIApplication sharedApplication]delegate];
        [myApp saveContext];
    
        //[self dismissModalViewControllerAnimated:YES];
        //[self dismissViewControllerAnimated:YES completion:nil];
    //[self.navigationController :YES];
       // [self.navigationController  ];

}
@end
