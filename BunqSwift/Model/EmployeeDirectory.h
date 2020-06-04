//
//  EmployeeDirectory.h
//  Bunq
//
//  Created by Taha Darendeli on 29.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class Employee;

// notification posted when the directory finishes updating
extern NSString* const kEmployeeDirectoryDidUpdateNotification;

@interface EmployeeDirectory : NSObject

@property (readonly, nullable) NSArray<Employee*>* employees;
@property (readonly) BOOL isUpdating;

- (void)update;
- (void)sortEmployees:(void(^)(EmployeeDirectory*))completion;

@end

NS_ASSUME_NONNULL_END
