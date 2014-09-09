//
//  CustomStringClass.m
//  PickupLines
//
//  Created by Archie Angeles on 27/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "CustomStringClass.h"



@implementation CustomStringClass

+(NSString *)UrlJSonConnection
{
    return @"http://www.greetify.net/myjson/Service1.svc/%@";
}
+(NSString *)UrlProfileImageConnection
{
    return @"http://www.greetify.net/PickupLinesProfile/profileimage.aspx?fFileName=";
}

+(NSString *)UrlProfileUpload
{
    return  @"http://www.greetify.net/myjson/service1.svc/UploadFile?fileName=";
}


+(void)ApplyRountedBorderToButton :(UIButton *)button
{
    button.layer.cornerRadius = button.frame.size.height /2 ;// 10;
    button.alpha = 0.6;
    button.backgroundColor = [UIColor purpleColor];

}
@end
