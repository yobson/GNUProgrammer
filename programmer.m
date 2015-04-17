/* 
All Rights reserved 
James Hobson Copyright 2015
*/

#include <AppKit/AppKit.h>

#include "programmer.h"
#include "command.h"
#include <EncodingClasses/cppEncoding.h>
#include <EncodingClasses/vbsEncoding.h>
#include <EncodingClasses/pytwoEncoding.h>
#include <EncodingClasses/pythreeEncoding.h>

@implementation programmer


- (void) endWhile: (id)sender
{
  Command *x = [Command alloc]; //Instantiate a Command object
  indent--; //Remove the indent
  [x setIndent:indent]; //load indent into x
  [x setSyntax:@"end"];  //load the syntax family into x
  [x setSubSyntax:@"while"];
  NSString *desc = [[NSString alloc] initWithFormat:@"End While: %@\n", [lastWhile lastObject]]; //Make format string with loop condition that is being ended
  [x setText:desc]; //sets this as the text to diplay
  [instructionArray addObject:x]; //all done. add to instruction array
  [self updateTable]; //update the table
  whileCount--; //remove 1 from the while counter
  [lastWhile removeLastObject]; //remove the last while loop condition stored
  if (whileCount < 1) {[endWhileButton setEnabled:NO]; [endWhileButton setTitle:@"End While"]; } //Works out what to set as the End While button text
  else {
  NSString *newText = [[NSString alloc] initWithFormat:@"End: %@", [lastWhile lastObject]];
  [endWhileButton setTitle:newText];
  }
}


- (void) ifAdd: (id)sender
{
  if (!initialised) { [self initApp]; }
  //First run Checks:
  if ([ifEQ state] && [ifNEQ state]){ [command setStringValue:@"ERROR: Cannot check if Equal and Not Equal!"]; }
  else if ([ifGR state] && [ifLS state]) { [command setStringValue:@"ERROR: Cannot check if Less and Greater Than!"]; }
  else if ([ifNEQ state] && ([ifLS state] || [ifGR state])) { [command setStringValue:@"ERROR: Cannot check notEqual and Less or Greater Than"]; }
  else if (![ifEQ state] && ![ifNEQ state] && ![ifLS state] && ![ifGR state]) { [command setStringValue:@"ERROR: Please select a condition"]; }
  else {
	  Command *x = [Command alloc];
	  [x setSyntax:@"loop"];
	  [x setSubSyntax:@"if"];
	  [x setIndent:indent];
	  indent++;
	  
	  //Deduces condition
	  NSString *ifState;
	  NSString *vbifState = [[NSString alloc] init];
	  if ([ifEQ state] && !([ifLS state] || [ifGR state])) { ifState = [[NSString alloc] initWithFormat:@"%@ == %@", [ifA stringValue], [ifB stringValue]];
														   vbifState = [[NSString alloc] initWithFormat:@"%@ = %@", [ifA stringValue], [ifB stringValue]];}
	  if ([ifEQ state] && [ifGR state]) { ifState = [[NSString alloc] initWithFormat:@"%@ >= %@", [ifA stringValue], [ifB stringValue]]; vbifState = ifState; }
	  if ([ifEQ state] && [ifLS state]) { ifState = [[NSString alloc] initWithFormat:@"%@ <= %@", [ifA stringValue], [ifB stringValue]]; vbifState = ifState;}
	  if (![ifEQ state] && [ifGR state]) { ifState = [[NSString alloc] initWithFormat:@"%@ > %@", [ifA stringValue], [ifB stringValue]]; vbifState = ifState;}
	  if (![ifEQ state] && [ifLS state]) { ifState = [[NSString alloc] initWithFormat:@"%@ < %@", [ifA stringValue], [ifB stringValue]]; vbifState = ifState;}
	  if ([ifNEQ state]) { ifState = [[NSString alloc] initWithFormat:@"%@ != %@", [ifA stringValue], [ifB stringValue]]; }
	  [x setCondition:ifState];
	  [x setVbsCondition:vbifState];
	  
	  NSString *desc = [[NSString alloc] initWithFormat:@"IF: %@\n" ,ifState];
	  [x setText:desc];
	  
	  [instructionArray addObject:x];
	  [self updateTable];
	  
	  [endIfButton setEnabled:YES];
      NSString *newText = [[NSString alloc] initWithFormat:@"End: %@", [x condition]];
      [endIfButton setTitle:newText];
	  [lastIf addObject:[x condition]];
	  ifCount++;
  }
  
}


