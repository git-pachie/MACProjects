//
//  MenuTableViewController.m
//  SampleSlideMenu
//
//  Created by Archie Angeles on 30/10/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "MenuTableViewController.h"
#import "SWRevealViewController.h"

@interface MenuTableViewController ()

@property (nonatomic, strong) NSArray *menuItems;


@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.2f alpha:1.0f];
    self.tableView.separatorColor = [UIColor colorWithWhite:0.15f alpha:0.2f];
    
    _menuItems = @[@"title",@"one",@"main"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
//    if ([segue.identifier isEqualToString:@"showPhoto"]) {
//        PhotoViewController *photoController = (PhotoViewController*)segue.destinationViewController;
//        NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [_menuItems objectAtIndex:indexPath.row]];
//        photoController.photoFilename = photoFilename;
//    }
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 24)];
    [header setBackgroundColor:[UIColor whiteColor]];
    
    return header;
                      
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    
}


@end
