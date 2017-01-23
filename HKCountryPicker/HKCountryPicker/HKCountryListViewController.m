//
//  HKCountryListViewController.m
//  HKCountryPicker
//
//  Created by SOTSYS113 on 23/01/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

#import "HKCountryListViewController.h"
#import "HKCountryListDataSource.h"
#import "HKCountryCell.h"

@interface HKCountryListViewController ()
@property (strong, nonatomic) NSArray *dataRows;
@property (strong, nonatomic) NSArray *arrSearchList;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property ( nonatomic) BOOL isFromSearch;

@end

@implementation HKCountryListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.arrSearchList = [[NSArray alloc]init];
    self.isFromSearch = NO;

    HKCountryListDataSource *dataSource = [[HKCountryListDataSource alloc] init];
    _dataRows = [dataSource countries];
    self.searchBar.delegate = self;
    [_tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isFromSearch)
    {
        return [self.arrSearchList count];
    }
    else
    {
        return [self.dataRows count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    HKCountryCell *cell = (HKCountryCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[HKCountryCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    if (self.isFromSearch)
    {
        NSString *strImageName = [[self.arrSearchList objectAtIndex:indexPath.row]valueForKey:kCountryCode];
        NSString *lower = [strImageName lowercaseString];
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"assets" withExtension:@"bundle"]];
        NSString *imagePath = [bundle pathForResource:lower ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        cell.imageView.image = image;
        
        cell.textLabel.text = [[self.arrSearchList objectAtIndex:indexPath.row] valueForKey:kCountryName];
        NSString *strDialCode = [[self.arrSearchList objectAtIndex:indexPath.row]valueForKey:kCountryCallingCode];
        
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%+ld",(long)[strDialCode integerValue]];
    }
    else
    {
        NSString *strImageName = [[_dataRows objectAtIndex:indexPath.row]valueForKey:kCountryCode];
        NSString *lower = [strImageName lowercaseString]; // this will be "hello, world!"
        
        NSBundle *bundle = [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"assets" withExtension:@"bundle"]];
        NSString *imagePath = [bundle pathForResource:lower ofType:@"png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        
        cell.imageView.image = image;
        
        cell.textLabel.text = [[_dataRows objectAtIndex:indexPath.row] valueForKey:kCountryName];
        NSString *strDialCode = [[_dataRows objectAtIndex:indexPath.row]valueForKey:kCountryCallingCode];
        
        cell.detailTextLabel.text =[NSString stringWithFormat:@"%+ld",(long)[strDialCode integerValue]];
    }

    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}
-(IBAction)btnBackClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];

}
- (IBAction)btnDoneClicked:(id)sender
{
    if ([_delegate respondsToSelector:@selector(didSelectCountry:)])
    {
        if (self.isFromSearch)
        {
            [self.delegate didSelectCountry:[self.arrSearchList objectAtIndex:[_tableView indexPathForSelectedRow].row]];
        }
        else
        {
            [self.delegate didSelectCountry:[_dataRows objectAtIndex:[_tableView indexPathForSelectedRow].row]];
        }
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else {
        NSLog(@"CountryListView Delegate : didSelectCountry not implemented");
    }
}

#pragma mark - Search Bar Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText =%@",searchText);
        
    NSString *stringToSearch = searchText;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[c] %@",stringToSearch]; // if you need case sensitive search avoid '[c]' in the predicate
    
    self.arrSearchList = [_dataRows filteredArrayUsingPredicate:predicate];
    NSLog(@"results =%@",self.arrSearchList);
    if (self.arrSearchList.count>0)
    {
        self.isFromSearch = YES;
        [self.tableView reloadData];
    }
    else
    {
        self.isFromSearch = NO;
        [self.tableView reloadData];
    }


}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}


@end