- (void) endIf: (id)sender
{
  Command *x = [Command alloc];
  indent--;
  [x setIndent:indent];
  [x setSyntax:@"end"];
  [x setSubSyntax:@"if"];
  NSString *desc = [[NSString alloc] initWithFormat:@"End if: %@\n", [lastIf lastObject]];
  [x setText:desc];
  [instructionArray addObject:x];
  [self updateTable];
  ifCount--;
  [lastIf removeLastObject];
  if (ifCount < 1) {[endIfButton setEnabled:NO]; [endIfButton setTitle:@"End If"]; }
  else {
  NSString *newText = [[NSString alloc] initWithFormat:@"End: %@", [lastIf lastObject]];
  [endIfButton setTitle:newText];
  }
}


- (void) whileAdd: (id)sender
{
  if (!initialised) { [self initApp]; }
  //First run Checks:
  if ([whileEQ state] && [whileNEQ state]){ [command setStringValue:@"ERROR: Cannot check if Equal and Not Equal!"]; }
  else if ([whileGR state] && [whileLS state]) { [command setStringValue:@"ERROR: Cannot check if Less and Greater Than!"]; }
  else if ([whileNEQ state] && ([whileLS state] || [whileGR state])) { [command setStringValue:@"ERROR: Cannot check notEqual and Less or Greater Than"]; }
  else if (![whileEQ state] && ![whileNEQ state] && ![whileLS state] && ![whileGR state]) { [command setStringValue:@"ERROR: Please select a condition"]; }
  else {
	  Command *x = [Command alloc];
	  [x setSyntax:@"loop"];
	  [x setSubSyntax:@"while"];
	  [x setIndent:indent];
	  indent++;
	  
	  //Deduces condition
	  NSString *whileState;
	  if ([whileEQ state] && !([whileLS state] || [whileGR state])) { whileState = [[NSString alloc] initWithFormat:@"%@ = %@", [whileA stringValue], [whileB stringValue]]; }
	  if ([whileEQ state] && [whileGR state]) { whileState = [[NSString alloc] initWithFormat:@"%@ >= %@", [whileA stringValue], [whileB stringValue]]; }
	  if ([whileEQ state] && [whileLS state]) { whileState = [[NSString alloc] initWithFormat:@"%@ <= %@", [whileA stringValue], [whileB stringValue]]; }
	  if (![whileEQ state] && [whileGR state]) { whileState = [[NSString alloc] initWithFormat:@"%@ > %@", [whileA stringValue], [whileB stringValue]]; }
	  if (![whileEQ state] && [whileLS state]) { whileState = [[NSString alloc] initWithFormat:@"%@ < %@", [whileA stringValue], [whileB stringValue]]; }
	  if ([whileNEQ state]) { whileState = [[NSString alloc] initWithFormat:@"%@ != %@", [whileA stringValue], [whileB stringValue]]; }
	  [x setCondition:whileState];
	  
	  NSString *desc = [[NSString alloc] initWithFormat:@"WHILE: %@\n" ,whileState];
	  [x setText:desc];
	  
	  [instructionArray addObject:x];
	  [self updateTable];
	  
	  [endWhileButton setEnabled:YES];
      NSString *newText = [[NSString alloc] initWithFormat:@"End: %@", [x condition]];
      [endWhileButton setTitle:newText];
	  [lastWhile addObject:[x condition]];
	  whileCount++;
  }
}

- (void) setVar: (id)sender
{
  if (!initialised){ [self initApp]; }
  if ([varNames containsObject:[varManName stringValue]]) { //Checking to see if the variable has been declared
	  Command *x = [Command alloc]; //New Command
	  [x setIndent:indent]; //Sets Indent
	  [x setSyntax:@"set"];
	  [x setVarName:[varManName stringValue]];
	  [x setCondition:[varSetValue stringValue]];
	  NSString *desc = [[NSString alloc] initWithFormat:@"Setting %@ = %@\n", [x varName], [x condition]];
	  [x setText:desc];
	  
	  [instructionArray addObject:x];
	  [self updateTable];
	  
  } else {
	  NSString *error = [[NSString alloc] initWithFormat:@"ERROR: Created variable:%@ before assigning a value", [varManName stringValue]];
	  [command setStringValue:error];
  }
}


