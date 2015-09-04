#include <Foundation/Foundation.h>
#include "command.h"


@implementation Command
/*
@synthesize text = _text;
@synthesize syntax = _syntax;
@synthesize condition = _condition;
@synthesize indent = _indent;
@synthesize subSyntax = _subSyntax;
@synthesize varName = _varName;
@synthesize attribute = _attribute;
@synthesize returnType = _returnType;
@synthesize cmdVarName = _cmdVarName;
*/

// init method for GCC
- (id) init {
	_text = [[NSString alloc] init];
	_syntax = [[NSString alloc] init];
	_condition = [[NSString alloc] init];
	_subSyntax = [[NSString alloc] init];
	_varName = [[NSString alloc] init];
	_returnType = [[NSString alloc] init];
	_cmdVarName = [[NSString alloc] init];
	return self;
}

//set Methods for GCC
- (void) setText:(NSString *) set {
	_text = set;
}
- (void) setSyntax:(NSString *) set {
	_syntax = set;
}
- (void) setSubSyntax:(NSString *) set {
	_subSyntax = set;
}
- (void) setIndent:(int) set {
	_indent = set;
}
- (void) setCondition:(NSString *) set {
	_condition = set;
}
- (void) setCmdVarName:(NSString *) set {
	_cmdVarName = set;
}
- (void) setVarName:(NSString *) set {
	_varName = set;
}
- (void) setReturnType:(NSString *) set {
	_returnType = set;
}
- (void) setAttribute:(bool) set {
	_attribute = set;
}

//Get Methods for GCC
- (NSString *) text {
	return _text;
}
- (NSString *) syntax {
	return _syntax;
}
- (NSString *) subSyntax {
	return _subSyntax;
}
- (int) indent {
	return _indent;
}
- (NSString *) condition {
	return _condition;
}
- (NSString *) cmdVarName {
	return _cmdVarName;
}
- (NSString *) varName {
	return _varName;
}
- (NSString *) returnType {
	return _returnType;
}
- (bool) attribute {
	return _attribute;
}

@end