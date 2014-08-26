//
//  Settings2ViewController.m
//  PickupLines
//
//  Created by pachie on 25/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "Settings2ViewController.h"
#import "AppDelegate.h"
#import "CustomStringClass.h"
#define DataDownloaderRunMode @"myapp.run_mode" 

@interface Settings2ViewController ()

@end

@implementation Settings2ViewController

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

- (IBAction)uploadImage:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIImage * img = [UIImage imageNamed:@"profile.png"];
//    
//     NSData *imageData = @"frontImage";
//   // NSData *imageData = UIImageJPEGRepresentation(img,0.2);
//    
//    
//    [self.myimage setImage:img];
//    
//    
//    
//    
//    
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.3.100/myjson/service1.svc/UploadFile?fileName=ffff.jpg"]];
//    
//    [request setHTTPMethod:@"POST"];
//    
//    
//    
//    NSString *boundary = @"xxxxBoundaryStringxxxx";
//    
//    
//    
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//    
//    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//    
//    
//    
//    NSMutableData *body = [NSMutableData data];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"iphoneimage.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[NSData dataWithData:imageData]];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [request setHTTPBody:body];
//    
//    [request addValue:[NSString stringWithFormat:@"%d", [imageData length]] forHTTPHeaderField:@"Content-Length"];
//    
//    
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//    NSLog(@"%@", returnString);
//    
//    
    
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    
    //NSData *imageData = UIImagePNGRepresentation(img);//[[appDelegate currentProjectData] objectForKey:@"frontImage"];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.3.100/myjson/service1.svc/UploadFile?fileName=ffff.jpg"]];
//    
//    //NSMutableURLRequest *request = [[[NSMutableURLRequest alloc] init] autorelease];
//    //[request setURL:[NSURL URLWithString:urlString]];
//    [request setHTTPMethod:@"POST"];
//    
//    NSString *boundary = @"---------------------------14737809831466499882746641449";
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    
//    NSMutableData *body = [NSMutableData data];
//    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"profile.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [body appendData:[NSData dataWithData:imageData]];
//    
//    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [request setHTTPBody:body];
//    
//    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
//    
//    BOOL success = [returnString isEqualToString:@"ok"];
//    //[returnString release];
//
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", [CustomStringClass UrlProfileUpload ],appDelegate.PhoneNumber];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileName]];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:@"http://192.168.3.100/myjson/service1.svc/UploadFile?fileName=ffff.jpg"
//                                                                cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                                            timeoutInterval:60];
//    
    [request setHTTPMethod:@"POST"];
    
    // We need to add a header field named Content-Type with a value that tells that it's a form and also add a boundary.
    // I just picked a boundary by using one from a previous trace, you can just copy/paste from the traces.
    NSString *boundary = @"----WebKitFormBoundarycC4YiaUFwM44F6rT";
    
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    // end of what we've added to the header
    
    // the body of the post
    NSMutableData *body = [NSMutableData data];
    
    // Now we need to append the different data 'segments'. We first start by adding the boundary.
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    // Now append the image
    // Note that the name of the form field is exactly the same as in the trace ('attachment[file]' in my case)!
    // You can choose whatever filename you want.
    [body appendData:[@"Content-Disposition: form-data; name=\"attachment[file]\";filename=\"picture.png\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // We now need to tell the receiver what content type we have
    // In my case it's a png image. If you have a jpg, set it to 'image/jpg'
    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    // Now we append the actual image data
    [body appendData:[NSData dataWithData:imageData]];
    
    // and again the delimiting boundary
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
    // adding the body we've created to the request
    [request setHTTPBody:body];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request
                                                                  delegate:self
                                                          startImmediately:NO]; 
    
    [connection scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:DataDownloaderRunMode]; 
    
    [connection start];
}




@end
