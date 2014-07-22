//
//  GroupTableViewController.m
//  SampleTableGrouping
//
//  Created by pachie on 18/7/14.
//  Copyright (c) 2014 Private. All rights reserved.
//

#import "GroupTableViewController.h"

@interface GroupTableViewController ()
{
    NSMutableArray *MyArray;
    NSArray *xArray;
    NSCountedSet *countedSet;
}

@end

@implementation GroupTableViewController

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
    
    MyArray = [[NSMutableArray alloc]init];
    
    NSArray *FirstArray = [[NSArray alloc]initWithObjects:@"One",@"Two", nil];
    NSDictionary *FirstDictionary = [NSDictionary dictionaryWithObject:FirstArray forKey:@"data"];
    
    [MyArray addObject:FirstDictionary];
    
    NSArray *SecondArray = [[NSArray alloc]initWithObjects:@"three",@"four", nil];
    NSDictionary *SecondDictionary = [NSDictionary dictionaryWithObject:SecondArray forKey:@"data2"];
    
    [MyArray addObject:SecondDictionary];
    
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
    //return MyArray.count;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [xArray count];
        
    } else {
        return [MyArray count];
        
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        NSDictionary *dictionary = [xArray objectAtIndex:section];
        
        NSArray *array = [dictionary allKeys];
        
        return [[dictionary objectForKey:[array objectAtIndex:0]] count];
        
    } else {
        //return [MyArray count];
        
        NSDictionary *dictionary = [MyArray objectAtIndex:section];
        
        NSArray *array = [dictionary allKeys];
        
        return [[dictionary objectForKey:[array objectAtIndex:0]] count];
        
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        NSDictionary *dictionary = [xArray objectAtIndex:section];
        
        NSArray *array = [dictionary allKeys];
        
        NSString *result = [array objectAtIndex:0];

        return result;
        

        
    } else {
        NSDictionary *dictionary = [MyArray objectAtIndex:section];
        
        NSArray *array = [dictionary allKeys];
        
        NSString *result = [array objectAtIndex:0];

        return result;
        

        
    }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        dictionary = [xArray objectAtIndex:indexPath.section];
    } else {
        dictionary = [MyArray objectAtIndex:indexPath.section];    }
    
    
    //NSDictionary *dictionary = [MyArray objectAtIndex:indexPath.section];
    
    NSArray *array = [dictionary objectForKey:[[dictionary allKeys] objectAtIndex:0]];
    
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    
    
    
    
    
    
    
    return cell;
    
    
}
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"data contains[cd] One"];
//    
//    [xArray addObjectsFromArray:[MyArray filteredArrayUsingPredicate:resultPredicate]];
    
   //for (int i=0; i<=[MyArray count] - 1; i++) {
       
       // NSDictionary *dic = [MyArray objectAtIndex:i];
       
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"contains [cd] %@",searchText];
       
        xArray = [MyArray filteredArrayUsingPredicate:resultPredicate];
       
   // }
//    
    
   
//NSArray *resultArray = [[mainDict allValues] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(key1 == %@) AND (key2==%@)", @"tt",@"vv"]];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
@end
