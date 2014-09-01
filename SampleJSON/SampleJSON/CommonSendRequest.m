//
//  CommonSendRequest.m
//  PickupLines
//
//  Created by Archie Angeles on 23/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CommonSendRequest.h"
#import "EntityPerson.h"
#import "CommonFunction.h"
#import "CustomLoader.h"
#import "AppDelegate.h"
#import "CustomStringClass.h"

#define DataDownloaderRunMode @"myapp.run_mode"

@implementation CommonSendRequest



-(BOOL)SendPickupLines: (NSString *) deviceGUID : (NSString *) personNumber : (NSString *) messageGUID
{
    //bool result = false;
    
    CommonFunction *common = [[CommonFunction alloc]init];

    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"SendPickupLine/%1@/%2@/%3@",deviceGUID,personNumber,messageGUID]];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
   
     NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
         {
             if (error)
             {
                 NSLog(@"error: %@",error);
                 
                 //result = false;
             }
             else
             {
                 
                 NSString *theReply;
                 theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
                 NSLog(@"Reply: %@", theReply);
                 
                 theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                 
                 
                 if ( [theReply isEqualToString:@"1"]) {
                     
                     NSLog(@"Pickup line sent: %@", personNumber);
                     //return true;
                     
                 }
                 else{
                     
                     
                     NSLog(@"Error sending pickup lines: %@", personNumber);
                     //return false;
                     //[queue cancelAllOperations];
                     
                     dispatch_async(dispatch_get_main_queue(), ^(void){
                         
                         UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error sending pickup lines" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                         
                         [alert2 show];
                         
                         
                     });
                     
                     
                 }
                 
                 
                 
                 
             }
         }];

    
    return true;
}

-(void)InsertDeviceToken: (NSString *) DeviceToken withBlock:(void (^)(NSString *phoneNumber))block {

    //bool result = false;
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"InsertDeviceToken/%1@",DeviceToken]];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"error: %@",error);
             
             //result = false;
         }
         else
         {
             
             NSString *theReply;
             theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
             NSLog(@"Reply: %@", theReply);
             
             theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             
             if ( [theReply isEqualToString:@"1"]) {
                 
                 NSLog(@"Device token sent: %@", DeviceToken);
                 //return true;
                 
             }
             
             block(theReply);

         }
     }];
    
    
   
}



- (void)getJSONPickupLines:(void (^)(NSDictionary *jsonData))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    [request setURL:[NSURL URLWithString:post]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization
                                                                  JSONObjectWithData:data options:kNilOptions error:&error1
                                                                  ];
                               block(innerJson); // Call back the block passed into your method
                           }];
    
}


- (void)getUserMessage: (NSString *)phoneNumber withBlock:(void (^)(NSMutableArray *array))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"GetDistincMessage/%1@",phoneNumber]];
    
    [request setURL:[NSURL URLWithString:post]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                               
                               NSLog(@"innerJson %@", innerJson);
                               
                               NSMutableArray *ax = [[NSMutableArray alloc]init];
                               
                               for (NSMutableDictionary *dataDict in innerJson) {
                                   NSString *phoneNumber = [dataDict objectForKey:@"PhoneNumber"];
                                   NSString *email = [dataDict objectForKey:@"Email"];
                                   NSString *userName = [dataDict objectForKey:@"UserName"];
                                   
                                   NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:
                                                               phoneNumber,@"PhoneNumber"
                                                               ,email,@"Email"
                                                               ,userName,@"UserName"
                                                               ,nil];
                                   
                                   [ax addObject:dictionary];
                                   
                               }
                               
                               
                               
                               block(ax); // Call back the block passed into your method
                           }];
    
}


