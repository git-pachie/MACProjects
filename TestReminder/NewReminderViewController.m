//
//  NewReminderViewController.m
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "NewReminderViewController.h"
#import "AppDelegate.h"

@interface NewReminderViewController ()

@end

@implementation NewReminderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.reminderDescription.delegate = self;
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =   [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Reminders1"   inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
//    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(reminderDescription = %@)", _name.text];
//    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    for (NSManagedObject *ma in objects) {
        NSLog(@"Data %@", [ma valueForKey:@"reminderName"]);
    }
    
//    if ([objects count] == 0) {
//        _status.text = @"No matches";
//    } else {
//        matches = objects[0];
//        _address.text = [matches valueForKey:@"address"];
//        _phone.text = [matches valueForKey:@"phone"];
//        _status.text = [NSString stringWithFormat:@"%lu matches found", (unsigned long)[objects count]];
//    }
    

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

- (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    
    NSLocale *locale = [[NSLocale alloc]
                        initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];
    
    
    NSDate *date = [dateFormatter dateFromString:dateString];
   
    return date;
}
- (IBAction)insertReminder:(id)sender {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =  [appDelegate managedObjectContext];
    NSManagedObject *newReminder;
    NSError *error;
    
    newReminder = [NSEntityDescription insertNewObjectForEntityForName:@"Reminders1" inManagedObjectContext:context];
    
    NSDateFormatter *dateFormatter;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
    
    NSString *convertedString = [dateFormatter stringFromDate:_reminderDate.date];
    
    NSDate *convertedDate = [[NSDate alloc] init];
    convertedDate = [self  dateFromString:convertedString withFormat:@"dd/MM/yyyy hh:mm a"];
    
    
    
    [newReminder setValue: _reminderDescription.text forKey:@"reminderName"];
    [newReminder setValue: convertedDate forKey:@"reminderDate"];
    
    
    [context save:&error];
    NSLog(@"New Reminder Saved");
}


@end
