#include <Foundation/Foundation.h>
@class Command;

@interface luaEncoding : NSObject

+ (NSMutableString *) endWithCommand: (Command *) x;
+ (NSMutableString *) loopWithCommand: (Command *) x;
+ (NSMutableString *) declareWithCommand: (Command *) x;
+ (NSMutableString *) setVarWithCommand: (Command *) x;
+ (NSMutableString *) getWithCommand: (Command *) x;
+ (NSMutableString *) printWithCommand: (Command *) x;
+ (NSMutableString *) callWithCommand: (Command *) x;
+ (NSMutableString *) functionWithArray: (NSMutableArray *) functions functionList: (NSMutableArray *) functionList;
+ (NSMutableString *) checkType: (Command *) x;
+ (NSMutableString *) returnWithCommand: (Command *) x;

@end