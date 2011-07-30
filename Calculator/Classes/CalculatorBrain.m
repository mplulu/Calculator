//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Gia Dang on 3/13/11.
//  Copyright 2011 RMIT. All rights reserved.
//

#import "CalculatorBrain.h"


@implementation CalculatorBrain

@synthesize operand;



	
-(id)expression{
	return [internalExpression copy];
}





-(void)performWaitingOperation{
	if([@"+" isEqual:waitingOperation]){
		operand=waitingOperand +operand;
	}else if ([@"*" isEqual:waitingOperation]) {
		operand=waitingOperand * operand;
	}else if ([@"/" isEqual:waitingOperation]) {
		if(operand){
			operand=waitingOperand/operand;
		}
	}else if ([@"-" isEqual:waitingOperation]) {
		operand=waitingOperand - operand;
	}
	[waitingOperation release];
}





-(double)performOperation:(NSString *)operation{
	if([operation isEqual:@"sqrt"]){
		operand=sqrt(operand);
	}else if ([@"+/-" isEqual:operation]){
		operand=-operand;
	}else{
		[self performWaitingOperation];
		waitingOperation = operation;
		waitingOperand=operand;
	}
	
	return operand;
}


- (void)setOperand:(double)aDouble{
	[internalExpression addObject:[NSNumber numberWithDouble:aDouble]];
}
- (void)setVariableAsOperand:(NSString *)variableName{
	NSString *variable=VARIABLE_PREFIX;
	[internalExpression addObject:[variable stringByAppendingString:variableName]];
}
	 
+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables; 

+ (NSSet *)variablesInExpression:(id)anExpression{
	NSMutableSet *variables=[[NSMutableSet alloc] init];
	for(id obj in anExpression){
		if([obj isKindOfClass:[NSString class]]){
			if([(NSString *)obj hasPrefix:VARIABLE_PREFIX]){
				[variables addObject:[(NSString *)obj substringFromIndex:1]];
			}
		}
	}

}


+ (NSString *)descriptionOfExpression:(id)anExpression{
	NSString description=@"";
	for(id obj in anExpression){
		if([obj isKindOfClass:[NSString class]]){
			if([(NSString *)obj hasPrefix:VARIABLE_PREFIX]){
				[description stringByAppendingString:[(NSString *)obj substringFromIndex:1]];
			}else {
				[description stringByAppendingString:(NSString *)obj];
			}

		}else {
			[description stringByAppendingString:[(NSNumber *)obj stringValue]];
		}

	}
}
	
+ (id)propertyListForExpression:(id)anExpression{

}
+ (id)expressionForPropertyList:(id)propertyList;

@end
