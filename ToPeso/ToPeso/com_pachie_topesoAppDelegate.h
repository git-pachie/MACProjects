//
//  com_pachie_topesoAppDelegate.h
//  ToPeso
//
//  Created by pachie on 27/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface com_pachie_topesoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong)NSString *DevinceToken;
@property (nonatomic) bool isFromNotification;
@property (nonatomic, strong) NSString *notficationCountryCode;
@property (nonatomic, strong) NSString *notifcationAgentID;
@property (nonatomic, strong) NSString *appVersion;







- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end
