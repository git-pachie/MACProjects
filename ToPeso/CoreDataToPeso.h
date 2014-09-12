//
//  CoreDataToPeso.h
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CoreDataToPeso : NSObject

@property (nonatomic,strong)NSFetchedResultsController *fetchedController;




-(void)insertTempData;
-(NSFetchedResultsController *)getCountry;
//-//(NSFetchedResultsController *)


@end
