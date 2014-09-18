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
    return @"http://www.greetify.net:1980/ToPisoWCF/Service1.svc/";
}


+(NSString *)UrlImageConnection
{
    return @"http://www.greetify.net:1980/PickupLinesProfile2/countryimage.aspx?fFilename=";
}

- (void)getLastesCountry :(NSString *)lastModified withBlock:(void (^)(NSArray *array, NSError *er ))block
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
                               NSMutableArray *ax = [[NSMutableArray alloc]init];
                               
                               if (error ==nil) {
                                   NSArray * innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                                   
                                   //NSLog(@"innerJson %@", innerJson);
                                   
                                   if (error1 != nil) {
                                       error = error1;
                                       
                                   }
                                   else
                                   {
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
                                   }
                                   
                                   
                               }
                               
                               
                               block(ax,error); // Call back the block passed into your method
                           }];
    
}



- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
    
    
}
@end
