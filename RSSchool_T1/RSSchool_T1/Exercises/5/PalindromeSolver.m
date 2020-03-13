#import "PalindromeSolver.h"

@implementation PalindromeSolver

// Complete the highestValuePalindrome function below.
- (NSString *) highestValuePalindrome:(NSString *)s n:(NSNumber *)n k:(NSNumber *)k {
    int min = 0;
    int numberOfDigits = [n intValue];
    int countSteps = [k intValue];
    int max = numberOfDigits - 1;
    int difference = 0;
    
    //split nsstring to nsarray
    NSMutableArray<NSString *> *characters = [[NSMutableArray alloc] initWithCapacity:[s length]];
    for (int i = 0; i < [s length]; i++) {
        NSString *iChar  = [NSString stringWithFormat:@"%c", [s characterAtIndex:i]];
        [characters addObject:iChar];
    }
    
    for (int i = 0, j = numberOfDigits - 1; i < numberOfDigits / 2.0; i++, j--) {
        NSString *firstItem = characters[i];
        NSString *secondItem = characters[j];
        
        if (![firstItem isEqualToString:secondItem]) {
            difference++;
        }
    }
    
    if (difference > countSteps) {
        return @"-1";
    }
    
    while (max >= min) {
        if (countSteps <= 0 ) {
            break;
        }
        
        NSString *minItem = characters[min];
        NSString *maxItem = characters[max];
        if ([minItem isEqualToString:maxItem]) {
            if (countSteps > 1 && (countSteps - 2) >= difference && ![minItem isEqualToString:@"9"]) {
                characters[min] = @"9";
                characters[max] = @"9";
                countSteps = countSteps - 2;
            }
        } else {
            if (countSteps > 1 && (countSteps - 2) >= difference - 1) {
                if (![minItem isEqualToString:@"9"]) {
                    characters[min] = @"9";
                    countSteps--;
                }
                if (![maxItem isEqualToString:@"9"]) {
                    characters[max] = @"9";
                    countSteps--;
                }
            } else {
                NSInteger minDigitValue = [characters[min] intValue];
                NSInteger maxDigitValue = [characters[max] intValue];
                if (minDigitValue > maxDigitValue) {
                    characters[max] = characters[min];
                } else {
                    characters[min] = characters[max];
                }
                countSteps--;
            }
            difference--;
        }
        
        if (max == min && countSteps > 0){
                        characters[min] = @"9";
                        countSteps--;
                    }
                    min++;
                    max--;
    }
    
    if ([self isPalindrome:characters]) {
        NSString * result = [[characters valueForKey:@"description"] componentsJoinedByString:@""];
        return result;
    } else {
        return @"-1";
    }
}

- (BOOL) isPalindrome: (NSArray <NSString *> *)stringArray {
    
    if ([stringArray count] == 0) {
        return NO;
    }
    
    NSUInteger i = 0;
    NSUInteger j = [stringArray count] - 1;
    
    while (j < i) {
        NSString * firstChar = [stringArray objectAtIndex:i];
        NSString * secondChar = [stringArray objectAtIndex:j];
        
        if ([firstChar isEqualToString:secondChar]) {
            i++;
            j--;
        } else {
            return NO;
        }
    }
    
    return YES;
}

@end
