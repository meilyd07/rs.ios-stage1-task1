#import "BillCounter.h"

@implementation BillCounter

// Complete the following fuction
- (NSString*)compareResultForBill:(NSArray<NSNumber*>*)bill notIncludingElementWithIndex:(NSInteger)index withGivenSum:(NSNumber*)sum {
    
    NSUInteger count = bill.count;
    if ((count > 1) && (index < count) && (index >= 0)) {
        NSInteger totalSum = [[bill valueForKeyPath: @"@sum.self"] integerValue];
        NSNumber *item = [bill objectAtIndex:index];
        totalSum = totalSum - [item integerValue];
        
        double amount = totalSum / 2.0;
        double charged = [sum doubleValue];
        
        if (charged == amount) {
            return @"Bon Appetit";
        } else {
            return [NSString stringWithFormat:@"%g", (charged - amount)];
        }
    }
    
    return @"";
}

@end
