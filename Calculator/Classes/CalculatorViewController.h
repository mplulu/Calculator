//
//  CalculatorViewController.h
//  Calculator
//
//  Created by Gia Dang on 3/13/11.
//  Copyright 2011 RMIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorBrain.h"

@interface CalculatorViewController : UIViewController {

	@private
		IBOutlet UILabel *display;
		CalculatorBrain *brain;
		BOOL userIsInTheMiddleOfTypingANumber;
}

@property (readonly) CalculatorBrain *brain;
@property (nonatomic,retain) IBOutlet UILabel *display;
@property (readonly) BOOL userIsInTheMiddleOfTypingANumber;



-(IBAction)digitPressed:(UIButton *)sender;
-(IBAction)operationPressed:(UIButton *)sender;
-(IBAction)variablePressed:(UIButton *)sender;
-(IBAction)solvePressed:(UIButton *)sender;

@end