- (void) setFloat: (id)sender
{
  if (!initialised) { [self initApp];}
  [self removeVariable:[varMakeName stringValue]];
  Command *x = [Command alloc];
  [x setSyntax:@"var"];
  [x setIndent:indent];
  [x setSubSyntax:@"float"];
  [x setVarName:[varMakeName stringValue]];
  NSString *desc;
  desc = [[NSString alloc] initWithFormat:@"Creating Float: %@\n",[x varName]];
  if ( [parse state]) { [x setAttribute:YES]; desc = [[NSString alloc] initWithFormat:@"Passing in Float: %@\n",[x varName]];}
  [x setText:desc];
  [varTypes addObject:@"float"];
  [varNames addObject:[x varName]];
  [instructionArray addObject:x];
  [self updateTable];
}


- (void) setInt: (id)sender
{
  if (!initialised) { [self initApp];}
  [self removeVariable:[varMakeName stringValue]];
  Command *x = [Command alloc];
  [x setSyntax:@"var"];
  [x setIndent:indent];
  [x setSubSyntax:@"int"];
  [x setVarName:[varMakeName stringValue]];
  NSString *desc;
  desc = [[NSString alloc] initWithFormat:@"Creating Integer: %@\n",[x varName]];
  if ( [parse state]) { [x setAttribute:YES]; desc = [[NSString alloc] initWithFormat:@"Passing in Integer: %@\n",[x varName]];}
  [x setText:desc];
  [varTypes addObject:@"int"];
  [varNames addObject:[x varName]];
  [instructionArray addObject:x];
  [self updateTable];
}


- (void) setString: (id)sender
{
  if (!initialised) { [self initApp];}
  [self removeVariable:[varMakeName stringValue]];
  Command *x = [Command alloc];
  [x setSyntax:@"var"];
  [x setIndent:indent];
  [x setSubSyntax:@"string"];
  [x setVarName:[varMakeName stringValue]];
  NSString *desc;
  desc = [[NSString alloc] initWithFormat:@"Creating String: %@\n",[x varName]];
  if ( [parse state]) { [x setAttribute:YES]; desc = [[NSString alloc] initWithFormat:@"Passing in String: %@\n",[x varName]];}
  [x setText:desc];
  [varTypes addObject:@"string"];
  [varNames addObject:[x varName]];
  [instructionArray addObject:x];
  [self updateTable];
}

- (void) removeInstruction: (id)sender
{
  [instructionArray removeObjectAtIndex:(NSUInteger)([instuctionToRemove intValue] - 1)];
  [self updateTable];
}

- (void) addFunction: (id)sender 
{
	if (!initialised) { [self initApp];}
	if ((![functionList containsObject:[functionName stringValue]]))  { [command setStringValue:@"ERROR: Calling a function that doesn't exist"]; }
	else if (![varNames containsObject:[callStore stringValue]] && !([[callStore stringValue] isEqualToString:@""])) { [command setStringValue:@"ERROR: please create that variable first!"]; }
	else {
		Command *x = [Command alloc];
		[x setSyntax:@"callFunc"];
		[x setReturnType:[atributes stringValue]];
		[x setIndent:indent];
		NSString *desc;
		desc = [[NSString alloc] initWithFormat:@"Setting: %@ equal to the output of: %@(%@)\n", [callStore stringValue], [functionName stringValue], [atributes stringValue]];
		if ([[callStore stringValue] isEqualToString:@""]) { [x setSubSyntax:@"void"]; desc = [[NSString alloc] initWithFormat:@"Running: %@(%@)\n", [functionName stringValue], [atributes stringValue]]; }
		else { [x setSubSyntax:@"non-void"]; [x setVarName:[callStore stringValue]]; }
		
		[x setCondition:[functionName stringValue]];
		[x setText:desc];
		[instructionArray addObject:x];
		[self updateTable];
	}
}


