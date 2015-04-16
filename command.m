#include <Foundation/Foundation.h>
#include "command.h"


@implementation Command

@synthesize text = _text;
@synthesize syntax = _syntax;
@synthesize condition = _condition;
@synthesize vbsCondition = _vbsCondition;
@synthesize indent = _indent;
@synthesize subSyntax = _subSyntax;
@synthesize varName = _varName;
@synthesize attribute = _attribute;
@synthesize returnType = _returnType;


@end