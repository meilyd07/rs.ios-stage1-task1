#import "T1Array.h"

@implementation T1Array

// Complete the following fuction
- (NSArray *)convertToHappy:(NSArray *)sadArray {
    
    NSMutableArray *happyArray = [sadArray mutableCopy];
    
    BOOL isSadArray = TRUE;
    
    while (isSadArray) {
        NSMutableIndexSet *badIndexesSet = [self getBadElementIndexes:happyArray];
        if (badIndexesSet.count > 0) {
            [happyArray removeObjectsAtIndexes:badIndexesSet];
        } else {
            isSadArray = NO;
        }
    };
    
    return happyArray;
}

- (NSMutableIndexSet *)getBadElementIndexes: (NSArray *) sadArray {
    NSMutableIndexSet *badIndexes = [NSMutableIndexSet new];
    
    NSUInteger count = [sadArray count];
    if (count > 0) {
        for (int index = 1; index < count - 1; index++) {
            id item = [sadArray objectAtIndex:(index)];
            NSNumber *previousItem = [sadArray objectAtIndex:(index - 1)];
            NSNumber *nextItem = [sadArray objectAtIndex:index + 1];
            
            if ([previousItem intValue] + [nextItem intValue] < [item intValue]) {
                [badIndexes addIndex:index];
            }
        }
    }
    
    return badIndexes;
}

@end
