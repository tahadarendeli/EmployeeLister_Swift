//
//  Employee.h
//  Bunq
//
//  Created by Taha Darendeli on 29.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString* const kSalaryCurrency;

@interface Employee : NSObject

@property (readonly, copy) NSString* name;
@property (readonly) NSUInteger birthYear;
@property (readonly, copy) NSDecimalNumber* salary;
@property (nonatomic, assign) SEL salarySelector;

- (instancetype)initWithName:(NSString*)name birthYear:(NSUInteger)birthYear;
- (NSString *)formatSalary;

@end

NS_ASSUME_NONNULL_END
