#include <Foundation/Foundation.h>
#include "vbsEncoding.h"
#include "command.h"
#include "utils.h"

@implementation VBSEncoding


+ (NSMutableString *) endWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if ([[x subSyntax] isEqualToString:@"while"]) { [returnString appendString:@"Loop\n"]; }
	if ([[x subSyntax] isEqualToString:@"if"]) { [returnString appendString:@"End If\n"]; }
	return returnString;
}

+ (NSMutableString *) loopWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if ([[x subSyntax] isEqualToString:@"while"]) { [returnString appendString:[NSString stringWithFormat:@"Do While %@\n", [x condition]]]; }
	if ([[x subSyntax] isEqualToString:@"if"]) { [returnString appendString:[NSString stringWithFormat:@"If %@ Then\n", [Converters convertIfStatement:x forLanguage:@"vbs"]]]; }
	return returnString;
}

+ (NSMutableString *) declareWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"Dim %@\n", [x varName]]];
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
	if ([[x subSyntax] isEqualToString:@"int"]) {
		[returnString appendString:[NSString stringWithFormat:@"%@ = CInt(InputBox(\"Input Value:\", VBS, \"?\"))\n",[x varName]]];
	}
	if ([[x subSyntax] isEqualToString:@"float"]) {
		[returnString appendString:[NSString stringWithFormat:@"%@ = CDbl(InputBox(\"Input Value:\", VBS, \"?\"))\n",[x varName]]];
	}
	if ([[x subSyntax] isEqualToString:@"string"]) {
		[returnString appendString:[NSString stringWithFormat:@"%@ = InputBox(\"Input Value:\", VBS, \"?\")\n",[x varName]]];
	}
	return returnString;
}

+ (NSMutableString *) printWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"msgbox(%@)\n", [x subSyntax]]];
	return returnString;
}

+ (NSMutableString *) callWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	if (![[x subSyntax] isEqualToString:@"void"]) { [returnString appendString:[NSString stringWithFormat:@"%@ = ", [x varName]]]; }
	[returnString appendString:[NSString stringWithFormat:@"%@(%@)\n",[x condition],[x returnType]]];
	return returnString;
}

+ (NSMutableString *) returnWithCommand: (Command *) x andName:(NSString *) name{
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[utils indentCalculator:x]];
	[returnString appendString:[NSString stringWithFormat:@"%@ = %@\n", name, [x varName]]];
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
				[build appendString:[self checkType:z]];
				if ([[z syntax] isEqualToString:@"return"]) { [build appendString:[self returnWithCommand:z andName:[functionList objectAtIndex:x]]]; }
				y++;
			}
			else {
				[attributes appendString:[NSString stringWithFormat:@"%@,",[z varName]]];
				y++;
			}
			[z setIndent:indentZ+1];
		}
		if ([attributes length] > 0) { [attributes deleteCharactersInRange:NSMakeRange([attributes length]-1, 1)]; }
		[returnString appendString:[NSString stringWithFormat:@"Function %@(%@)\n%@End Function\n\n",[functionList objectAtIndex:x], attributes, build]];
		y=0;
		x++;
	}
	return returnString;
}

+ (NSMutableString *) checkType: (Command *) x {
	NSMutableString *display = [[NSMutableString alloc] init];
	if ([[x syntax] isEqualToString:@"end"]) { [display appendString:[self endWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"loop"]) { [display appendString:[self loopWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"var"]) { [display appendString:[self declareWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"set"]) { [display appendString:[self setVarWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"get"]) { [display appendString:[self getWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"print"]) { [display appendString:[self printWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"callFunc"]) { [display appendString:[self callWithCommand:x]];	}
	return display;
}
@end