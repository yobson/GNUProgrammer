#include <Foundation/Foundation.h>
#include "pytwoEncoding.h"
#include "command.h"
#include "utils.h"

@implementation PYEncoding

+ (NSMutableString *) endWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:@"\n"];
	return returnString;
}

+ (NSMutableString *) loopWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if ([[x subSyntax] isEqualToString:@"while"]) { [returnString appendString:[NSString stringWithFormat:@"while %@ :\n", [x condition]]]; }
	if ([[x subSyntax] isEqualToString:@"if"]) { [returnString appendString:[NSString stringWithFormat:@"if %@ :\n", [x condition]]]; }
	return returnString;
}

+ (NSMutableString *) declareWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	return returnString;
}

+ (NSMutableString *) setVarWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"%@ = %@\n",[x varName], [x condition]]];
	return returnString;
}

+ (NSMutableString *) getWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if (![[x subSyntax] isEqualToString:@"string"]) {
		[returnString appendString:[NSString stringWithFormat:@"%@ = %@(raw_input())\n", [x varName], [x subSyntax]]];}
	else { [returnString appendString:[NSString stringWithFormat:@"%@ = raw_input()\n", [x varName]]]; }
	return returnString;
}

+ (NSMutableString *) printWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"print %@\n", [x subSyntax]]];
	return returnString;
}

+ (NSMutableString *) callWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if (![[x subSyntax] isEqualToString:@"void"]) { [returnString appendString:[NSString stringWithFormat:@"%@ = ", [x varName]]]; }
	[returnString appendString:[NSString stringWithFormat:@"%@ (%@)\n",[x condition],[x returnType]]];
	return returnString;
}

+ (NSMutableString *) returnWithCommand: (Command *) x{
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"return %@", [x varName]]];
	return returnString;
}

+ (NSMutableString *) functionWithArray: (NSMutableArray *) functions functionList: (NSMutableArray *) functionList {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	int x=0;
	int y=0;
	while ( x < [functionList count]) {
		NSMutableString *attributes = [[NSMutableString alloc] init];
		NSMutableString *build = [[NSMutableString alloc] init];
		Command *z = [Command alloc];
		NSMutableArray *currentInstructionArray = [[NSMutableArray alloc] initWithArray:[functions objectAtIndex:x]];	
		while ( y < [currentInstructionArray count]) {
			z = [currentInstructionArray objectAtIndex:y];
			int indentZ = [z indent];
			[z setIndent:indentZ+1];
			if (![z attribute]) { 
				[build appendString:[PYEncoding checkType:z]];
				y++;
			}
			else {
				[attributes appendString:[NSString stringWithFormat:@"%@,",[z varName]]];
				y++;
			}
			[z setIndent:indentZ];
		}
		if ([attributes length] > 0) { [attributes deleteCharactersInRange:NSMakeRange([attributes length]-1, 1)]; }
		z = [currentInstructionArray lastObject];
		[returnString appendString:[NSString stringWithFormat:@"def %@(%@):\n%@\n\n", [functionList objectAtIndex:x], attributes, build]];
		y=0;
		x++;
	}
	return returnString;
}

+ (NSMutableString *) checkType: (Command *) x {
	NSMutableString *display = [[NSMutableString alloc] init];
	if ([[x syntax] isEqualToString:@"end"]) { [display appendString:[PYEncoding endWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"loop"]) { [display appendString:[PYEncoding loopWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"var"]) { [display appendString:[PYEncoding declareWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"set"]) { [display appendString:[PYEncoding setVarWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"get"]) { [display appendString:[PYEncoding getWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"print"]) { [display appendString:[PYEncoding printWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"callFunc"]) { [display appendString:[PYEncoding callWithCommand:x]];	}
	if ([[x syntax] isEqualToString:@"return"]) { [display appendString:[PYEncoding returnWithCommand:x]];	}
	return display;
}

@end