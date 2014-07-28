//
//  HomeViewController.m
//  SampleLocalNotification
//
//  Created by pachie on 28/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "HomeViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear : here");
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

- (IBAction)createNotification:(id)sender {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"First Notification Blog Posted at iOScreator.com";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:@"10", @"myKey1", nil];
    
    localNotification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

- (IBAction)createNotification2:(id)sender {
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    localNotification.alertBody = @"Second Nofication Blog Posted at iOScreator.com";
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    localNotification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    NSDictionary *infoDict2 = [NSDictionary dictionaryWithObjectsAndKeys:@"2", @"myKey2", nil];
    
    localNotification.userInfo = infoDict2;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

-(void)CallOtherView
{
    [self performSegueWithIdentifier:@"segone" sender:self];
}

-(void)CallOtherView2
{
    [self performSegueWithIdentifier:@"segtwo" sender:self];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"User Info %@", self.notificationID);
    
    if([segue.identifier isEqualToString:@"segone"])
        
    {
        
        OneViewController *dv = segue.destinationViewController;
        dv.messageID = self.notificationID;
        

        
        
        
    }else if([segue.identifier isEqualToString:@"segtwo"]){
        
        
         TwoViewController *dv = segue.destinationViewController;
        dv.messageID = self.notificationID;

        
    }
    
}

@end
