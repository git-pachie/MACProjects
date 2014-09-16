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


-(void)syncCoreData
{
    
}

@end
