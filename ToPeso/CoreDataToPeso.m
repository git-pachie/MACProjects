//
//  CoreDataToPeso.m
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "CoreDataToPeso.h"
#import "com_pachie_topesoAppDelegate.h"
#import "Notification.h"
#import "EntNotification.h"
#import "Country.h"
#import "CommonFunction.h"
#import "Remittance.h"


@implementation CoreDataToPeso
{
    com_pachie_topesoAppDelegate *delegate;
    
}



-(NSFetchedResultsController *)getCountry
{
    if (_fetchedController) {
        return _fetchedController;
        
    }
    

    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Country"];
    
    NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"countryName" ascending:YES];
    
    NSArray *sortedArray = [NSArray arrayWithObjects:sort1, nil];
    
    [request setSortDescriptors:sortedArray];
    
    NSFetchedResultsController *f = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:@"countryName" cacheName:nil];
    
    _fetchedController = f;
    
    
    
    return _fetchedController;
    
}



-(void)insertTempData
{
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest * allCountry = [[NSFetchRequest alloc] init];
    [allCountry setEntity:[NSEntityDescription entityForName:@"Country" inManagedObjectContext:context]];
    [allCountry setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError * error = nil;
    NSArray * countries = [context executeFetchRequest:allCountry error:&error];
    //error handling goes here
    for (NSManagedObject * car in countries) {
        [context deleteObject:car];
    }
    
    NSFetchRequest *allRemittance = [[NSFetchRequest alloc]init];
    
    [allRemittance setEntity:[NSEntityDescription entityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext]];
    [allRemittance setIncludesPropertyValues:NO];
    
    NSArray *remitance = [context executeFetchRequest:allRemittance error:&error];
    
    
    
    for (NSManagedObject * mno in remitance) {
        [context deleteObject:mno];
    }
    
    NSError *saveError = nil;
    [context save:&saveError];
    
    
     Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    
    [newCountry setCountryCode:@"SG"];
    [newCountry setCountryName:@"Singapore"];
    [newCountry setCountryFlag:@"Singapore.png"];
    [newCountry setLastModified:[NSDate date]];
    
    newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    
    
    [newCountry setValue:@"MY"  forKey:@"countryCode"];
    [newCountry setValue:@"Malaysia"  forKey:@"countryName"];
    [newCountry setValue:@"Malaysia.png"  forKey:@"countryFlag"];
    [newCountry setValue:[NSDate date]  forKey:@"lastModified"];
    

    
    
    newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    
    [newCountry setValue:@"HK"  forKey:@"countryCode"];
    [newCountry setValue:@"HongKong"  forKey:@"countryName"];
    [newCountry setValue:@"Hong Kong.png"  forKey:@"countryFlag"];
    [newCountry setValue:[NSDate date]  forKey:@"lastModified"];
    
    
    newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    
    [newCountry setValue:@"DB"  forKey:@"countryCode"];
    [newCountry setValue:@"Dubai"  forKey:@"countryName"];
    [newCountry setValue:@"Dubai.png"  forKey:@"countryFlag"];
    [newCountry setValue:[NSDate date]  forKey:@"lastModified"];
    
    
    
    newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
    [newCountry setValue:@"SA"  forKey:@"countryCode"];
    [newCountry setValue:@"Saudi Arabia"  forKey:@"countryName"];
    [newCountry setValue:@"Saudi Arabia.png"  forKey:@"countryFlag"];
    [newCountry setValue:[NSDate date]  forKey:@"lastModified"];
    
    
    
    
    
    //for temp remittance
    
    
//                                                                        entityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
  
//    
//    @property (nonatomic, retain) NSString * address;
//    @property (nonatomic, retain) NSDate * asofDate;
//    @property (nonatomic, retain) NSString * contact;
//    @property (nonatomic, retain) NSString * countryCode;
//    @property (nonatomic, retain) NSString * emailAddress;
//    @property (nonatomic, retain) NSDate * lastupdated;
//    @property (nonatomic, retain) NSString * logo;
//    @property (nonatomic, retain) NSNumber * rate;
//    @property (nonatomic, retain) NSString * remittanceName;
//    @property (nonatomic, retain) NSString * remmittanceGUID;
//    @property (nonatomic, retain) NSString * currencyKey;
    
    NSEntityDescription *newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"BLK 359 Admiralty Drive 08-192 Singapore 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"85713568" forKey:@"contact"];
    [newRe setValue:@"SG" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:123.56] forKey:@"rate"];
    [newRe setValue:@"iRemit Singapore" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"SGD-PHP" forKey:@"currencyKey"];
    
    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"450 Orchard Road 08-192 Singapore 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"85713568" forKey:@"contact"];
    [newRe setValue:@"SG" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit1.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:223.56] forKey:@"rate"];
    [newRe setValue:@"Kabayan Remittance" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"SGD-PHP" forKey:@"currencyKey"];
    
    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"450 Orchard Road 08-192 Singapore 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"85713568" forKey:@"contact"];
    [newRe setValue:@"SG" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit1.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:263.56] forKey:@"rate"];
    [newRe setValue:@"Money Gram Remittance" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"SGD-PHP" forKey:@"currencyKey"];
    
    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"450 Orchard Road 08-192 Singapore 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"85713568" forKey:@"contact"];
    [newRe setValue:@"SG" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit1.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:63.56] forKey:@"rate"];
    [newRe setValue:@"Pinoy Exchanger" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"USD-PHP" forKey:@"currencyKey"];
    

    
    
    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"450 Orchard Road 08-192 HongKong 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"12345678" forKey:@"contact"];
    [newRe setValue:@"HK" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit22.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:523.56] forKey:@"rate"];
    [newRe setValue:@"iRemit HongKong" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"HKD-PHP" forKey:@"currencyKey"];
    
    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"568 Kamyas Road 08-192 HongKong 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"12345678" forKey:@"contact"];
    [newRe setValue:@"HK" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit233.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:523.56] forKey:@"rate"];
    [newRe setValue:@"PNB HongKong" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"HKD-PHP" forKey:@"currencyKey"];

    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"458 Utot Road 08-192 Saudi Arabia 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"12345678" forKey:@"contact"];
    [newRe setValue:@"SA" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit243.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:523.56] forKey:@"rate"];
    [newRe setValue:@"iRemit Saudi" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"SAR-PHP" forKey:@"currencyKey"];
    

    newRe = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:delegate.managedObjectContext];
    
    [newRe setValue:@"578  Road 08-192 Saudi Arabia 750359" forKey:@"address"];
    [newRe setValue:[NSDate date] forKey:@"asofDate"];
    [newRe setValue:@"12345678" forKey:@"contact"];
    [newRe setValue:@"SA" forKey:@"countryCode"];
    [newRe setValue:@"archieangeles@gmail.com" forKey:@"emailAddress"];
    [newRe setValue:[NSDate date] forKey:@"lastupdated"];
    [newRe setValue:@"remit243.png" forKey:@"logo"];
    [newRe setValue:(NSNumber*)[NSNumber numberWithFloat:623.56] forKey:@"rate"];
    [newRe setValue:@"BKK Saudi" forKey:@"remittanceName"];
    [newRe setValue:[[NSUUID UUID] UUIDString] forKey:@"remmittanceGUID"];
    [newRe setValue:@"SAR-PHP" forKey:@"currencyKey"];
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}


