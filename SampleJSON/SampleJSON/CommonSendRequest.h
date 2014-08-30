//
//  CommonSendRequest.h
//  PickupLines
//
//  Created by Archie Angeles on 23/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonSendRequest : UITableViewController

-(BOOL)SendPickupLines: (NSString *) deviceGUID : (NSString *) personNumber : (NSString *) messageGUID;

+(void)SendProfileToServer: (UIImage *) img;
- (void)getJSONPickupLines:(void (^)(NSDictionary *jsonData))block;
- (void)ConvertJsonToArrary:(NSDictionary *)dictionaryKo withBlock:(void (^)(NSMutableArray *jsonData1))block;
-(void)InsertDeviceToken: (NSString *) DeviceToken;
@end
