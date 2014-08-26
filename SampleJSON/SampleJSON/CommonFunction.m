//
//  CommonFunction.m
//  SampleJSON
//
//  Created by pachie on 14/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CommonFunction.h"

#define ProfileImageURL    @"http://www.riverwayauto.com:1980/PickupLinesProfile/profileimage.aspx?fFileName="

@implementation CommonFunction

-(BOOL)CheckNSD:(NSData *)yourData
{
    if (yourData == nil) {
        return  false;
    }
    else
    {
        return true;
    }
}

-(void)ConnectionError
{
//    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
//                                                message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//    
//    [mes show];

}

-(NSString *)GetJsonConnection:(NSString *)MethodToCall
{
     NSString *result = nil;
    
    result = [NSString stringWithFormat:@"http://www.riverwayauto.com:1980/myjson/service1.svc/%@",MethodToCall];
    
    //http://www.amanawaterpark.ph:1980/myjson/service1.svc/GetHiritMessage"
    
    return result;
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

+(NSString *)ProfieImageURLByPhone :(NSString *)phoneNumber
{
    NSString *number = [phoneNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@")" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    number = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([number length] >7) {
         number = [number substringFromIndex:[number length]-8];
    }
    
    
   
    
    
    return [NSString stringWithFormat:@"%@/%@",ProfileImageURL,number];
}

@end
