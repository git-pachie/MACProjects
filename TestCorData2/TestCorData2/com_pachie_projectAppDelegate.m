//
//  com_pachie_projectAppDelegate.m
//  TestCorData2
//
//  Created by pachie on 8/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "com_pachie_projectAppDelegate.h"
#import "EntMessages.h"

@implementation com_pachie_projectAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //[self GetLastMessage];
    
    //[self isMessageAlreadyExist:@"1665bf34-cc2a-4eb5-8787-c2c5a7f5c38f"];
    
    //return true ;
    
    
    
    //NSArray *mArray = [[NSArray alloc]init];
    
    NSString *lastMessage = [self GetLastMessage];
    
    [self getUserMessageByNumber:@"85713568" MyFriendPhoneNumber:@"88888888" LastMessageID:lastMessage  withBlock:^(NSMutableArray *array) {
        //mArray = array];
        
        
                NSManagedObjectContext *context = [self managedObjectContext];
        
                // Create a new managed object
        
        

        
        for (NSDictionary *dic in array) {
            
             NSManagedObject *newMessage = [NSEntityDescription insertNewObjectForEntityForName:@"EntMessages" inManagedObjectContext:context];
            
            NSDate * dateCreated =[self mfDateFromDotNetJSONString:[dic objectForKey:@"DateCreated"]];
            NSString * deletedBy= [dic objectForKey:@"DeletedBy"];
            NSDate * deletedDate= [self mfDateFromDotNetJSONString:[dic objectForKey:@"DeletedDate"]];
            
            NSNumber * isDeleted1=[self ConvertStringToYesNoNumber:[dic objectForKey:@"IsDeleted"]] ;
            
            NSNumber * isRead= [self ConvertStringToYesNoNumber:[dic objectForKey:@"IsRead"]];
            NSString * messageID= [dic objectForKey:@"MessageID"];
            NSString * pickupLineAnswer=[NSString stringWithFormat:@"%@",[dic objectForKey:@"PickupLineAnswer"]] ;
            NSString * pickupLineContent= [dic objectForKey:@"PickupLineContent"];
            NSString * pickupLineGUID = [dic objectForKey:@"PickupLineGUID"];
            NSDate * readDate= [self mfDateFromDotNetJSONString:[dic objectForKey:@"ReadDate"]];
            NSString * senderPhoneNumber= [dic objectForKey:@"SenderPhoneNumber"];
            NSString * toPhoneNumber= [dic objectForKey:@"ToPhoneNumber"];
            
            
            if ([self isMessageAlreadyExist:messageID] == NO) {
                [newMessage setValue:dateCreated forKey:@"dateCreated"];
                [newMessage setValue:deletedBy forKey:@"deletedBy"];
                [newMessage setValue:deletedDate forKey:@"deletedDate"];
                [newMessage setValue:isDeleted1 forKey:@"isDeleted1"];
                [newMessage setValue:isRead forKey:@"isRead"];
                [newMessage setValue:messageID forKey:@"messageID"];
                [newMessage setValue:pickupLineAnswer forKey:@"pickupLineAnswer"];
                [newMessage setValue:pickupLineContent forKey:@"pickupLineContent"];
                [newMessage setValue:pickupLineGUID forKey:@"pickupLineGUID"];
                [newMessage setValue:readDate forKey:@"readDate"];
                [newMessage setValue:senderPhoneNumber forKey:@"senderPhoneNumber"];
                [newMessage setValue:toPhoneNumber forKey:@"toPhoneNumber"];
                
                //[newMessage setValue:self.versionTextField.text forKey:@"version"];
                //[newDevice setValue:self.companyTextField.text forKey:@"company"];
                
                NSError *error = nil;
                // Save the object to persistent store
                if (![context save:&error]) {
                    NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
                }
            }
            
            
           // NSLog(@"test object %@",[dic objectForKey:@"PickupLineAnswer"]);
        }
        
        
        
        
        
        
    }];
    
    return YES;
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
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TestCorData2" withExtension:@"momd"];
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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TestCorData2.sqlite"];
    
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



