#import "Parser.h"

@implementation Parser

// Complete the parseString function below.
- (NSArray <NSString*>*)parseString:(NSString*)string {
    NSMutableArray *arrayOfPairs = [NSMutableArray new];
    
    NSArray *charSetArrays = @[@[@"<", @">"],
                               @[@"(", @")"],
                               @[@"[", @"]"]
    ];

    for (NSArray *charSetArray in charSetArrays) {
        
        NSError *error = nil;
        
        NSMutableArray *firstCharPositions = [NSMutableArray new];
        NSString *pattern = [NSString stringWithFormat:@"\\%@", charSetArray[0]];
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
        NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        for (NSTextCheckingResult *match in matches) {
            [firstCharPositions addObject: [NSNumber numberWithUnsignedInteger:match.range.location]];
        }
        
        NSMutableArray *secondCharPositions = [NSMutableArray new];
        pattern = [NSString stringWithFormat:@"\\%@", charSetArray[1]];
        regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
        matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
        
        for (NSTextCheckingResult *match in matches) {
            [secondCharPositions addObject: [NSNumber numberWithUnsignedInteger:match.range.location]];
        }
        
        for (int i = 0; i < firstCharPositions.count; i++) {
            NSUInteger firstIndex = ((NSNumber *)(firstCharPositions[i])).unsignedIntegerValue;
            
            for (int j = 0; j < secondCharPositions.count; j++) {
                NSUInteger secondIndex = ((NSNumber *)(secondCharPositions[j])).unsignedIntegerValue;
                
                if (firstIndex < secondIndex) {
                    NSString *tempString = [string substringWithRange:NSMakeRange(firstIndex + 1, secondIndex - firstIndex - 1)];
                    if ([tempString containsString:charSetArray[0]] && ![tempString containsString:charSetArray[1]]) {
                        continue;
                    } else {
                        
                        NSArray *pair = @[
                            firstCharPositions[i],
                            tempString];
                        
                        [arrayOfPairs addObject:pair];
                        break;
                    }
                } else {
                    continue;
                }
            }
        }
    }
    
    NSArray *sortedArray = [arrayOfPairs sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [(NSArray *)a objectAtIndex:0];
        NSNumber *second = [(NSArray *)b objectAtIndex:0];
        
        return [first compare:second];
    }];
    
    NSMutableArray <NSString*> *arrayOfStrings = [[NSMutableArray alloc] init];
    for (NSArray *item in sortedArray) {
           [arrayOfStrings addObject:item[1]];
       }
    
    return [NSArray arrayWithArray:arrayOfStrings];
}

@end
