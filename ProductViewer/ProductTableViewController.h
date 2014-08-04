//
//  ProductTableViewController.h
//  ProductViewer
//
//  Created by pachie on 3/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AddProductViewController.h"


@interface ProductTableViewController : UITableViewController <ModalViewControllerDelegate , NSFetchedResultsControllerDelegate>
- (IBAction)editTable:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property (nonatomic, retain) NSFetchedResultsController *fetch;



@end
