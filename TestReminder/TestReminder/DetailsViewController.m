//
//  DetailsViewController.m
//  TestReminder
//
//  Created by pachie on 29/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "DetailsViewController.h"
#import "AppDelegate.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
    NSLog(@"MessageGUID %@",self.messageGUID);
    

    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context =   [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc =    [NSEntityDescription entityForName:@"Reminders1"   inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    //    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(reminderDescription = %@)", _name.text];
    //    [request setPredicate:pred];
    //NSManagedObject *matches = nil;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(messageGUID = %@)", self.messageGUID];
    
    [request setPredicate:predicate];
    
    NSError *error;
    
    NSArray *dataArray = [[NSArray alloc]init];
    
    dataArray = [context executeFetchRequest:request error:&error];
    
    NSManagedObject *mn = [dataArray objectAtIndex:0];
    
    
    self.reminderName.text = [mn valueForKey:@"reminderName"];
    
    NSDateFormatter *dateFormatter;
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm a"];
    
    NSString *convertedString = [dateFormatter stringFromDate:[mn valueForKey:@"reminderDate"]];

    
    
    self.reminderDate.text = convertedString;
    
    
    
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

@end
