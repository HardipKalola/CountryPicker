//  HKCountryListDataSource
//
//  Created by SOTSYS113 on 23/01/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

#import "HKCountryListDataSource.h"

#define kCountriesFileName @"countries.json"

@interface HKCountryListDataSource () {
    NSArray *countriesList;
}

@end

@implementation HKCountryListDataSource

- (id)init {
    self = [super init];
    if (self) {
        [self parseJSON];
    }
    
    return self;
}

- (void)parseJSON
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", [localError userInfo]);
    }
    countriesList = (NSArray *)parsedObject;
    
    NSSortDescriptor *descriptor=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObject: descriptor];
    countriesList = [countriesList sortedArrayUsingDescriptors:descriptors];
}

- (NSArray *)countries
{
    return countriesList;
}
@end