- (void) get: (id)sender
{
  if (!initialised){ [self initApp]; }
  if ([varNames containsObject:[getVar stringValue]]) { //Checking to see if the variable has been declared
	  Command *x = [Command alloc]; //New Command
	  [x setIndent:indent]; //Sets Indent
	  [x setSyntax:@"get"];
	  [x setSubSyntax:[self returnTypeOf:[getVar stringValue]]];
	  [x setVarName:[getVar stringValue]];
	  NSString *desc = [[NSString alloc] initWithFormat:@"Setting %@ = User Input\n", [x varName]];
	  [x setText:desc];
	  
	  [instructionArray addObject:x];
	  [self updateTable];
	  
  } else {
	  NSString *error = [[NSString alloc] initWithFormat:@"ERROR: Created variable:%@ before assigning a value", [varManName stringValue]];
	  [command setStringValue:error];
  }
}

- (void) newFunction: (id)sender
{
	if (!initialised){ [self initApp]; }
if ([[newFunctionName stringValue] isEqualToString:@""] ) { [command setStringValue:@"ERROR: Give a name to the Function!"]; }
if ([functionList containsObject:[newFunctionName stringValue]] ) { [command setStringValue:@"ERROR: Give a UNIQUE NAME to the Function!"]; }
	else {
	//Setup GUI
	[newFunctionButton setEnabled:NO];
	[retFloatButton setEnabled:YES];
	[retIntButton setEnabled:YES];
	[retStrButton setEnabled:YES];
	[retVoidButton setEnabled:YES];
	[parse setEnabled:YES];
	[parse setState:YES];
	inFunction = YES;
	
	[functionList addObject:[newFunctionName stringValue]];
  
	//backup stack
	[self initFunctionBackup];
	instructionArray = [[NSMutableArray alloc] init];
	display = [[NSMutableString alloc] init];
	lastWhile = [[NSMutableArray alloc] init];
	lastIf = [[NSMutableArray alloc] init];
	varNames = [[NSMutableArray alloc] init];
	whileCount = 0;
	ifCount = 0;
	[self updateTable];
   }
}


- (void) print: (id)sender
{
	if (!initialised){ [self initApp]; }
	Command *x = [Command alloc];
	[x setSyntax:@"print"];
	[x setIndent:indent];
	NSString *desc;
	if ([varNames containsObject:[printText stringValue]]) { 
		[x setSubSyntax:[printText stringValue]];
		desc = [[NSString alloc] initWithFormat:@"Printing variable:%@\n", [x subSyntax]];
	}
	if (![varNames containsObject:[printText stringValue]]) {
		NSString *subSyntax = [[NSString alloc] initWithFormat:@"\"%@\"", [printText stringValue]];
		[x setSubSyntax:subSyntax];
		desc = [[NSString alloc] initWithFormat:@"Printing text:%@\n", [x subSyntax]];
	}
	[x setText:desc];
	
	[instructionArray addObject:x];
	[self updateTable];
}

- (void) retFloat: (id)sender
{
  if (![varNames containsObject:[returnVar stringValue]]) { [command setStringValue:@"ERROR: must declare return value!"]; }
  else {
	Command *x = [Command alloc];
	[x setIndent:indent];
	[x setSyntax:@"return"];
	[x setReturnType:@"float"];
	[x setVarName:[returnVar stringValue]];
	[instructionArray addObject:x];
	[self endFunc];
	[self updateTable];
  }
}

- (void) retInt: (id)sender
{
	if (![varNames containsObject:[returnVar stringValue]]) { [command setStringValue:@"ERROR: must declare return value!"]; }
	else {
		Command *x = [Command alloc];
		[x setIndent:indent];
		[x setSyntax:@"return"];
		[x setReturnType:@"int"];
		[x setVarName:[returnVar stringValue]];
		[instructionArray addObject:x];
		[self endFunc];
		[self updateTable];
	}
}


- (void) retStr: (id)sender
{
  if (![varNames containsObject:[returnVar stringValue]]) { [command setStringValue:@"ERROR: must declare return value!"]; }
  else {
	Command *x = [Command alloc];
	[x setIndent:indent];
	[x setSyntax:@"return"];
	[x setReturnType:@"str"];
	[x setVarName:[returnVar stringValue]];
	[instructionArray addObject:x];
	[self endFunc];
	[self updateTable];
  }
}

- (void) retVoid: (id)sender
{
  Command *x = [Command alloc];
  [x setIndent:indent];
  [x setSyntax:@"void"];
  [x setReturnType:@"void"];
  [x setVarName:[returnVar stringValue]];
  [instructionArray addObject:x];
  [self endFunc];
  [self updateTable];
}


