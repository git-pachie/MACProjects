//
//  SendAndRequest.h
//  ToPeso
//
//  Created by pachie on 16/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendAndRequest : NSObject

- (void)getLastesCountry :(NSString *)lastModified withBlock:(void (^)(NSArray *array ))block;

@end
