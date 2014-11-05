//
//  com_pachie_topesoAppDelegate.m
//  ToPeso
//
//  Created by pachie on 27/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "com_pachie_topesoAppDelegate.h"
#import "CoreDataToPeso.h"
#import "SendAndRequest.h"
#import "CountryMainTableViewController.h"
#import "AgentDetailsTableViewController.h"



@implementation com_pachie_topesoAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    // Override point for customization after application launch.
//    self.window.backgroundColor = [UIColor whiteColor];
//    [self.window makeKeyAndVisible];
    
//    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
//    //[core insertTempData];
//    SendAndRequest *send = [[SendAndRequest alloc]init];
//    
//    [send getLastesCountry:^(NSArray *array) {
//        //NSLog(@"%@",array);
//        
//        for (NSArray *dic in array) {
//            NSLog(@"%@",dic);
//            
//        }
//        
//        [core syncCoreData:array];
//        
//    }];
    
    
    //UIApplication *application = [UIApplication sharedApplication];
    
//    self.DevinceToken = @"1111111111";
//
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topbg.png"] forBarMetrics:UIBarMetricsDefault];

    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:255/255.0 green:122/255.0 blue:28/255.0 alpha:1.0]];

    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeSound
                                                                                             |UIRemoteNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }

    NSDictionary* userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    
    if (userInfo != nil) {
        
       // [[self window] makeKeyAndVisible];
        
        
        
        UITabBarController *tab =(UITabBarController *)self.window.rootViewController;
        
        tab.selectedIndex = 0;
        
        UINavigationController *nav = (UINavigationController *)[tab selectedViewController];
        
        CountryMainTableViewController *dv = [[CountryMainTableViewController alloc]init];
        
        dv = [[nav viewControllers] objectAtIndex:0];
        
        com_pachie_topesoAppDelegate *del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
        
        del.isFromNotification = true;
        
        del.notficationCountryCode = [userInfo objectForKey:@"countryCode"];
        
        del.notifcationAgentID = [userInfo objectForKey:@"remittanceGUID"];
        
        [dv LoadFromNotification:[userInfo objectForKey:@"remittanceGUID"]];
        
        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber - 1;
        
        
        //[nav.visibleViewController.navigationController pushViewController:dv animated:YES];
        

    }
    
    self.appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    return YES;
}


#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
{
    //handle the actions
    if ([identifier isEqualToString:@"declineAction"]){
    }
    else if ([identifier isEqualToString:@"answerAction"]){
    }
}
#endif


-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"deviceToken: %@", deviceToken);
    
    NSString *strToken = [NSString stringWithFormat:@"%@",deviceToken];
    strToken = [strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    self.DevinceToken = strToken;
    
  //  CommonSendRequest *common = [[CommonSendRequest alloc]init];
    //[common InsertDeviceToken:self.DevinceToken];
//    [common InsertDeviceToken:self.DevinceToken withBlock:^(NSString *phoneNumber) {
//        self.PhoneNumber = phoneNumber;
//    }];
    
    
    SendAndRequest *send = [[SendAndRequest alloc]init];
    [send pingServer:self.DevinceToken AppVersion:self.appVersion];
}



-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Error in registration. Error: %@", error);
    self.DevinceToken = @"1111111111";
 //   CommonSendRequest *common = [[CommonSendRequest alloc]init];
    //[common InsertDeviceToken:self.DevinceToken];
//    [common InsertDeviceToken:self.DevinceToken withBlock:^(NSString *phoneNumber) {
//        self.PhoneNumber = phoneNumber;
//    }];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    if (application.applicationState == UIApplicationStateActive ) {
        
        return;
    }
    
    NSLog(@"%@",userInfo);
    
    
    [[self window] makeKeyAndVisible];
    
    
    UITabBarController *tab =(UITabBarController *)self.window.rootViewController;
    
    tab.selectedIndex = 0;
    
    UINavigationController *nav = (UINavigationController *)[tab selectedViewController];
    
     CountryMainTableViewController *dv = [[CountryMainTableViewController alloc]init];
//    
    dv = [[nav viewControllers] objectAtIndex:0];
//    
    com_pachie_topesoAppDelegate *del = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
//    
    del.isFromNotification = true;
//    
    del.notficationCountryCode = [userInfo objectForKey:@"countryCode"];
//    
    del.notifcationAgentID = [userInfo objectForKey:@"remittanceGUID"];
//    
    [dv LoadFromNotification:[userInfo objectForKey:@"remittanceGUID"]];
//    
//    application.applicationIconBadgeNumber = application.applicationIconBadgeNumber - 1;
   // AgentDetailsTableViewController *dv = [[AgentDetailsTableViewController alloc]init];
    
//    CoreDataToPeso *core = [[CoreDataToPeso alloc]init];
//    [core getNotificationData:del.notifcationAgentID withBlock:^(Remittance *rem, Country *country) {
//        //dv.remitanceAgent = rem;
       // dv.country = country;
        
        
        
        //UINavigationController *navController = (UINavigationController *)self.window.rootViewController;
        //AgentDetailsTableViewController *notificationViewController = [[AgentDetailsTableViewController alloc] init];
        
       // CountryMainTableViewController *dv = [[CountryMainTableViewController alloc]init];
        
       // dv = [[nav viewControllers] objectAtIndex:0] ;
        
        
        
        //dv.remitanceAgent = rem;
        //dv.country = country;
        
//        
//        AgentDetailsTableViewController *viewController = [[AgentDetailsTableViewController alloc] init];
//        
//        viewController.remitanceAgent = rem;
//        viewController.country = country;
//        
        // [self presentViewController:viewController animated:YES completion:nil];
        //[dv presentViewController:viewController animated:YES completion:nil];
        
        //[self presentViewController:viewController animated:YES completion:nil];

        
        //[navController.visibleViewController.navigationController pushViewController:notificationViewController animated:YES];
        
        //[navController.visibleViewController.navigationController pushViewController:notificationViewController];
        
        //[nav presentViewController:viewController animated:YES completion:nil];
       // [nav performSegueWithIdentifier:@"agentDetails" sender:self];
        
//    }];

    
    
    
    
    
    
    

    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ToPeso" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ToPeso.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}




@end
