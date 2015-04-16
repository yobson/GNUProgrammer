#include <Foundation/Foundation.h>
#include "cppEncoding.h"
#include "command.h"

@implementation CPPEncoding

+ (NSMutableString *) indentCalculator: (Command *) x{
	int indent = [x indent];
	NSMutableString *string = [[NSMutableString alloc] init];
	
	while (indent != 0) {
		[string appendString:@"   "];
		indent--;
	}
	return string;
}

+ (NSMutableString *) setUpFile {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:@"#include <iostream>\nusing namespace std;\n\n"];
	return returnString;
}

+ (NSMutableString *) setUpMain {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:@"int Main () {\n"];
	return returnString;
}

+ (NSMutableString *) endWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:@"}\n"];
	return returnString;
}

+ (NSMutableString *) loopWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	if ([[x subSyntax] isEqualToString:@"while"]) { [returnString appendString:[NSString stringWithFormat:@"while (%@) {\n", [x condition]]]; }
	if ([[x subSyntax] isEqualToString:@"if"]) { [returnString appendString:[NSString stringWithFormat:@"if (%@) {\n", [x condition]]]; }
	return returnString;
}

+ (NSMutableString *) declareWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"%@ %@;\n", [x subSyntax], [x varName]]];
	return returnString;
}

+ (NSMutableString *) setVarWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"%@ = %@;\n",[x varName], [x condition]]];
	return returnString;
}

+ (NSMutableString *) getWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"cin >> %@;\n", [x varName]]];
	return returnString;
}

+ (NSMutableString *) printWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"cout << %@ << endl;\n", [x subSyntax]]];
	return returnString;
}

+ (NSMutableString *) callWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	if (![[x subSyntax] isEqualToString:@"void"]) { [returnString appendString:[NSString stringWithFormat:@"%@ = ", [x varName]]]; }
	[returnString appendString:[NSString stringWithFormat:@"%@(%@);\n",[x condition],[x returnType]]];
	return returnString;
}

+ (NSMutableString *) returnWithCommand: (Command *) x{
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[self indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"return %@;", [x varName]]];
	return returnString;
}

+ (NSMutableString *) functionWithArray: (NSMutableArray *) functions functionList: (NSMutableArray *) functionList {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	NSMutableString *attributes = [[NSMutableString alloc] init];
	NSMutableString *build = [[NSMutableString alloc] init];
	int x=0;
	int y=0;
	while ( x < [functionList count]) {
		Command *z = [Command alloc];
		NSMutableArray *currentInstructionArray = [[NSMutableArray alloc] initWithArray:[functions objectAtIndex:x]];	
		while ( y < [currentInstructionArray count]) {
			z = [currentInstructionArray objectAtIndex:y];
			int indentZ = [z indent];
			[z setIndent:indentZ+1];
			if (![z attribute]) { 
				[build appendString:[CPPEncoding checkType:z]];
				y++;
			}
			else {
				[attributes appendString:[NSString stringWithFormat:@"%@,",[z varName]]];
				y++;
			}			
		}
		if ([attributes length] > 0) { [attributes deleteCharactersInRange:NSMakeRange([attributes length]-1, 1)]; }
		z = [currentInstructionArray lastObject];
		[returnString appendString:[NSString stringWithFormat:@"%@ %@(%@) {\n%@\n}\n\n", [z returnType], [functionList objectAtIndex:x], attributes, build]];
		y=0;
		x++;
	}
	return returnString;
}

+ (NSMutableString *) checkType: (Command *) x {
	NSMutableString *display = [[NSMutableString alloc] init];
	if ([[x syntax] isEqualToString:@"end"]) { [display appendString:[CPPEncoding endWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"loop"]) { [display appendString:[CPPEncoding loopWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"var"]) { [display appendString:[CPPEncoding declareWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"set"]) { [display appendString:[CPPEncoding setVarWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"get"]) { [display appendString:[CPPEncoding getWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"print"]) { [display appendString:[CPPEncoding printWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"callFunc"]) { [display appendString:[CPPEncoding callWithCommand:x]];	}
	if ([[x syntax] isEqualToString:@"return"]) { [display appendString:[CPPEncoding returnWithCommand:x]];	}
	return display;
}

@end