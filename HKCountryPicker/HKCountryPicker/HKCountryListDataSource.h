//  HKCountryListDataSource
//
//  Created by SOTSYS113 on 23/01/17.
//  Copyright © 2017 SOTSYS113. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCountryName        @"name"
#define kCountryCallingCode @"dial_code"
#define kCountryCode        @"code"

@interface HKCountryListDataSource : NSObject

- (NSArray *)countries;
@end
