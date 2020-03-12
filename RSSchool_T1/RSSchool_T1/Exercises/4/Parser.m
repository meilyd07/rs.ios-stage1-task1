#import "Parser.h"

@implementation Parser

// Complete the parseString function below.
- (NSArray <NSString*>*)parseString:(NSString*)string {
    
    NSMutableArray *arrayOfStrings = [[NSMutableArray alloc] init];
  
    
    NSArray <NSString*> *patterns = @[@"<.*?>", @"<.*>", @"\\[.*?\\]",@"\\[.*\\]", @"\\(.*?\\)"];
    //NSArray <NSString*> *patterns = @[@"<.*?>", @"\\[.*?\\]", @"\\(.*?\\)"];
    
    for (NSString *pattern in patterns) {
        NSError *error = nil;
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];

        for (NSTextCheckingResult *match in matches) {
            NSString* substringForMatch = [string substringWithRange:match.range];
            
            NSLog(@"Extracted: %@, %lu",substringForMatch, (unsigned long)match.range.location);

            NSArray *pair = @[
                @(match.range.location),
                [[substringForMatch substringFromIndex:1] substringToIndex:substringForMatch.length - 2]];
            
            if (![arrayOfStrings containsObject:pair]) {
                [arrayOfStrings addObject:pair];
            }
        }
    }
    
    NSArray *sortedArray = [arrayOfStrings sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(NSArray *)a objectAtIndex:0];
        NSNumber *second = [(NSArray *)b objectAtIndex:0];
        
        return [first compare:second];
    }];
    
    NSMutableArray *tempResults = [NSMutableArray new];
    for (NSArray *item in sortedArray) {
        
        [tempResults addObject:item[1]];
    }
    
    return [NSArray arrayWithArray:tempResults];
}

@end