- (void)getUserMessageByNumber: (NSString *)phoneNumber MyFriendPhoneNumber:(NSString *) myfriendPhoneNumber withBlock:(void (^)(NSMutableArray *array))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"GetMyMessageByNumber/%1@/%2@",phoneNumber,myfriendPhoneNumber]];
    
    [request setURL:[NSURL URLWithString:post]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                               
                               NSLog(@"innerJson %@", innerJson);
                               
                               NSMutableArray *ax = [[NSMutableArray alloc]init];
                               
                               
                               for (NSMutableDictionary *dataDict in innerJson) {
                                   NSString *messageID = [dataDict objectForKey:@"MessageID"];
                                   NSString *senderPhoneNumber = [dataDict objectForKey:@"SenderPhoneNumber"];
                                   NSString *toPhoneNumber = [dataDict objectForKey:@"ToPhoneNumber"];
                                   NSString *pickupLineGUID = [dataDict objectForKey:@"PickupLineGUID"];
                                   NSString *pickupLineContent = [dataDict objectForKey:@"PickupLineContent"];
                                   NSString *pickupLineAnswer = [dataDict objectForKey:@"PickupLineAnswer"];
                                   NSString *isRead = [dataDict objectForKey:@"IsRead"];
                                   NSString *dateCreated = [dataDict objectForKey:@"DateCreated"];
                                   
                                   NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:             messageID,@"MessageID"
                                                               ,senderPhoneNumber,@"SenderPhoneNumber"
                                                               ,toPhoneNumber,@"ToPhoneNumber"
                                                               ,pickupLineGUID,@"PickupLineGUID"
                                                               ,pickupLineContent,@"PickupLineContent"
                                                               ,pickupLineAnswer,@"PickupLineAnswer"
                                                               ,isRead,@"IsRead"
                                                               ,dateCreated,@"DateCreated"
                                                               ,nil];
                                   
                                   [ax addObject:dictionary];
                               
                               
                               }
                               
                               block(ax); // Call back the block passed into your method
                           }];
    
}






- (void)ConvertJsonToArrary:(NSDictionary *)dictionaryKo withBlock:(void (^)(NSMutableArray *jsonData1))block {
    
    NSMutableArray *myarray = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dataDict in dictionaryKo) {
        NSString *messageGUID = [dataDict objectForKey:@"MessageGUID"];
        NSString *hiritMessage = [dataDict objectForKey:@"HiritMessage"];
        NSString *createdByUserName = [dataDict objectForKey:@"CreatedByUserName"];
        NSString *createdByDeviceID = [dataDict objectForKey:@"CreatedByDeviceID"];
        NSString *createdDate = [dataDict objectForKey:@"CreatedDate"];
        NSString *answer1 = [dataDict objectForKey:@"Answer1"];
        NSString *dateCreatedSTR = [dataDict objectForKey:@"DateCreatedSTR"];
        
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                    messageGUID, @"MessageGUID",
                                    hiritMessage, @"HiritMessage",
                                    createdByUserName,@"CreatedByUserName",
                                    createdByDeviceID,@"CreatedByDeviceID",
                                    [CommonFunction mfDateFromDotNetJSONString:createdDate],@"DateCreated",
                                    answer1, @"Answer1",
                                    dateCreatedSTR,@"DateCreatedSTR",
                                    nil];
        [myarray addObject:dictionary];
        
    }
    
    block(myarray);
    
}


-(void)checkDeviceActivation: (NSString *) deviceToken withBlock:(void (^)(NSString *returnValue))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"CheckDeviceRegistration/%1@",deviceToken]];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"error: %@",error);
             
             //result = false;
         }
         else
         {
//             
             NSString *theReply;
             theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
             NSLog(@"Reply: %@", theReply);
             
             theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             

             if ( [theReply isEqualToString:@"1"]) {
                 
                 NSLog(@"Device token check: %@", theReply);
                 //return true;
                 
             }
//
//             NSError *error1;
//             NSString * innerJson = [NSJSONSerialization
//                                                JSONObjectWithData:data options:kNilOptions error:&error1
//                                                ];

             //innerJson = [innerJson stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             block(theReply);
             
             
         }
     }];
    
    

}

