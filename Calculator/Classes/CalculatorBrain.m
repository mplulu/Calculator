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
@synthesize waitingOperation;
-(id)init{
	if(self=[super init]){
		internalExpression=[[NSMutableArray alloc] init];
		[internalExpression retain];
	}
	return self;
}


	
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
	NSLog(@"%d",[internalExpression count]);
	operand=aDouble;
}

-(void)setWaitingOperation:(NSString *) aWaitingOperation{
	[internalExpression addObject:aWaitingOperation];
	waitingOperation=aWaitingOperation;
	
}

- (void)setVariableAsOperand:(NSString *)variableName{
	NSString *variable=VARIABLE_PREFIX;
	[internalExpression addObject:[variable stringByAppendingString:variableName]];
}
	 
+ (double)evaluateExpression:(id)anExpression
		 usingVariableValues:(NSDictionary *)variables{
	double result=0;
	for(id obj in anExpression){
		if([obj isKindOfClass:[NSNumber class]]){
			operand=[(NSNumber *)obj doubleValue];
		}else {
			if ([(NSString *)obj hasPrefix:VARIABLE_PREFIX]) {
				NSString *variable=[(NSString *)obj substringFromIndex:1];
				double anOperand=[[variables objectForKey:variable] doubleValue];
				operand=anOperand;
			}else {
				result=[self performOperation:(NSString *)obj];
			}

		}
	}
	return result;

}

+ (NSSet *)variablesInExpression:(id)anExpression{
	NSMutableSet *variables=[[NSMutableSet alloc] init];
	for(id obj in anExpression){
		if([obj isKindOfClass:[NSString class]]){
			if([(NSString *)obj hasPrefix:VARIABLE_PREFIX]){
				NSString *variable=[(NSString *)obj substringFromIndex:1];
				if(![variables member:variable]){
					[variables addObject:variable];
				}
				
			}
		}
	}
	if([variables count]==0){
		return nil;
	}else{
		return variables;
	}

}


+ (NSString *)descriptionOfExpression:(id)anExpression{
	NSString *description=@"";
	
	for(id obj in anExpression){
		
		if([obj isKindOfClass:[NSString class]]){
			NSString *str=(NSString *)obj;
			if([(NSString *)obj hasPrefix:VARIABLE_PREFIX]){
				description=[description stringByAppendingString:[str substringFromIndex:1]];
			}else {
				description=[description stringByAppendingString:str];
			}
			NSLog(@"des %@",description);
			
			NSLog(@"%@",str);
		}else {
			NSLog(@"%g",[obj doubleValue]);
			NSNumber *num=(NSNumber *)obj;
			description=[description stringByAppendingString:[num stringValue]];
		}

	}
	NSLog(@"%@",description);
	[description retain];
	return description;
}
	
+ (id)propertyListForExpression:(id)anExpression{
	return anExpression;
}
+ (id)expressionForPropertyList:(id)propertyList{
	return propertyList;
}

@end