-(void)insertUpdateNotification :(EntNotification *) mynotification EnableDisable:(BOOL)isEnabled
{
    delegate = (com_pachie_topesoAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    

    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSError *error;
    
    if (isEnabled) {
        
        //check if notification already exist
        if ([self isNotificationExist:mynotification]) {
            return;
        }
        
        NSEntityDescription *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Notification" inManagedObjectContext:context];
        
        [entity setValue:mynotification.countryCode forKey:@"countryCode"];
        [entity setValue:mynotification.remittanceGUID forKey:@"remittanceGUID"];
        [entity setValue:mynotification.currencyKey forKey:@"currencyKey"];
        [entity setValue:mynotification.lastUpdated forKey:@"lastUpdated"];
        [entity setValue:mynotification.countryName forKey:@"countryName"];
        [entity setValue:mynotification.agentName forKey:@"agentName"];
        
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
        
        
 
        
//        
//        NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                        @"", @"notificationGUID"
//                                        , @"DEVID", @"deviceUDID"
//                                        , @"QWERQWERQWERQWre",@"remittanceGUID"
//                                        , @"TESTAGENT",@"agentName"
//                                        , @"SG",@"countryCode"
//                                        , @"SINGAPORE",@"countryName"
//                                        , @"PHP-USD",@"currencyKey"
//                                        , @"2014-09-09 12:12:12 PM",@"lastUpdated"
//                                        , @"2014-09-09 12:12:12 PM",@"dateCreated"
//                                        , @"true",@"isInsertDelete",
//                                        nil];
//
//        
//        //NSDictionary *payloadDict = [NSDictionary dictionaryWithObjectsAndKeys:@"ASDFQWRASDFASREFWERQWERQWER",@"sessionID", nil];
//        NSString *operationName = @"InsertNotification";
//        
//        
//        
//        NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] init];
//        urlRequest.URL = [NSURL URLWithString:[@"http://www.greetify.net:1980/ToPisoWCF/Service1.svc/" stringByAppendingString:operationName]];
//                          [urlRequest setHTTPMethod:@"POST"];
//                          [urlRequest addValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-type"];
//                          
//                          NSData *jsonData = [NSJSONSerialization dataWithJSONObject:payloadDict options:0 error:NULL];
//                          [urlRequest setHTTPBody:jsonData];
//                          
//                          //ITLog(@"Issuing request: %@ %@", self.operationName, [self payloadDict]);
//        
//        
//      
//        
//        
//        
//        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
//            if (!error && data.length > 0) {
//                NSError *jsonError = nil;
//                id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
//                if (!jsonError && [jsonObj isKindOfClass:[NSDictionary class]]) {
//                    // process result here
//                } else {
//                    // error handling
//                }
//            } else {
//                // error handling
//            }
//        }];
        
        
//        if ([jsonObject isKindOfClass:[NSArray class]]) {
//            NSArray *dictarr=(NSArray*)jsonObject;
//            NSMutableArray *resultarr=[[NSMutableArray alloc] init];
//            for (NSDictionary *dict in dictarr) {
//                ITJourney *journey =[[ITJourney alloc]initWithDictionary:dict];
//                [resultarr addObject:journey];
//            }
//            // use resultarr from here...
//        }
        
        //build an info object and convert to json
        
        //convert object to data
//        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo options:kNilOptions error:&error];
//        
////        NSError *err;
////        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:newDatasetInfo  options:NSJSONWritingPrettyPrinted error:&err];
//
//        
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:@"http://www.greetify.net:1980/ToPisoWCF/Service1.svc/InsertNotification"]];
//        [request setHTTPMethod:@"POST"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [request setHTTPBody:jsonData];
//        
//        // print json:
//        NSLog(@"JSON summary: %@", [[NSString alloc] initWithData:jsonData
//                                                         encoding:NSUTF8StringEncoding]);
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        [connection start];
//        
        
        
        
        
        
        
        
        
        
        
        
    }
    else
    {
        
        
        
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        [request setEntity:[NSEntityDescription entityForName:@"Notification" inManagedObjectContext:context]];
        
        [request setPredicate:[NSPredicate predicateWithFormat:@"remittanceGUID ==%@",mynotification.remittanceGUID]];
        
        [request setIncludesPropertyValues:NO];
        
        NSArray *array = [context executeFetchRequest:request error:&error];
        
        for (NSManagedObject * mno in array)
        {
            [context deleteObject:mno];
        }
        
        if (![context save:&error]) {
            NSLog(@"Error deleting notification %@",error);
        }
        
    }
    
}

