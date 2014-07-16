//
//  AppDelegate.h
//  SampleJSON
//
//  Created by Archie Angeles on 6/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSString *isDeviceRegistered;
@property (nonatomic, strong) NSString *DeviceGUID;
@property (nonatomic,strong) NSString *EmailAddress;
@property (nonatomic, strong) NSString *PhoneNumber;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory; 

@end
