#include <Foundation/Foundation.h>
@class Command;

@interface cmdEncoding : NSObject

+ (NSString *) setUp;
+ (NSString *) setDown;
+ (NSMutableString *) endWithCommand: (Command *) x;
+ (NSMutableString *) loopWithCommand: (Command *) x withVarArray: (NSMutableArray *) vars;
+ (NSMutableString *) setVarWithCommand: (Command *) x;
+ (NSMutableString *) getWithCommand: (Command *) x;
+ (NSMutableString *) printWithCommand: (Command *) x;
+ (NSMutableString *) callWithCommand: (Command *) x;
+ (NSMutableString *) functionWithArray: (NSMutableArray *) functions functionList: (NSMutableArray *) functionList withVarArray: (NSMutableArray *) vars;
+ (NSMutableString *) checkType: (Command *) x withVarArray:(NSMutableArray *) vars;
+ (NSMutableString *) returnWithCommand: (Command *) x;
+ (NSMutableString *) returnVoidWithCommand: (Command *) x;

@end