-(BOOL)isNotificationExist :(EntNotification *)entNotification
{
    
    NSError *error;
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Notification" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    [request setEntity:entity];
    
    [request setPredicate:[NSPredicate predicateWithFormat:@"remittanceGUID ==%@",entNotification.remittanceGUID]];
    
    
    
    if([[context executeFetchRequest:request error:&error] count]==0 )
    {
        return false;
    }
    else
    {
        return true;
    }
    
    
    
    //return false;
    
}


-(void)syncCoreData :(NSArray *)arrayCountr 
{
     NSError *error;
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    for (NSDictionary *dic in arrayCountr) {
        
        
        NSFetchRequest *fetch1 = [[NSFetchRequest alloc]initWithEntityName:@"Country"];
        //NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"countryCode" ascending:YES];
        
        [fetch1 setPredicate:[NSPredicate predicateWithFormat:@"countryCode == [cd]%@",[dic objectForKey:@"countryCode"]]];
        
        NSArray *arraryobject = [context executeFetchRequest:fetch1 error:&error];
        
        NSDateFormatter *format  = [[NSDateFormatter alloc]init];
        
        [format setDateStyle:NSDateFormatterFullStyle];
        
        if ([arraryobject count] == 0) {
            //new
            
            Country *newCountry = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
            
            [newCountry setCountryName:[dic objectForKey:@"countryName"]];
            [newCountry setCountryCode:[dic objectForKey:@"countryCode"]];
            [newCountry setCountryFlag:[dic objectForKey:@"countryFlag"]];
            [newCountry setIsDeleted1:[dic objectForKey:@"isDeleted"]];
            
            NSDate *lastmodified = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"lastModified"]];
            
        
            
            [newCountry setLastModified:lastmodified];

        }
        else
        {
            //update
            
            
            Country *newCountry = [arraryobject objectAtIndex:0];
            [newCountry setCountryName:[dic objectForKey:@"countryName"]];
            [newCountry setCountryCode:[dic objectForKey:@"countryCode"]];
            [newCountry setCountryFlag:[dic objectForKey:@"countryFlag"]];
            [newCountry setIsDeleted1:[dic objectForKey:@"isDeleted"]];
            
            
            NSDate *lastmodified = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"lastModified"]];
            [newCountry setLastModified:lastmodified];
            
        }
        
        
        if (![context save:&error]) {
            NSLog(@"Error in country : %@", error);
        }
        
        //image
        
        
    }
    
}

