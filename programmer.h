/* All Rights reserved */

#include <AppKit/AppKit.h>

@interface programmer : NSObject
{
  id command;
  id endWhileButton;
  id ifA;
  id endIfButton;
  id whileA;
  id varSetValue;
  id varMakeName;
  id varManName;
  id ifB;
  id ifEQ;
  id ifLS;
  id ifNEQ;
  id ifGR;
  id atributes;
  id callStore;
  id functionName;
  id getVar;
  id instuctionToRemove;
  id newFunctionName;
  id newFunctionButton;
  id parse;
  id printText;
  id retFloatButton;
  id retIntButton;
  id retStrButton;
  id retVoidButton;
  id returnVar;
  id whileB;
  id whileEQ;
  id whileGR;
  id whileLS;
  id whileNEQ;
  
  int whileCount;
  int ifCount;
 
  @private
  bool initialised; //Has initApp run?
  bool inFunction;
  
  int indent; //calculates indent
  NSMutableArray *instructionArray; //All commands added to this array
  NSMutableString *display; //What the big textbox is displaying
  NSMutableArray *lastWhile; //active while conditions
  NSMutableArray *lastIf;
  NSMutableArray *varNames;
  NSMutableArray *varTypes;
  NSMutableArray *functions;
  NSMutableArray *functionList;
  
  //Function Backups
  NSMutableArray *backupInstructions;
  NSMutableArray *backupLastWhile;
  NSMutableArray *backupLastIf;
  NSMutableArray *backupVarNames;
  NSMutableArray *backupVarTypes;
  int backupIndent;
  int backupWhileCount;
  int backupIfCount;
  
}
- (void) endWhile: (id)sender;
- (void) ifAdd: (id)sender;
- (void) endIf: (id)sender;
- (void) whileAdd: (id)sender;
- (void) setVar: (id)sender;
- (void) setFloat: (id)sender;
- (void) setInt: (id)sender;
- (void) setString: (id)sender;
- (void) addFunction: (id)sender;
- (void) get: (id)sender;
- (void) retFloat: (id)sender;
- (void) newFunction: (id)sender;
- (void) print: (id)sender;
- (void) removeInstruction: (id)sender;
- (void) retInt: (id)sender;
- (void) retStr: (id)sender;
- (void) showFunk: (id)sender;
- (void) showIns: (id)sender;
- (void) compile: (id)sender;
- (void) retVoid: (id)sender;

- (void)initApp;
- (void) updateTable;
- (void) initFunctionBackup;
- (void) updateTableWithFunc;
- (void) endFunc;
- (NSString *) returnTypeOf: (NSString *) varName;
- (void) removeVariable: (NSString *) varName;
@end
