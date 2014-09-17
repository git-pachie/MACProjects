//
//  SendAndRequest.m
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "SendAndRequest.h"
#import "CommonFunction.h"


@implementation SendAndRequest

-(NSString*)getToPisoURL
{
    return @"http://192.168.3.100/ToPisoWCF/Service1.svc/";
}


- (void)getLastesCountry :(NSString *)lastModified withBlock:(void (^)(NSArray *array ))block
{
    
    //CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //NSString *post = [NSString stringWithFormat:@"%@/GetLaterCountry/20130916061301PM",toPisoURL];
    
    NSString *post =[NSString stringWithFormat:@"%@GetLaterCountry/%@",self.getToPisoURL,lastModified];
    
    [request setURL:[NSURL URLWithString:post]];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSArray * innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                               
                               //NSLog(@"innerJson %@", innerJson);
                               
                               NSMutableArray *ax = [[NSMutableArray alloc]init];
                               
                               for (NSDictionary *dataDict in innerJson) {
                                   NSString *countryCode = [dataDict objectForKey:@"countryCode"];
                                   NSString *countryFlag = [dataDict objectForKey:@"countryFlag"];
                                   NSString *countryName = [dataDict objectForKey:@"countryName"];
                                   NSString *lastModified = [dataDict objectForKey:@"lastModified"];
                                   NSString *isDeleted = [dataDict objectForKey:@"isDeleted"];
                                   
                                   
                                   NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:
                                                               countryCode,@"countryCode"
                                                               ,countryFlag,@"countryFlag"
                                                               ,countryName,@"countryName"
                                                               ,lastModified,@"lastModified"
                                                               ,isDeleted,@"isDeleted"
                                                               ,nil];
                                   
                                   [ax addObject:dictionary];
                                   
                               }
                               
                               
                               
                               block(ax); // Call back the block passed into your method
                           }];
    
}

@end