-(void)registerAccount: (NSString *) deviceToken PhoneNumber:(NSString *)phoneNumber withBlock:(void (^)(NSString *returnValue))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"RegisterAccount/%1@/%2@",deviceToken,phoneNumber]];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"error: %@",error);
             
             //result = false;
         }
         else
         {
             //
             NSString *theReply;
             theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
             NSLog(@"Reply: %@", theReply);
             
             theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             
             if ( [theReply isEqualToString:@"1"]) {
                 
                 NSLog(@"Device token check: %@", theReply);
                 //return true;
                 
             }
             //
             //             NSError *error1;
             //             NSString * innerJson = [NSJSONSerialization
             //                                                JSONObjectWithData:data options:kNilOptions error:&error1
             //                                                ];
             
             //innerJson = [innerJson stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             block(theReply);
             
             
         }
     }];
    
    
    
}

-(void)verifyAccount: (NSString *) deviceToken PhoneNumber:(NSString *)phoneNumber ActivationCode:(NSString *)activationCode withBlock:(void (^)(NSString *returnValue))block {
    
    CommonFunction *common = [[CommonFunction alloc]init];
    
    NSString *post = [common GetJsonConnection:[NSString stringWithFormat:@"VerifyAccount/%1@/%2@/%3@",deviceToken,phoneNumber,activationCode]];
    
    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:post]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:data];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if (error)
         {
             NSLog(@"error: %@",error);
             
             //result = false;
         }
         else
         {
             //
             NSString *theReply;
             theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
             NSLog(@"Reply: %@", theReply);
             
             theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             
             if ( [theReply isEqualToString:@"1"]) {
                 
                 NSLog(@"Account activation successfull: %@", theReply);
                 //return true;
                 
             }
             //
             //             NSError *error1;
             //             NSString * innerJson = [NSJSONSerialization
             //                                                JSONObjectWithData:data options:kNilOptions error:&error1
             //                                                ];
             
             //innerJson = [innerJson stringByReplacingOccurrencesOfString:@"\"" withString:@""];
             
             
             block(theReply);
             
             
         }
     }];
    
    
    
}

//-(NSData *)GetPickupLines
//{
//    //bool result = false;
//    
//    
//    
//    CommonFunction *common = [[CommonFunction alloc]init];
//    
//    NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
//    
//    //NSString *x = [common GetJsonConnection:@"GetHiritMessage2"];
//
//    
//    NSData *data = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
//    
//    NSString *postLenght = [NSString stringWithFormat:@"%lu", (unsigned long)[data length]];
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:[NSURL URLWithString:post]];
//    [request setHTTPMethod:@"GET"];
//    //[request setValue:postLenght forHTTPHeaderField:@"Content-Length"];
//    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:data];
//    
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    //NSData *data2;
//    
//    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
//     {
//         if (error)
//         {
//             NSLog(@"error: %@",error);
//             
//             //result = false;
//         }
//         else
//         {
//             
//             
//             NSString *theReply;
//             theReply = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding: NSASCIIStringEncoding];
//             NSLog(@"Reply: %@", theReply);
//             
//             theReply = [theReply stringByReplacingOccurrencesOfString:@"\"" withString:@""];
//             
//             
//             if ( [theReply isEqualToString:@"1"]) {
//                 
//                 //NSLog(@"Pickup line sent: %@", personNumber);
//                 //return true;
//                 
//             }
//             else{
//                 
//                 
//                // NSLog(@"Error sending pickup lines: %@", personNumber);
//                 //return false;
//                 //[queue cancelAllOperations];
//                 
//                 dispatch_async(dispatch_get_main_queue(), ^(void){
//                     
//                     UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error sending pickup lines" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//                     
//                     [alert2 show];
//                     
//                     
//                 });
//                 
//                 
//             }
//             
//             
//             
//             
//         }
//     }];
//    
//    
//    return data;
//}


+(UIImage*)imageWithImage:(UIImage*)image
scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(void)SendProfileToServer: (UIImage *) img
{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //UIImage * img = [UIImage imageNamed:imageName];
    CGSize size123= CGSizeMake(218, 230);
    img = [self imageWithImage:img scaledToSize:size123];
    
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(img)];
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg", [CustomStringClass UrlProfileUpload ],appDelegate.PhoneNumber];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fileName]];
    
   
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
