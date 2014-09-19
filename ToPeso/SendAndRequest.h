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

+(NSString *)UrlImageConnection;

@end
