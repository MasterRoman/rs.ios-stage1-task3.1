#import "PolynomialConverter.h"

@implementation PolynomialConverter
- (NSString*)convertToStringFrom:(NSArray <NSNumber*>*)numbers {
    NSUInteger koffNumber = numbers.count;
    NSMutableString *s = [[NSMutableString alloc] init];
    if (koffNumber == 0) {
        return nil;
    }
    else
    {   koffNumber--;
        for (int i=0; i<numbers.count; i++) {
            NSNumber *curNumber = numbers[i];
            if ([curNumber intValue]!=0){
                if ([curNumber intValue]>0){
                    [s appendString:@" + "];
                } else
                {
                    [s appendString:@" - "];
                }
                if (abs([curNumber intValue]) == 1){
                    [s appendString:[NSString stringWithFormat:@"%@", @"x"]];
                } else if (koffNumber>=2){
                    
                    [s appendString:[NSString stringWithFormat:@"%d%@%lu",abs([curNumber intValue]), @"x^", koffNumber]];
                    
                }
                else if (koffNumber==1){
                   [s appendString:[NSString stringWithFormat:@"%d%@",abs([curNumber intValue]), @"x"]];
                }
                else if (koffNumber==0) {
                    [s appendString:[NSString stringWithFormat:@"%d",abs([curNumber intValue])]];
                }
            } else
            {
                koffNumber--;
                continue;
            }
            koffNumber--;
        }
    }
    NSRange rang = NSMakeRange(0,3);
    [s deleteCharactersInRange:rang];
    return s;
}
@end