#pragma mark - custom
- (void)getUserMessageByNumber: (NSString *)phoneNumber MyFriendPhoneNumber:(NSString *) myfriendPhoneNumber LastMessageID :(NSString *) lastMessageID withBlock:(void (^)(NSMutableArray *array))block {
    
    //CommonFunction *common = [[CommonFunction alloc]init];
    
    //NSString *post = [common GetJsonConnection:@"GetHiritMessage2"];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    NSString *post =[NSString stringWithFormat:@"http://192.168.3.100/WcfService2/Service1.svc/GetMyMessageByNumberLast/%@/%@/%@",phoneNumber,myfriendPhoneNumber,lastMessageID];
    
    [request setURL:[NSURL URLWithString:post]];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue currentQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //NSLog(@"dataAsString %@", [NSString stringWithUTF8String:[data bytes]]);
                               NSError *error1;
                               NSMutableDictionary * innerJson = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                               
                               //NSLog(@"innerJson %@", innerJson);
                               
                               NSMutableArray *ax = [[NSMutableArray alloc]init];
                               
                               
                               for (NSMutableDictionary *dataDict in innerJson) {
                                   NSString *messageID = [dataDict objectForKey:@"MessageID"];
                                   NSString *senderPhoneNumber = [dataDict objectForKey:@"SenderPhoneNumber"];
                                   NSString *toPhoneNumber = [dataDict objectForKey:@"ToPhoneNumber"];
                                   NSString *pickupLineGUID = [dataDict objectForKey:@"PickupLineGUID"];
                                   NSString *pickupLineContent = [dataDict objectForKey:@"PickupLineContent"];
                                   NSString *pickupLineAnswer = [dataDict objectForKey:@"PickupLineAnswer"];
                                   NSString *isRead = [dataDict objectForKey:@"IsRead"];
                                   NSString *dateCreated = [dataDict objectForKey:@"DateCreated"];
                                   //NSString *createdByPhonNumber = [dataDict objectForKey:@"CreatedByPhonNumber"];
                                   
                                   NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:             messageID,@"MessageID"
                                                               ,senderPhoneNumber,@"SenderPhoneNumber"
                                                               ,toPhoneNumber,@"ToPhoneNumber"
                                                               ,pickupLineGUID,@"PickupLineGUID"
                                                               ,pickupLineContent,@"PickupLineContent"
                                                               ,pickupLineAnswer,@"PickupLineAnswer"
                                                               ,isRead,@"IsRead"
                                                               ,dateCreated,@"DateCreated"
                                                               // ,createdByPhonNumber,@"CreatedByPhonNumber"
                                                               ,nil];
                                   
                                   [ax addObject:dictionary];
                                   
                                   
                               }
                               
                               block(ax); // Call back the block passed into your method
                           }];
    
}

- (NSDate *)mfDateFromDotNetJSONString:(NSString *)string {
    
    if (string == nil) {
        return nil;
    }
    
    static NSRegularExpression *dateRegEx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateRegEx = [[NSRegularExpression alloc] initWithPattern:@"^\\/date\\((-?\\d++)(?:([+-])(\\d{2})(\\d{2}))?\\)\\/$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    NSTextCheckingResult *regexResult = [dateRegEx firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (regexResult) {
        // milliseconds
        NSTimeInterval seconds = [[string substringWithRange:[regexResult rangeAtIndex:1]] doubleValue] / 1000.0;
        // timezone offset
        if ([regexResult rangeAtIndex:2].location != NSNotFound) {
            NSString *sign = [string substringWithRange:[regexResult rangeAtIndex:2]];
            // hours
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:3]]] doubleValue] * 60.0 * 60.0;
            // minutes
            seconds += [[NSString stringWithFormat:@"%@%@", sign, [string substringWithRange:[regexResult rangeAtIndex:4]]] doubleValue] * 60.0;
        }
        
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

-(NSNumber *)ConvertStringToYesNoNumber:(NSString *)string
{
    NSNumber  *aNum = [NSNumber numberWithInteger: [string integerValue]];
    //NSLog(@"%@",aNum);//NSString to NSNumber
    //NSInteger number=[string intValue];
    
    return aNum;
    
//    if ([string  isEqual:@"NO"]) {
//        return 1;
//    }
//    else
//    {
//        return 0;
//    }
}

-(NSString *)GetLastMessage
{
    EntMessages *ent ;//= [[EntMessages alloc]init];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntMessages"inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setEntity:entity];

   
    // Results should be in descending order of timeStamp.
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:NO];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSArray *results = [context executeFetchRequest:request error:NULL];
    //entity *latestEntity = [results objectAtIndex:0];
    if ([results count] == 0) {
        return @"-1";
    }
    else
    {
        ent  = [results objectAtIndex:0];
        return   ent.messageID ;
    }
    
}

-(BOOL)isMessageAlreadyExist:(NSString * )messageGUID
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity =    [NSEntityDescription entityForName:@"EntMessages"   inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSPredicate *pred =[NSPredicate predicateWithFormat:@"(messageID = %@)", messageGUID];
    [request setPredicate:pred];
    
    //NSManagedObject *matches = nil;
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    if ([objects count] == 0) {
        return  false;
    } else {
        return  true;
    }
    
    return  false;
}


-(NSFetchedResultsController *)SyncMessageCorData:(NSArray *)messageArrary
{
    NSManagedObjectContext *context = [self managedObjectContext];
    

    
    NSFetchRequest* request = [NSFetchRequest fetchRequestWithEntityName:@"EntMessages"];
    //request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", self];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:NO]];
//    return [[NSFetchedResultsController alloc] initWithFetchRequest:request
//                                               managedObjectContext:context
//                                                 sectionNameKeyPath:nil
//                                                          cacheName:nil];
//    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    
    return controller;
    
}



@end
