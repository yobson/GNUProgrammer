#include <Foundation/Foundation.h>
#include "utils.h"
#include "command.h"

@implementation utils

+ (NSMutableString *) indentCalculator: (Command *) x{
	int indent = [x indent];
	NSMutableString *string = [[NSMutableString alloc] init];
	
	while (indent != 0) {
		[string appendString:@"   "];
		indent--;
	}
	return string;
}

@end

@implementation Converters

+ (NSMutableString *) convertIfStatement: (Command *) x forLanguage:(NSString *) lang {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	NSMutableArray *splitString = [[NSMutableArray alloc] init];
	int z = 0;
	
	if ([lang isEqualToString:@"vbs"]) {
		splitString = [[NSMutableArray alloc] initWithArray:[[x condition] componentsSeparatedByString:@" "]];
		if ([[splitString objectAtIndex:1] isEqualToString:@"=="]) { [splitString replaceObjectAtIndex:1 withObject:@"="]; }
	}
	
	if ([lang isEqualToString:@"lua"]) {
		splitString = [[NSMutableArray alloc] initWithArray:[[x condition] componentsSeparatedByString:@" "]];
		if ([[splitString objectAtIndex:1] isEqualToString:@"!="]) { [splitString replaceObjectAtIndex:1 withObject:@"~="]; }
	}
	
	while (z != [splitString count]) {
		if (z != 0) { [returnString appendString:@" "]; }
		[returnString appendString:[splitString objectAtIndex:z]];
		z++;
	}
	return returnString;
}

+ (NSMutableString *) convertIfStatement: (Command *) x forLanguage:(NSString *) lang withVarArray: (NSMutableArray *) varArray {
	NSMutableString *returnString = [[NSMutableString alloc] init];
	NSMutableArray *splitString = [[NSMutableArray alloc] init];
	int z = 0;
	
	if ([lang isEqualToString:@"cmd"]) {
		splitString = [[NSMutableArray alloc] initWithArray:[[x condition] componentsSeparatedByString:@" "]];
		if ([varArray containsObject:[splitString objectAtIndex:0]]) { [splitString replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"%%%@%%", [splitString objectAtIndex:0]]];}
		if ([varArray containsObject:[splitString objectAtIndex:2]]) { [splitString replaceObjectAtIndex:2 withObject:[NSString stringWithFormat:@"%%%@%%", [splitString objectAtIndex:2]]];}
		if ([[splitString objectAtIndex:1] isEqualToString:@"=="]) { [splitString replaceObjectAtIndex:1 withObject:@"EQU"]; }
		if ([[splitString objectAtIndex:1] isEqualToString:@">="]) { [splitString replaceObjectAtIndex:1 withObject:@"GEQ"]; }
		if ([[splitString objectAtIndex:1] isEqualToString:@"<="]) { [splitString replaceObjectAtIndex:1 withObject:@"LEQ"]; }
		if ([[splitString objectAtIndex:1] isEqualToString:@">"]) { [splitString replaceObjectAtIndex:1 withObject:@"GTR"]; }
		if ([[splitString objectAtIndex:1] isEqualToString:@"<"]) { [splitString replaceObjectAtIndex:1 withObject:@"LSS"]; }
		if ([[splitString objectAtIndex:1] isEqualToString:@"!="]) { [splitString replaceObjectAtIndex:1 withObject:@"NEQ"]; }
	}
	
	while (z != [splitString count]) {
		if (z != 0) { [returnString appendString:@" "]; }
		[returnString appendString:[splitString objectAtIndex:z]];
		z++;
	}
	return returnString;
}

@end