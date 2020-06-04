//
//  Employee.m
//  Bunq
//
//  Created by Taha Darendeli on 29.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

static NSUInteger const kStartingSalary = 10000;
NSString* const kSalaryCurrency = @"EUR";

@implementation Employee

- (instancetype) initWithName:(NSString *)name birthYear:(NSUInteger)birthYear
{
    self = [super init];
    if(self)
    {
         _name = [name copy];
         _birthYear = birthYear;
         _salary = [[NSDecimalNumber alloc] initWithUnsignedInteger:kStartingSalary - (random() % 3000 * (random() % 2 ? 1 : -1))];
         
        self.salarySelector = @selector(formatSalary);
    }
    return self;
}

- (NSString *)formatSalary
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:kSalaryCurrency];
    return [formatter stringFromNumber:_salary];
}

@end

NS_ASSUME_NONNULL_END