- (void) showFunk: (id)sender
{
	if (!initialised){ [self initApp]; }
  [self updateTableWithFunc];
  [command setSelectable:NO];
}

- (void) compile: (id)sender
{
  	int instructionNO = 1;
	int x = 0;
	if ([instuctionToRemove intValue] == 1) {
		[display setString:@"Copy and paste this into .vbs file\n\n"];
		Command *current = [Command alloc];
		[display appendString:[VBSEncoding functionWithArray:functions functionList:functionList]];
		while (x != [instructionArray count]) {
			current = [instructionArray objectAtIndex:x];
			[display appendString:[VBSEncoding checkType:current]];
			x++;
			instructionNO++;
		}
	}
	else if ([instuctionToRemove intValue] == 2) {
		[display setString:@"Copy and paste this into .cpp file\n\n"];
		Command *current = [Command alloc];
		[display appendString:[CPPEncoding setUpFile]];
		[display appendString:[CPPEncoding functionWithArray:functions functionList:functionList]];
		[display appendString:[CPPEncoding setUpMain]];
		while (x != [instructionArray count]) {
			current = [instructionArray objectAtIndex:x];
			int z = [current indent];
			[current setIndent:z+1];
			[display appendString:[CPPEncoding checkType:current]];
			[current setIndent:z];
			x++;
			instructionNO++;
		}
		[display appendString:[CPPEncoding endWithCommand:NULL]];
	}
	
	else if ([instuctionToRemove intValue] == 3) {
		[display setString:@"Copy and paste this into .py file\n\n"];
		Command *current = [Command alloc];
		[display appendString:[PYEncoding functionWithArray:functions functionList:functionList]];
		while (x != [instructionArray count]) {
			current = [instructionArray objectAtIndex:x];
			[display appendString:[PYEncoding checkType:current]];
			x++;
			instructionNO++;
		}
		[display appendString:[PYEncoding endWithCommand:NULL]];
	}
	
	else if ([instuctionToRemove intValue] == 4) {
		[display setString:@"Copy and paste this into .py file\n\n"];
		Command *current = [Command alloc];
		[display appendString:[PY3Encoding functionWithArray:functions functionList:functionList]];
		while (x != [instructionArray count]) {
			current = [instructionArray objectAtIndex:x];
			[display appendString:[PY3Encoding checkType:current]];
			x++;
			instructionNO++;
		}
		[display appendString:[PYEncoding endWithCommand:NULL]];
	}
	
	else if ([instuctionToRemove intValue] == 4) {
		[display setString:@"Copy and paste this into .cpp file\n\n"];
		Command *current = [Command alloc];
		[display appendString:[CPPEncoding setUpFile]];
		[display appendString:[CPPEncoding functionWithArray:functions functionList:functionList]];
		[display appendString:[CPPEncoding setUpMain]];
		while (x != [instructionArray count]) {
			current = [instructionArray objectAtIndex:x];
			int indentZ = [current indent];
			[current setIndent:indentZ+1];
			[display appendString:[CPPEncoding checkType:current]];
			x++;
			instructionNO++;
		}
		[display appendString:[CPPEncoding endWithCommand:NULL]];
	}
	
	else {
		[display setString:@"Select format!\n\nYour options are:\n	1: VBS\n	2: C++\n	3: Python 2.7\n	4: Python 3.4\n\n\n\nPlace your choice in Bottom right box"];
	}
	//[self writeString:display toFile:@"hello.vbs"];
	[command setSelectable:YES];
	[command setStringValue:display];
}

- (void) showIns: (id)sender
{
	[command setSelectable:NO];
  [self updateTable];
}



- (void) initApp {
	[command setSelectable:YES];
	functions = [[NSMutableArray alloc] init];
	functionList = [[NSMutableArray alloc] init];
	indent = 0;
	instructionArray = [[NSMutableArray alloc] init];
	display = [[NSMutableString alloc] init];
	lastWhile = [[NSMutableArray alloc] init];
	lastIf = [[NSMutableArray alloc] init];
	varNames = [[NSMutableArray alloc] init];
	varTypes = [[NSMutableArray alloc] init];
	whileCount = 0;
	ifCount = 0;
	
	initialised = YES;	
}

