//
//  RemittanceTableViewController.h
//  ToPeso
//
//  Created by pachie on 12/9/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Country.h"
#import <iAd/iAd.h>
#import <Social/Social.h>
//#import <MessageUI/MessageUI.h>




@interface RemittanceTableViewController : UITableViewController <NSFetchedResultsControllerDelegate >

//@property (nonatomic, strong) NSString * countryCode;
@property (nonatomic,strong) NSFetchedResultsController *fetched;
@property (nonatomic, strong)Country *country;
@property (nonatomic)bool isFromNotification;
@property (nonatomic, strong) NSString *countryCode;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentOutlet;


- (IBAction)ShareToFB:(id)sender;
- (IBAction)segmentAction:(id)sender;


@end
