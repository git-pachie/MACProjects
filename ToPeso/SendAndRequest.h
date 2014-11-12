//
//  SendAndRequest.h
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendAndRequest : NSObject

- (void)getLastesCountry :(NSString *)lastModified withBlock:(void (^)(NSArray *array, NSError *er ))block;

- (void)getLastesAgent :(NSString *)lastModified withBlock:(void (^)(NSArray *array, NSError *er ))block;

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

-(void)syncNotificationToServer : (NSURL *)url notificationData:(NSDictionary *)dic CompletionBlock:(void(^)(bool succeeded, NSError *error))completionBlock;

-(void)deleteAllNotificationToServer : (NSURL *)url notificationData:(NSDictionary *)dic CompletionBlock:(void(^)(bool succeeded, NSError *error))completionBlock;

-(void)pingToPisoServer : (NSURL *)url notificationData:(NSDictionary *)dic CompletionBlock:(void(^)(bool succeeded, NSError *error))completionBlock;

-(NSString*)getToPisoURL;
+(NSString *)UrlImageConnection;

-(void)pingServer :(NSString *)deviceToken AppVersion:(NSString *)appVersion;
+(NSURL *)AppStoreLink;

@end
