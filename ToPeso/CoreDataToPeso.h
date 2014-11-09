//
//  CoreDataToPeso.h
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Notification.h"
#import "EntNotification.h"
#import "Remittance.h"
#import "Country.h"


@interface CoreDataToPeso : NSObject

@property (nonatomic,strong)NSFetchedResultsController *fetchedController;




-(void)insertTempData;
-(NSFetchedResultsController *)getCountry;

-(BOOL)isNotificationExist :(EntNotification *)mynotification;

-(void)insertUpdateNotification :(EntNotification *) mynotification EnableDisable:(BOOL)isEnabled;
//-//(NSFetchedResultsController *)

-(void)syncCoreData :(NSArray *)arrayCountr;
-(NSString *)getLastUpdatedCountry;


-(void)syncCoreDataAgent :(NSArray *)arrayAgent;
-(NSString *)getLastUpdatedAgent;

-(Remittance *)getRemittanceByID :(NSString *)remittanceGUID;
- (void)getNotificationData :(NSString *)remittanceGUID withBlock:(void (^)(Remittance *rem, Country *country ))block;

- (Country *)getCountryByCurrencyKey :(NSString *)currencyKey;

@end
