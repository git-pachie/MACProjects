//
//  MainViewController.m
//  TestJSON
//
//  Created by pachie on 7/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "MainViewController.h"
#import "ActivationViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize DeviceGUID;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation*/
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"SegActivateDevice"])
    {
        ActivationViewController *translationQuizAssociateVC = [segue destinationViewController];
        
        translationQuizAssociateVC.deviceID = DeviceGUID;
//        ActivationViewController.nodeID = self.nodeID; //--pass nodeID from ViewNodeViewController
//        ActivationViewController.contentID = self.contentID;
//        ActivationViewController.index = self.index;
//        ActivationViewController.content = self.content;
    }
    
    
 
}


- (IBAction)btnclick:(id)sender {
    
    NSString *UUID = [[NSUUID UUID] UUIDString];
    
    DeviceGUID = UUID;
    
    NSString *post = [NSString stringWithFormat:@"http://www.riverwayauto.com:1980/myjson/Service1.svc/RegisterUser/archieangeles@gmail.com/archie/85713568/%@",DeviceGUID];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLenght = [NSString stringWithFormat:@"%d", [data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSURLResponse *response;
    NSData *POSTReply = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    NSString *theReply = [[NSString alloc] initWithBytes:[POSTReply bytes] length:[POSTReply length] encoding: NSASCIIStringEncoding];
    NSLog(@"Reply: %@", theReply);
    
    if ([theReply isEqualToString:@"true"]) {
        NSLog(@"Yes");
        [self performSegueWithIdentifier:@"SegActivateDevice" sender:sender];
    }
    else{
        NSLog(@"No");
    }
}
@end
