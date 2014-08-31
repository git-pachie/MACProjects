//
//  CommonFunction.h
//  SampleJSON
//
//  Created by pachie on 14/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonFunction : NSObject

-(BOOL)CheckNSD:(NSData *)yourData;
-(NSString *)GetJsonConnection:(NSString *)MethodToCall;
//- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string;
//-(void) SortObjects:(NSMutableArray *)ArraryToSort CountedOjbect:(NSCountedSet *) countedset;


+(UIRefreshControl *)CommonRefreshControl:(SEL)MethodToCall Controller:(UITableViewController *)controller;
+(NSString *)ProfieImageURLByPhone :(NSString *)phoneNumber;
+(NSString *)ProfileImageFileName;
+(NSDate *)mfDateFromDotNetJSONString:(NSString *)string;


@end
