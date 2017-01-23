//
//  ViewController.m
//  HKCountryPicker
//
//  Created by SOTSYS113 on 23/01/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - HKCountry Picker Delegate
- (void)didSelectCountry:(NSDictionary *)country
{
    NSLog(@"%@",country);
}


@end
