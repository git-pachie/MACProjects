//
//  SendAndRequest.m
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "SendAndRequest.h"


@implementation SendAndRequest


- (void)getLastesCountry :(void (^)(NSMutableArray *array))block
{
    
    //CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //NSString *post = [NSString stringWithFormat:@"%@/GetLaterCountry/20130916061301PM",toPisoURL];
    
    NSString *post = @"http://192.168.3.100/ToPisoWCF/Service1.svc/GetLaterCountry/20130916061301PM";
    
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

@end
