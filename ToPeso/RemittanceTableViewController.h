//
//  RemittanceTableViewController.h
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface RemittanceTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSString * countryCode;
@property (nonatomic,strong) NSFetchedResultsController *fetched;

@end
