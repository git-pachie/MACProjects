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



@end
