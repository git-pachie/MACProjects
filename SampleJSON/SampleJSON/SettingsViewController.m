//
//  SettingsViewController.m
//  PickupLines
//
//  Created by pachie on 25/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendImage:(id)sender {
    
    UIImage * img = [UIImage imageNamed:@"profile.png"];
    
    NSData *imageData = UIImageJPEGRepresentation(img,0.2);
    
    
    
    
    
    
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.3.100/myjson/UploadMe/TestService.svc/REST/UploadFile?fileName=ffff.jpg"]];
    
    [request setHTTPMethod:@"POST"];
    
    
    
    NSString *boundary = @"xxxxBoundaryStringxxxx";
    
    
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    
    
    NSMutableData *body = [NSMutableData data];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"iphoneimage.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[NSData dataWithData:imageData]];
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    [request addValue:[NSString stringWithFormat:@"%d", [imageData length]] forHTTPHeaderField:@"Content-Length"];
    
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", returnString);
}
@end