- (void) initFunctionBackup {
  backupInstructions = [[NSMutableArray alloc] initWithArray:instructionArray];
  backupLastWhile = [[NSMutableArray alloc] initWithArray:lastWhile];
  backupLastIf = [[NSMutableArray alloc] initWithArray:lastIf];
  backupVarNames = [[NSMutableArray alloc] initWithArray:varNames];
  backupVarTypes = [[NSMutableArray alloc] initWithArray:varTypes];
  backupIndent = indent;
  backupWhileCount = whileCount;
  backupIfCount = ifCount;
}

- (void) endFunc {
		if (!initialised){ [self initApp]; }
	if (inFunction) {
	
		
		[newFunctionButton setEnabled:YES];
		[retFloatButton setEnabled:NO];
		[retIntButton setEnabled:NO];
		[retStrButton setEnabled:NO];
		[retVoidButton setEnabled:NO];
		[parse setEnabled:NO];
		[parse setState:NO];
	
		[functions addObject:instructionArray];
		
		instructionArray = [[NSMutableArray alloc] initWithArray:backupInstructions];
		lastWhile = [[NSMutableArray alloc] initWithArray:backupLastWhile];
		lastIf = [[NSMutableArray alloc] initWithArray:backupLastIf];
		varNames = [[NSMutableArray alloc] initWithArray:backupVarNames];
		varTypes = [[NSMutableArray alloc] initWithArray:backupVarTypes];
		indent = backupIndent;
		whileCount = backupWhileCount;
		ifCount = backupIfCount;
		
		inFunction = NO;
	}
}

- (void) updateTable {
	int instructionNO = 1;
	int x = 0;
	[display setString:@""];
	Command *current = [Command alloc];
	[display appendString:@"Commands:\n\n"];
	while (x != [instructionArray count]) {
		current = [instructionArray objectAtIndex:x];
		NSString *stringIndent = [CPPEncoding indentCalculator:current];
		NSString *text = [[NSString alloc] initWithFormat:@"%d:%@ %@",instructionNO, stringIndent, [current text]];
		[display appendString:text];
		x++;
		instructionNO++;
	}
	[command setStringValue:display];

}

- (void) updateTableWithFunc {
	int x=0;
	int y=0;
	int no = 1;
	[display setString:@""];
	[display appendString:@"Function List:\n\n"];
	while ( x < [functionList count]) {
		Command *z = [Command alloc];
		NSMutableArray *currentInstructionArray = [[NSMutableArray alloc] initWithArray:[functions objectAtIndex:x]];
		z = [currentInstructionArray lastObject];
		NSString *currentFuncName = [[NSString alloc] initWithFormat:@"%d: %@ Returns: %@\n  ", no, [functionList objectAtIndex:x], [z returnType]];
		[display appendString:currentFuncName];		
		while ( y < [currentInstructionArray count]) {
			z = [currentInstructionArray objectAtIndex:y];
			if (![z attribute]) { y++; }
			else {
				NSString *text = [[NSString alloc] initWithFormat:@"  %@:%@", [z subSyntax], [z varName]];
				[display appendString:text];
				y++;
			}			
		}
		
		y=0;
		x++;
		no++;
		[display appendString:@"\n\n"];
	}
	[command setStringValue:display];
}

- (NSString *) returnTypeOf: (NSString *) varName {
	int x = 0;
	NSString *returnString = [[NSString alloc] init];
	while (x < [varNames count]) {
		if ([[varNames objectAtIndex:x] isEqualToString:varName]) {
			returnString = [varTypes objectAtIndex:x];
		}
		x++;
	}
	return returnString;
}

- (void) removeVariable: (NSString *) varName{ 
	int x = 0;
	while (x < [varNames count]) {
		if ([[varNames objectAtIndex:x] isEqualToString:varName]) {
			[varNames removeObjectAtIndex:x];
			[varTypes removeObjectAtIndex:x];
		}
		x++;
	}
}
/*
- (void) writeString: (NSString *) string toFile: (NSString *) name {
	NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString* fileName = name;
	NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
	[[NSFileManager defaultManager] createFileAtPath:fileAtPath contents:nil attributes:nil];
	[[string dataUsingEncoding:NSUTF8StringEncoding] writeToFile:fileAtPath atomically:NO];
	
}
*/
@end
