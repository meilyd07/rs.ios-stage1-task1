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
        
        NSMutableArray *charPositions = [NSMutableArray new];
        
        for (int k = 0; k < 2; k++) {
            NSMutableArray *currentCharPositions = [NSMutableArray new];
            NSError *error = nil;
            NSString *pattern = [NSString stringWithFormat:@"\\%@", charSetArray[k]];
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
            NSArray<NSTextCheckingResult *> *matches = [regex matchesInString:string options:0 range:NSMakeRange(0, string.length)];
            
            for (NSTextCheckingResult *match in matches) {
                [currentCharPositions addObject: [NSNumber numberWithUnsignedInteger:match.range.location]];
            }
            
            [charPositions addObject:currentCharPositions];
        }
        
        NSArray *firstCharPositions = (NSArray *)charPositions[0];
        NSArray *secondCharPositions = (NSArray *)charPositions[1];
        
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
