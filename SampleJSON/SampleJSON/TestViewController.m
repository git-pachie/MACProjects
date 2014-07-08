//
//  TestViewController.m
//  SampleJSON
//
//  Created by Archie Angeles on 6/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "TestViewController.h"
#import "DeviceActivationViewController.h"
#import "HomeTableViewController.h"



@interface TestViewController ()

-(id)jsonPostRequest:(NSData *)jsonRequestData;

@end

@implementation TestViewController


@synthesize DeviceGUID, txtEmailAddress, txtPhoneNumber,SuccessRegistration;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
//    [txtEmailAddress setText:@""];
//    [txtPhoneNumber setText:@""];
//    
//    if ([SuccessRegistration isEqualToString:@"YES"]) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        
//    }
//    else{
////        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"View did appear"
////                                                    message:@"view did appear" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
////        
////        [mes show];
//        NSLog(@"SuccessRegistration :%@",SuccessRegistration);
//    }
    

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 //   NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
//    
//    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
//    
//    
//    NSString *UUID = [prefs stringForKey:@"deviceguid"];
//    
//    if (UUID == nil) {
//        UUID = [[NSUUID UUID] UUIDString];
//        
//        [prefs setObject:DeviceGUID forKey:@"deviceguid"];
//    }
//
    
//    DeviceGUID = uniqueIdentifier;
    
//    NSString *url =[NSString stringWithFormat:@"http://www.riverwayauto.com:1980/WcfService2/Service1.svc/GetUserByDeviceID/%@",DeviceGUID];
//    
//    NSData *allCoursesData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
//    
//    NSError *error;
//    NSMutableDictionary *allCourses = [NSJSONSerialization JSONObjectWithData:allCoursesData options:NSJSONReadingMutableContainers error:&error];
//    
//    if (error) {
//        NSLog(@"%@",[error localizedDescription]);
//    }
//    else {
//        //NSArray *monday = allCourses[@"Monday"];
//        for ( NSDictionary *user in allCourses )
//            {
//                NSLog(@"Checking if device is already registered with device id %@", DeviceGUID);
//                //NSLog(@"Title: %@", theCourse[@"title"] );
//                
//                DeviceGUID = user[@"DeviceGUID"];
//                _Email = user[@"Email"];
//                _PhoneNumber = user[@"PhoneNumber"];
//                _isDeviceActivated = user[@"isDeviceActivated"];
//                
//            }
//        
//        
//        
//       
//    }
//    
//    
//    if (_isDeviceActivated == nil) {
//        return;
//    }
//    else
//    {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
//
//        if ([_isDeviceActivated isEqualToString:@"NO"]) {
//            //[self performSegueWithIdentifier:@"SegActivateDevice" sender:sender];
//            
//            DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
//            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//            vc.deviceGUID = DeviceGUID;
//            
//            [self presentViewController:vc animated:YES completion:nil];
//            
//        }
//        else
//        {
//        
//            HomeTableViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"home"];
//            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//            vc.deviceGUID = DeviceGUID;
//            vc.phoneNumber = _PhoneNumber;
//            
//            [self presentViewController:vc animated:YES completion:nil];
//        }
//    }
//

    
    
    // saving an NSString
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([segue.identifier isEqualToString:@"SegActivateDevice"]){
        
        
        DeviceActivationViewController *controller = (DeviceActivationViewController *)segue.destinationViewController;
        controller.deviceGUID = DeviceGUID;
        
    }
    else if ([segue.identifier isEqualToString:@"SegDeviceActivated"])
    {
        HomeTableViewController *controller = (HomeTableViewController *)segue.destinationViewController;
        controller.deviceGUID = DeviceGUID;
    }
}


- (IBAction)getDataFromJSon:(id)sender {
    
    
    
}

- (IBAction)sendDataToJSON:(id)sender {
    
//    
//    "DateCreated":"\/Date(1404548576073+0800)\/","DateModified":null,"Email":"pachie.angeles@gmail.com","9876546",@:"96646585","UserID":103,"UserName":"pachie"
    
//    NSString *phonNumber = [self.txtPhoneNumber text];
//    NSString *emailEmail = [self.txtEmailAddress text];
//    
//    NSString *UUID = [[NSUUID UUID] UUIDString];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:emailEmail,@"Email",phonNumber,@"PhoneNumber",@"pachie",@"UserName",UUID,@"DeviceGUID", nil];
//    
//    if ([NSJSONSerialization isValidJSONObject:dict]) {
//        NSError *error = nil;
//        
//        NSData *result = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
//        
//
//        
//        if (error == nil && result != nil) {
//            NSLog(@"You have json object");
//            [self jsonPostRequest:result];
//            
//            
//            
//            
//        }
//    }
    
    
    
    
    //DeviceGUID = UUID;
    
    if ([txtPhoneNumber.text isEqualToString:@""] || [txtEmailAddress.text isEqualToString:@""])
    {
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Invalid Input"
                                                    message:@"Phone number and email address must not be empty" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [mes show];
        
        return;

    }
    
    
    NSString *post = [NSString stringWithFormat:@"http://www.riverwayauto.com:1980/myjson/Service1.svc/RegisterUser/%1@/archie/%2@/%3@",txtEmailAddress.text,txtPhoneNumber.text,DeviceGUID];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
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
        //[self performSegueWithIdentifier:@"SegActivateDevice" sender:sender];
        
        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
//        DeviceActivationViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"acid"];
//        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
//        vc.deviceGUID = DeviceGUID;
        
        [self dismissViewControllerAnimated:NO completion:nil];

        
        //[self presentViewController:vc animated:YES completion:nil];
        
       // SuccessRegistration = vc.deviceGUID;
    }
    else{
        NSLog(@"No");
    }
    
    
}

-(id)jsonPostRequest:(NSData *)jsonRequestData
{
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.riverwayauto.com:1980/wcfService2/service1.svc/RegisterUser"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonRequestData length]] forHTTPHeaderField:@"Content-Lenght"];
    [request setHTTPBody:jsonRequestData];
    
    NSURLResponse *response = nil;
    NSError *error = nil;
    
    NSData *result = [ NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                      
    if (error==nil) {
        return  result;
        
        
    }
    
    return  nil;

}
@end
