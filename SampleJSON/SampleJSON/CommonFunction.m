//
//  CommonFunction.m
//  SampleJSON
//
//  Created by pachie on 14/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CommonFunction.h"

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
    
    result = [NSString stringWithFormat:@"http://www.amanawaterpark.ph:1980/myjson/service1.svc/%@",MethodToCall];
    
    //http://www.amanawaterpark.ph:1980/myjson/service1.svc/GetHiritMessage"
    
    return result;
}
@end
