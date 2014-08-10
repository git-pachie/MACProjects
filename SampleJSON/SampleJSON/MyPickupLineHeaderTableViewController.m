//
//  MyPickupLineHeaderTableViewController.m
//  SampleJSON
//
//  Created by pachie on 8/8/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "MyPickupLineHeaderTableViewController.h"
#import "MyPickupLinesTableViewController.h"
#import "CommonFunction.h"
#import "AppDelegate.h"
#import "CustomLoader.h"

@interface MyPickupLineHeaderTableViewController ()
{
    NSMutableArray *mArray;
    CommonFunction *common;
    AppDelegate *del;
    CustomLoader *loader;
    dispatch_queue_t myQue;
}

@end

@implementation MyPickupLineHeaderTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loader = [[CustomLoader alloc]init];
    [loader InitializeLoader:self];
    
    common = [[CommonFunction alloc]init];
    del = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to Refresh"];
    
    [refresh addTarget:self action:@selector(LoadUserByMessage)forControlEvents:UIControlEventValueChanged];
    
    
    self.refreshControl = refresh;
    

    
    
    //mArray = [[NSMutableArray alloc]init];
    
    if (!myQue) {
        myQue = dispatch_queue_create("com.samplejson", NULL);
    }
    
//   
//    
    
    
    
        dispatch_async(myQue, ^{
            
            
            
        loader.label.text = @"Loading...";
        [self.view addSubview:loader.xview];
        [self.view addSubview:loader.spinner];
        [self.view addSubview:loader.label];
        [loader.spinner startAnimating];
        
    
        [self LoadUserByMessage];
            

        

    });
    
    
    
}



- (void)stopRefresh
{
    
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [mArray count];
}

/**/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"    forIndexPath:indexPath];
    
    // Configure the cell...
    
     NSDictionary *dic = [mArray objectAtIndex:indexPath.row];
    
    
    if ([[dic objectForKey:@"UserName"] isEqualToString:@""]) {
        cell.textLabel.text = [dic objectForKey:@"PhoneNumber"];
    }
    else
    {
        cell.textLabel.text = [dic objectForKey:@"UserName"];
    }
    

    cell.detailTextLabel.text = [dic objectForKey:@"Email"];
    
    
    return cell;
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //pickupLineDetails
    if ([segue.identifier isEqualToString:@"pickupLineDetails"]) {
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        MyPickupLinesTableViewController *dv = segue.destinationViewController;
        
        NSDictionary *dic = [mArray objectAtIndex:path.row];
        
        dv.PhoneNumber = [dic objectForKey:@"PhoneNumber"];
        
        if ([[dic objectForKey:@"UserName"]  isEqual: @""]) {
            dv.receipientName = [dic objectForKey:@"PhoneNumber"];
        }
        else
        {
            dv.receipientName = [dic objectForKey:@"UserName"];
        }
        
    }
}

#pragma mark - Query Data from JSON objects

-(void)LoadUserByMessage
{
    mArray = [[NSMutableArray alloc]init];

    
    dispatch_async(dispatch_get_main_queue(),^{
     
        
    //common = [[CommonFunction alloc]init];
    NSString *x =  [common GetJsonConnection:[NSString stringWithFormat:@"GetDistincMessage/%1@",del.PhoneNumber]];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:[NSURL URLWithString:x]];
    
    if ([common CheckNSD:jsonSource] == false) {
        
        UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:@"Connection error" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false ;
        
        self.navigationItem.title = @"Network Error";
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];

        
        [mes show];
        
        return;
    }
    
    
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    //countedSet = [NSCountedSet set];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *phoneNumber = [dataDict objectForKey:@"PhoneNumber"];
        NSString *email = [dataDict objectForKey:@"Email"];
        NSString *userName = [dataDict objectForKey:@"UserName"];
        
        NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:
                                     phoneNumber,@"PhoneNumber"
                                    ,email,@"Email"
                                    ,userName,@"UserName"
                                    ,nil];
        
        [mArray addObject:dictionary];
        
        
        
        
        
        
    }
    
       // sleep(1);
        
       // [loader.spinner stopAnimating];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self HideLoading];

        });
        
        [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:2.5];
        
        
    });

    

    
    
    
    
    
}

-(void)HideLoading
{
    
    dispatch_async(dispatch_get_main_queue(),^{
        
        sleep(2);
        
        //self.navigationItem.title = @"Home";
        [UIApplication sharedApplication].networkActivityIndicatorVisible = false ;
        
        [loader.spinner stopAnimating];
        
        for (UIView *subview in [self.view subviews]) {
            // Only remove the subviews with tag not equal to 1
            if (subview.tag == 1) {
                [subview removeFromSuperview];
            }
        }
    });
}

@end
