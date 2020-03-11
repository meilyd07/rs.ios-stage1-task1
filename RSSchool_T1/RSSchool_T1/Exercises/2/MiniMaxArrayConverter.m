#import "MiniMaxArrayConverter.h"

@implementation MiniMaxArrayConverter

// Complete the convertFromArray function below.
- (NSArray<NSNumber*>*)convertFromArray:(NSArray<NSNumber*>*)array {
    
    NSNumber *totalSum = [array valueForKeyPath:@"@sum.self"];
    NSArray<NSNumber*>* sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    NSInteger minimumSum = [totalSum intValue] - [sortedArray.lastObject intValue];
    NSInteger maximumSum = [totalSum intValue] - [sortedArray.firstObject intValue];
    return @[[NSNumber numberWithInteger:minimumSum], [NSNumber numberWithInteger:maximumSum]];
}

@end
