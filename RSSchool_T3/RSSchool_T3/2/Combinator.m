#import "Combinator.h"

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    NSUInteger m = [[array firstObject] intValue];
    NSUInteger n = [[array lastObject] intValue];
    NSUInteger res = 1;
    if (m == n) {
        return @1;
    }
    NSUInteger factN = [Combinator fact:n];
    while (res <= n) {
        NSUInteger cur = factN / ( [Combinator fact:(n - res)] * [Combinator fact:res]);
        // Combinations
        if (cur == m) {
            return [[NSNumber alloc] initWithInt: (int)res];
        }
        res += 1;
    }
    return nil;
}
+ (long)fact:(NSUInteger) n {
    long f = 1;
    for (int i=1; i<n+1; i++) {
        f = f * i;
    }
    return f;
}
@end
