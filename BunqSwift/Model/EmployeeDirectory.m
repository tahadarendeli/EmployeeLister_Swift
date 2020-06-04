//
//  EmployeeDirectory.m
//  Bunq
//
//  Created by Taha Darendeli on 29.05.2020.
//  Copyright © 2020 Taha Darendeli. All rights reserved.
//

#import "EmployeeDirectory.h"
#import "Employee.h"

NS_ASSUME_NONNULL_BEGIN

NSString* const kEmployeeDirectoryDidUpdateNotification = @"kEmployeeDirectoryDidUpdateNotification";

@implementation EmployeeDirectory

- (void)update
{
    if(_isUpdating == YES)
    {
        return;
    }
    _isUpdating = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        [self BA_doUpdateInBackground];
     });
}

- (void)sortEmployees:(void(^)(EmployeeDirectory*))completion
{
   NSArray<Employee*> *sortedEmployees;
   sortedEmployees = [_employees sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
       NSString *first = [(Employee*)a name];
       NSString *second = [(Employee*)b name];
       return [first compare:second];
   }];
   
   _employees = [NSMutableArray arrayWithArray:sortedEmployees];
   
   completion(self);
}

#pragma mark - Privates
- (void)BA_doUpdateInBackground
{
    [NSThread sleepForTimeInterval:2];
    NSArray<NSString*>* name = @[@"Anne", @"Lucas", @"Marc", @"Zeus", @"Hermes", @"Bart", @"Paul", @"John", @"Ringo", @"Dave", @"Taylor"];
    NSArray<NSString*>* surnames = @[@"Hawkins", @"Simpson", @"Lennon", @"Grohl", @"Hawkins", @"Jacobs", @"Holmes", @"Mercury", @"Matthews"];

    NSUInteger amount = name.count*surnames.count;
    NSMutableArray* employees = [NSMutableArray arrayWithCapacity:amount];
    for(NSUInteger i=0; i<amount; i++)
    {
        NSString* fullName = [NSString stringWithFormat:@"%@ %@",
                              name[random()%name.count],
                              surnames[random()%surnames.count]];
        
        [employees addObject:[[Employee alloc] initWithName:fullName birthYear:1997-random()%50]];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self BA_updateDidFinishWithResults:employees];
    });
}

- (void)BA_updateDidFinishWithResults:(NSArray<Employee*>*)results
{
    _employees = results;
    _isUpdating = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:kEmployeeDirectoryDidUpdateNotification
                                                        object:self];
}
@end
NS_ASSUME_NONNULL_END

