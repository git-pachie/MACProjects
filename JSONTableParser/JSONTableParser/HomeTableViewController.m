//
//  HomeTableViewController.m
//  JSONTableParser
//
//  Created by Archie Angeles on 9/7/14.
//  Copyright (c) 2014 PachieOrg. All rights reserved.
//

#import "HomeTableViewController.h"
#import "DetailViewController.h"

@interface HomeTableViewController ()
{

NSMutableArray *myObject;
// A dictionary object
NSDictionary *dictionary;
// Define keys
NSString *title;
NSString *thumbnail;
NSString *author;
    NSString *templateid;
}

@end

@implementation HomeTableViewController

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
    
    
    title = @"title";
    thumbnail = @"thumbnail";
    author = @"author";
    templateid = @"templateid";
    
    
    myObject = [[NSMutableArray alloc] init];
    
    NSData *jsonSource = [NSData dataWithContentsOfURL:
                          [NSURL URLWithString:@"http://www.amanawaterpark.ph:1980/myjson/service1.svc/getdata"]];
    
    id jsonObjects = [NSJSONSerialization JSONObjectWithData:
                      jsonSource options:NSJSONReadingMutableContainers error:nil];
    
    for (NSDictionary *dataDict in jsonObjects) {
        NSString *title_data = [dataDict objectForKey:@"TemplateContent"];
        NSString *thumbnail_data = [dataDict objectForKey:@"TemplateTitle"];
        NSString *author_data = [dataDict objectForKey:@"DateCreated"];
        NSString *template_id = [dataDict objectForKey:@"TemplateID"];
        
        
        NSLog(@"TITLE: %@",title_data);
        NSLog(@"THUMBNAIL: %@",thumbnail_data);
        NSLog(@"AUTHOR: %@",author_data);
        NSLog(@"TemplateID: %@",template_id);

        
        dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                      title_data, title,
                      thumbnail_data, thumbnail,
                      author_data,author,
                      template_id,templateid,
                      nil];
        [myObject addObject:dictionary];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;//myObject.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [self performSegueWithIdentifier:@"detail" sender:indexPath];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return myObject.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tmpDict = [myObject objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tmpDict objectForKey:@"thumbnail"];
    cell.detailTextLabel.text = [tmpDict objectForKey:@"title"];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation
*/
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detail"]) {
        
        
        //NSIndexPath *tmpDict = [self.tableView indexPathForSelectedRow]; // [myObject objectAtIndex:indexPath.row];
        
        //////NSDictionary *tmpDict = [myObject objectAtIndex:index(<#const char *#>, <#int#>)]
        
        ////cell.textLabel.text = [tmpDict objectForKey:@"thumbnail"];
        
       // NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
        //vc.TemplateDetail = [[self dictionaryWithValuesForKeys:myObject] objectForKey:@"templateid"];
    }
}


@end
