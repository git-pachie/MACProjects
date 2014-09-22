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

- (void)getLastesAgent :(NSString *)lastModified withBlock:(void (^)(NSArray *array, NSError *er ))block
{
    
    //CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    //NSString *post = [NSString stringWithFormat:@"%@/GetLaterCountry/20130916061301PM",toPisoURL];
    
    NSString *post =[NSString stringWithFormat:@"%@GetLatesAgent/%@",self.getToPisoURL,lastModified];
    
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
                                           

                                           NSString *address = [dataDict objectForKey:@"address"];
                                           NSString *asofDate = [dataDict objectForKey:@"asofDate"];
                                           NSString *contact = [dataDict objectForKey:@"contact"];
                                           NSString *countryCode = [dataDict objectForKey:@"countryCode"];
                                           NSString *currencyKey = [dataDict objectForKey:@"currencyKey"];
                                           NSString *emailAddress = [dataDict objectForKey:@"emailAddress"];
                                           NSString *lastupdated = [dataDict objectForKey:@"lastupdated"];
                                           NSString *logo = [dataDict objectForKey:@"logo"];
                                           NSString *rate = [dataDict objectForKey:@"rate"];
                                           NSString *remittanceName = [dataDict objectForKey:@"remittanceName"];
                                           NSString *remittanceGUID = [dataDict objectForKey:@"remittanceGUID"];
                                           NSString *isDeleted = [dataDict objectForKey:@"isDeleted"];
                                           
                                           
                                           NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:
                                                                       address,@"address"
                                                                       ,asofDate,@"asofDate"
                                                                       ,contact,@"contact"
                                                                       ,countryCode,@"countryCode"
                                                                       ,currencyKey,@"currencyKey"
                                                                       ,emailAddress,@"emailAddress"
                                                                       ,lastupdated,@"lastupdated"
                                                                       ,logo,@"logo"
                                                                       ,rate,@"rate"
                                                                       ,remittanceName,@"remittanceName"
                                                                       ,remittanceGUID,@"remmittanceGUID"
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


-(void)syncNotificationToServer : (NSURL *)url notificationData:(NSDictionary *)dic CompletionBlock:(void(^)(bool succeeded, NSError *error))completionBlock
{
//    NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 @"", @"notificationGUID"
//                                 , @"DEVID", @"deviceUDID"
//                                 , @"QWERQWERQWERQWre",@"remittanceGUID"
//                                 , @"TESTAGENT",@"agentName"
//                                 , @"SG",@"countryCode"
//                                 , @"SINGAPORE",@"countryName"
//                                 , @"PHP-USD",@"currencyKey"
//                                 , @"2014-09-09 12:12:12 PM",@"lastUpdated"
//                                 , @"2014-09-09 12:12:12 PM",@"dateCreated"
//                                 , @"true",@"isInsertDelete",
//                                 nil];
    
    
    //NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:@"ASDFQWRASDFASREFWERQWERQWER",@"sessionID", nil];
    //NSString *operationName = @"InsertNotification";
    
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    urlRequest.URL = url;
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    [urlRequest setHTTPBody:jsonData];
   
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error && data.length > 0) {
            NSError *jsonError = nil;
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (!jsonError && [jsonObj isKindOfClass:[NSDictionary class]]) {
                // process result here
                if ([jsonObj isEqualToString:@"1"]) {
                    completionBlock(false,jsonError);
                }
            } else {
                // error handling
                completionBlock(true,jsonError);
            }
        } else {
            // error handling
            completionBlock(false,error);
        }
    }];

}


-(void)deleteAllNotificationToServer : (NSURL *)url notificationData:(NSDictionary *)dic CompletionBlock:(void(^)(bool succeeded, NSError *error))completionBlock
{
    
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
    urlRequest.URL = url;
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:NULL];
    [urlRequest setHTTPBody:jsonData];
    
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error && data.length > 0) {
            NSError *jsonError = nil;
            id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (!jsonError && [jsonObj isKindOfClass:[NSDictionary class]]) {
                // process result here
                if ([jsonObj isEqualToString:@"1"]) {
                    completionBlock(false,jsonError);
                }
            } else {
                // error handling
                completionBlock(true,jsonError);
            }
        } else {
            // error handling
            completionBlock(false,error);
        }
    }];
    
}



@end
