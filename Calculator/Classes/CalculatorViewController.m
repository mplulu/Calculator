//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Gia Dang on 3/13/11.
//  Copyright 2011 RMIT. All rights reserved.
//

#import "CalculatorViewController.h"

@implementation CalculatorViewController


@synthesize display;
@synthesize brain;
-(CalculatorBrain *)brain{
	if(!brain){ 
		brain=[[CalculatorBrain alloc] init];
	}
	
	return brain;
}




-(IBAction)operationPressed:(UIButton *)sender{
	if(userIsInTheMiddleOfTypingANumber){
		self.brain.operand=[[display text] doubleValue];
		userIsInTheMiddleOfTypingANumber=NO;
	}
	NSString *operation=[[sender titleLabel] text];
	double result=[self.brain performOperation:operation];
	[display setText:[NSString stringWithFormat:@"%g",result]];
	
}



-(IBAction)digitPressed:(UIButton *)sender{
	
	NSString *digit=[[sender titleLabel] text];
	if(userIsInTheMiddleOfTypingANumber){
		[display setText:[[display text] stringByAppendingFormat:digit]];
	}else{
		[display setText:digit];
		userIsInTheMiddleOfTypingANumber=YES;
	}
	
}

-(IBAction)variablePressed:(UIButton *) sender{
	NSString *variable=[[sender titleLabel] text];
	[self.brain setVariableAsOperand:variable];
}

-(IBAction)solvePressed:(UIButton *) sender{
	NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:
					   @"1", @"x", 
					   @"5", @"y", 
					   @"7", @"z", 
					   @"23", @"a", nil];
	double result=[self.brain evaluateExpression:self.brain.expression usingVariableValues:dic];
	[display setText:[NSString stringWithFormat:@"%g",result]];
}

-(void)dealloc{
	[self.brain release];
	[display release];
	[super dealloc];

}


@end