-(void)syncCoreDataAgent :(NSArray *)arrayAgent
{
    NSError *error;
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    for (NSDictionary *dic in arrayAgent) {
        
        
        NSFetchRequest *fetch1 = [[NSFetchRequest alloc]initWithEntityName:@"Remittance"];
        //NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"countryCode" ascending:YES];
        
        [fetch1 setPredicate:[NSPredicate predicateWithFormat:@"remmittanceGUID == [cd]%@",[dic objectForKey:@"remmittanceGUID"]]];
        
        NSArray *arraryobject = [context executeFetchRequest:fetch1 error:&error];
        
        NSDateFormatter *format  = [[NSDateFormatter alloc]init];
        
        [format setDateStyle:NSDateFormatterFullStyle];
        
        if ([arraryobject count] == 0) {
            //new
            
            Remittance *newRem = [NSEntityDescription insertNewObjectForEntityForName:@"Remittance" inManagedObjectContext:context];
            
            [newRem setAddress:[dic objectForKey:@"address"]];
            [newRem setContact:[dic objectForKey:@"contact"]];
            [newRem setCountryCode:[dic objectForKey:@"countryCode"]];
            [newRem setCurrencyKey:[dic objectForKey:@"currencyKey"]];
            [newRem setEmailAddress:[dic objectForKey:@"emailAddress"]];
            [newRem setLogo:[dic objectForKey:@"logo"]];
            [newRem setRemittanceName:[dic objectForKey:@"remittanceName"]];
            [newRem setRemmittanceGUID:[dic objectForKey:@"remmittanceGUID"]];
            [newRem setIsDeleted1:[dic objectForKey:@"isDeleted"]];
            
            NSDate *asofDate = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"asofDate"]];
            [newRem setAsofDate:asofDate];
            
            NSDate *lastupdated = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"lastupdated"]];
            
            [newRem setLastupdated:lastupdated];
    
            
            [newRem setRate:(NSNumber *)[dic objectForKey:@"rate"]];
            
            
        }
        else
        {
            //update
            
            Remittance *newRem = [arraryobject objectAtIndex:0];
            [newRem setAddress:[dic objectForKey:@"address"]];
            [newRem setContact:[dic objectForKey:@"contact"]];
            [newRem setCountryCode:[dic objectForKey:@"countryCode"]];
            [newRem setCurrencyKey:[dic objectForKey:@"currencyKey"]];
            [newRem setEmailAddress:[dic objectForKey:@"emailAddress"]];
            [newRem setLogo:[dic objectForKey:@"logo"]];
            [newRem setRemittanceName:[dic objectForKey:@"remittanceName"]];
            [newRem setRemmittanceGUID:[dic objectForKey:@"remmittanceGUID"]];
            [newRem setIsDeleted1:[dic objectForKey:@"isDeleted"]];
            
            NSDate *asofDate = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"asofDate"]];
            [newRem setAsofDate:asofDate];
            
            NSDate *lastupdated = [CommonFunction mfDateFromDotNetJSONString:[dic objectForKey:@"lastupdated"]];
            
            [newRem setLastupdated:lastupdated];
            
            
            [newRem setRate:(NSNumber *)[dic objectForKey:@"rate"]];        }
        
        
        if (![context save:&error]) {
            NSLog(@"Error in country : %@", error);
        }
        
        //image
        
        
    }
    
}


-(NSString *)getLastUpdatedCountry
{
    NSError *error;
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];

    NSFetchRequest *fetch1 = [[NSFetchRequest alloc]initWithEntityName:@"Country"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"lastModified" ascending:NO];
    
    [fetch1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
   
    
    NSArray *arraryobject = [context executeFetchRequest:fetch1 error:&error];
    
    
    if ([arraryobject count]==0) {
        return @"-1";
    }
    else
    {
        Country *country = [arraryobject objectAtIndex:0];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyyMMddhhmmssa"];
        
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        
        [format setTimeZone:gmt];
        
        return [format stringFromDate:country.lastModified];// country.lastModified
        
    }
    
}

-(NSString *)getLastUpdatedAgent
{
    NSError *error;
    
    delegate = (com_pachie_topesoAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *fetch1 = [[NSFetchRequest alloc]initWithEntityName:@"Remittance"];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"lastupdated" ascending:NO];
    
    [fetch1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    
    
    NSArray *arraryobject = [context executeFetchRequest:fetch1 error:&error];
    
    
    if ([arraryobject count]==0) {
        return @"-1";
    }
    else
    {
        Remittance *rem = [arraryobject objectAtIndex:0];
        
        NSDateFormatter *format = [[NSDateFormatter alloc]init];
        [format setDateFormat:@"yyyyMMddhhmmssa"];
        
        NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        
        [format setTimeZone:gmt];
        
        return [format stringFromDate:rem.lastupdated];// country.lastModified
        
    }
    
}



@end
