//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Gia Dang on 3/13/11.
//  Copyright 2011 RMIT. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VARIABLE_PREFIX @"&"

@interface CalculatorBrain : NSObject {
	@private 
	double operand;
	NSString *waitingOperation;
	double waitingOperand;
	NSMutableArray *internalExpression;
}

@property double operand;
@property NSString *waitingOperation;
@property (nonatomic,retain,readonly) id expression; 


- (void)setOperand:(double)aDouble; 
- (void)setVariableAsOperand:(NSString *)variableName; 
- (double)performOperation:(NSString *)operation;

+ (double)evaluateExpression:(id)anExpression
		usingVariableValues:(NSDictionary *)variables; 

+ (NSSet *)variablesInExpression:(id)anExpression;
+ (NSString *)descriptionOfExpression:(id)anExpression; 

+ (id)propertyListForExpression:(id)anExpression;
+ (id)expressionForPropertyList:(id)propertyList;

@end
