//
//  AddProductViewController.m
//  ProductViewer
//
//  Created by pachie on 3/8/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "AddProductViewController.h"
#import "AppDelegate.h"

@interface AddProductViewController ()
@end



@implementation AddProductViewController
@synthesize delegate1;






- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)done:(id)sender {
    
   // [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
//    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
//    NSManagedObjectContext *context = [delegate managedObjectContext];
//    
//    NSManagedObject *product;
//    product = [NSEntityDescription insertNewObjectForEntityForName:@"Products" inManagedObjectContext:context];
//    
//    [product setValue:[self.category text] forKey:@"productCategory"];
//    [product setValue:[self.productName text] forKey:@"productName"];
//    
//    
//    [product setValue:[self.sellingPrice text] forKey:@"productSellPrice"];
//    
//    NSUUID  *UUID = [NSUUID UUID];
//    NSString* stringUUID = [UUID UUIDString];
//    
//    [product setValue:stringUUID forKey:@"productID"];
//    
//    NSError *error;
//    
//    [context save:&error];
//    NSLog(@"New Reminder Saved");
    

    
}

- (IBAction)cancel:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneDed:(id)sender {
    
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSManagedObject *product;
    product = [NSEntityDescription insertNewObjectForEntityForName:@"Products" inManagedObjectContext:context];
    
    [product setValue:[self.category text] forKey:@"productCategory"];
    [product setValue:[self.productName text] forKey:@"productName"];
    
    
    [product setValue:[self.sellingPrice text] forKey:@"productSellPrice"];
    
    NSUUID  *UUID = [NSUUID UUID];
    NSString* stringUUID = [UUID UUIDString];
    
    [product setValue:stringUUID forKey:@"productID"];
    
    NSError *error;
    
    [context save:&error];
    NSLog(@"New Reminder Saved");
    
    [self.delegate1 shouldChangeNumber];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
