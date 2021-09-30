//
//  NSDictionary+ZBCategory.m
//  YJScanningKing
//
//  Created by yjwl on 2021/9/24.
//

#import "NSDictionary+ZBCategory.h"

@implementation NSDictionary (ZBCategory)


/// 重写此方法后，NSLog中打印的中文能正常显示，目前还不知道有没有其他问题
/// @param locale <#locale description#>
/// @param level <#level description#>
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    
    NSArray *allKeys = [self allKeys];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"{\t\n "];
    for (NSString *key in allKeys) {
        id value= self[key];
        [str appendFormat:@"\t \"%@\" = %@,\n",key, value];
    }
    [str appendString:@"}"];
    return str;
}
@end
