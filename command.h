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

@property (copy) NSString *text; //What is Displayed
@property (copy) NSString *syntax; //Type of command
@property (copy) NSString *subSyntax; //Sub type
@property int indent; //indent
@property (copy) NSString *condition;
@property (copy) NSString *cmdVarName;
@property (copy) NSString *varName;
@property (copy) NSString *returnType;
@property bool attribute;



@end