#include <Foundation/Foundation.h>
#include "cmdEncoding.h"
#include "command.h"
#include "utils.h"

@implementation cmdEncoding

+(NSString *) setUp {
	return @"@echo off\n";
}

+(NSString *) setDown {
	return @"pause\n\n";
}

+ (NSMutableString *) endWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:@")\n"];
	return returnString;
}

+ (NSMutableString *) loopWithCommand: (Command *) x withVarArray: (NSMutableArray *) vars {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	if ([[x subSyntax] isEqualToString:@"while"]) { [returnString appendString:[NSString stringWithFormat:@"while %@ then\n", [Converters convertIfStatement:x forLanguage:@"cmd" withVarArray:vars]]]; }
	if ([[x subSyntax] isEqualToString:@"if"]) { [returnString appendString:[NSString stringWithFormat:@"if %@ (\n", [Converters convertIfStatement:x forLanguage:@"cmd" withVarArray:vars]]]; }
	return returnString;
}


+ (NSMutableString *) setVarWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[NSString stringWithFormat:@"SET /a \"%@=%@\"\n",[x varName], [x cmdVarName]]];
	return returnString;
}

+ (NSMutableString *) getWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[NSString stringWithFormat:@"SET /p %@=\"?\"\n", [x varName]]];
	return returnString;
}

+ (NSMutableString *) printWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[NSString stringWithFormat:@"echo %@\n", [x cmdVarName]]];
	return returnString;
}

+ (NSMutableString *) callWithCommand: (Command *) x {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	NSArray *split = [[x returnType] componentsSeparatedByString:@","];
	  int z = 0;
	  NSMutableString *temp = [[NSMutableString alloc] init];
	 while (z != [split count]) {
		  [temp appendString:[NSString stringWithFormat:@"%@ ", [split objectAtIndex:z]]];
		  z++;
	  }
	  [returnString appendString:[NSString stringWithFormat:@"CALL :%@ %@\n",[x condition],temp]];
	 if (![[x subSyntax] isEqualToString:@"void"]) { [returnString appendString:[NSString stringWithFormat:@"SET %@=%%_result%%\n", [x varName]]]; }
	return returnString;
}

+ (NSMutableString *) returnWithCommand: (Command *) x{
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:[NSString stringWithFormat:@"ENDLOCAL & SET _result=%%%@%%", [x varName]]];
	return returnString;
}

+ (NSMutableString *) returnVoidWithCommand: (Command *) x { 
	NSMutableString *returnString = [[NSMutableString alloc] init];
	[returnString appendString:@"ENDLOCAL"];
	return returnString;
}

+ (NSMutableString *) functionWithArray: (NSMutableArray *) functions functionList: (NSMutableArray *) functionList withVarArray: (NSMutableArray *) vars{
	NSMutableString *returnString = [[NSMutableString alloc] init];
	int x=0;
	int y=0;
	int atrCount = 1;
	while ( x < [functionList count]) {
		NSMutableString *attributes = [[NSMutableString alloc] init];
		NSMutableString *build = [[NSMutableString alloc] init];
		Command *z = [Command alloc];
		NSMutableArray *currentInstructionArray = [[NSMutableArray alloc] initWithArray:[functions objectAtIndex:x]];	
		while ( y < [currentInstructionArray count]) {
			z = [currentInstructionArray objectAtIndex:y];
			if (![z attribute]) { 
				[build appendString:[cmdEncoding checkType:z withVarArray:vars]];
				y++;
			}
			else {
				[attributes appendString:[NSString stringWithFormat:@"set %@=%%%i\n",[z varName], atrCount]];
				y++;
				atrCount++;
			}
		}
		if ([attributes length] > 0) { [attributes deleteCharactersInRange:NSMakeRange([attributes length]-1, 1)]; }
		z = [currentInstructionArray lastObject];
		[returnString appendString:[NSString stringWithFormat:@":%@\nSETLOCAL\n%@\n%@\n\n", [functionList objectAtIndex:x], attributes, build]];
		y=0;
		x++;
	}
	return returnString;
}

+ (NSMutableString *) checkType: (Command *) x withVarArray: (NSMutableArray *) vars{
	NSMutableString *display = [[NSMutableString alloc] init];
	if ([[x syntax] isEqualToString:@"end"]) { [display appendString:[self endWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"loop"]) { [display appendString:[self loopWithCommand:x withVarArray:vars]]; }
	if ([[x syntax] isEqualToString:@"set"]) { [display appendString:[self setVarWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"get"]) { [display appendString:[self getWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"print"]) { [display appendString:[self printWithCommand:x]]; }
	if ([[x syntax] isEqualToString:@"callFunc"]) { [display appendString:[self callWithCommand:x]];	}
	if ([[x syntax] isEqualToString:@"return"]) { [display appendString:[self returnWithCommand:x]];	}
	if ([[x syntax] isEqualToString:@"void"]) { [display appendString:[self returnVoidWithCommand:x]];	}
	return display;
}

@end