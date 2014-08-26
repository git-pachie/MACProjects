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
    return @"http://www.riverwayauto.com:1980/myjson/service1.svc/%@";
}
+(NSString *)UrlProfileImageConnection
{
    return @"http://www.riverwayauto.com:1980/PickupLinesProfile/profileimage.aspx?fFileName=";
}

+(NSString *)UrlProfileUpload
{
    return  @"http://www.riverwayauto.com:1980/myjson/service1.svc/UploadFile?fileName=";
}

@end
