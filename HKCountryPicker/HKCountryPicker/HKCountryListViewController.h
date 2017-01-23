//
//  HKCountryListViewController.h
//  HKCountryPicker
//
//  Created by SOTSYS113 on 23/01/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HKCountryListViewDelegate <NSObject>
- (void)didSelectCountry:(NSDictionary *)country;
@end
@interface HKCountryListViewController : UIViewController <UISearchBarDelegate>
@property (nonatomic, assign) id<HKCountryListViewDelegate>delegate;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
-(IBAction)btnBackClicked:(id)sender;
- (IBAction)btnDoneClicked:(id)sender;

@end
