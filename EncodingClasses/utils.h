#include <Foundation/Foundation.h>
@class Command;

@interface utils : NSObject

+ (NSMutableString *) indentCalculator: (Command *) x;

@end

@interface Converters : NSObject

+ (NSMutableString *) convertIfStatement: (Command *) x forLanguage:(NSString *) lang;
+ (NSMutableString *) convertIfStatement: (Command *) x forLanguage:(NSString *) lang withVarArray: (NSMutableArray *) varArray;

@end