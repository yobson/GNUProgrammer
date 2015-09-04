#include <Foundation/Foundation.h>


@interface Command : NSObject{
	NSString *_text;
	NSString *_syntax;
	NSString *_condition;
	NSString *_subSyntax;
	int _indent;
	NSString *_varName;
	bool _attribute;
	NSString *_returnType;
	NSString *_cmdVarName;
}
/*
@property (copy) NSString *text; //What is Displayed
@property (copy) NSString *syntax; //Type of command
@property (copy) NSString *subSyntax; //Sub type
@property int indent; //indent
@property (copy) NSString *condition;
@property (copy) NSString *cmdVarName;
@property (copy) NSString *varName;
@property (copy) NSString *returnType;
@property bool attribute;
*/

//set Methods for GCC
- (void) setText:(NSString *) set;
- (void) setSyntax:(NSString *) set;
- (void) setSubSyntax:(NSString *) set;
- (void) setIndent:(int) set;
- (void) setCondition:(NSString *) set;
- (void) setCmdVarName:(NSString *) set;
- (void) setVarName:(NSString *) set;
- (void) setReturnType:(NSString *) set;
- (void) setAttribute:(bool) set;

//Get Methods for GCC
- (NSString *) text;
- (NSString *) syntax;
- (NSString *) subSyntax;
- (int) indent;
- (NSString *) condition;
- (NSString *) cmdVarName;
- (NSString *) varName;
- (NSString *) returnType;
- (bool) attribute;


@end