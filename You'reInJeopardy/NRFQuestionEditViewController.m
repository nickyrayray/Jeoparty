//
//  NRFQuestionEditViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 6/11/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFQuestionEditViewController.h"

@interface NRFQuestionEditViewController ()

@property (strong, nonatomic) NRFQuestion *question;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UITextField *questionAnswerTextLabel;
@property (strong, nonatomic) UITextField *finalJeopardyCategoryTextField;
@property BOOL mightNeedIncrement;
@property BOOL isFinalJeoparty;

@end

@implementation NRFQuestionEditViewController

- (id)initWithQuestion:(NRFQuestion *)question
{
    self = [super initWithNibName:@"NRFQuestionEditViewController" bundle:nil];
    if (self) {
        self.question = question;
        if([self.question isFinished])
            self.mightNeedIncrement = NO;
        else
            self.mightNeedIncrement = YES;
        self.isFinalJeoparty = NO;
    }
    return self;
}

-(id)initWithFinalJeopartyQuestion:(NRFFinalJeopartyQuestion *)finalJeopartyQuestion;
{
    self = [super initWithNibName:@"NRFQuestionEditViewController" bundle:nil];
    if(self) {
        self.question = finalJeopartyQuestion;
        self.isFinalJeoparty = YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.question.question){
        self.questionTextView.text = self.question.question;
    }
    
    if(self.question.answer){
        self.questionAnswerTextLabel.text = self.question.answer;
    }
    
    if(self.isFinalJeoparty){
        self.finalJeopardyCategoryTextField = [self finalJeopartyTextFieldSetup];
        [self.view addSubview:self.finalJeopardyCategoryTextField];
        NRFFinalJeopartyQuestion *castedFJQuestion = (NRFFinalJeopartyQuestion *)self.question;
        if(castedFJQuestion.category && ![castedFJQuestion.category isEqualToString:@""])
            self.finalJeopardyCategoryTextField.text = castedFJQuestion.category;
    } else
        self.navigationItem.title = @"Enter Question";
    
}

- (IBAction)doneButtonPressed:(id)sender {
    
    self.question.question = self.questionTextView.text;
    self.question.answer = self.questionAnswerTextLabel.text;
    if(self.isFinalJeoparty){
        NRFFinalJeopartyQuestion *castedFJQuestion = (NRFFinalJeopartyQuestion *)self.question;
        castedFJQuestion.category = self.finalJeopardyCategoryTextField.text;
    }
    [self.delegate questionEditViewControllerDidFinishWithQuestion:self.question mightNeedIncrement:self.mightNeedIncrement];
    
}

-(UITextField *)finalJeopartyTextFieldSetup
{
    UITextField *textFieldToReturn = [[UITextField alloc] initWithFrame:CGRectMake(261, 32, 502, 30)];
    textFieldToReturn.borderStyle = UITextBorderStyleRoundedRect;
    textFieldToReturn.font = [UIFont systemFontOfSize:17];
    textFieldToReturn.placeholder = @"Enter Final Jeoparty Category";
    textFieldToReturn.autocorrectionType = UITextAutocorrectionTypeYes;
    textFieldToReturn.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textFieldToReturn.keyboardType = UIKeyboardTypeDefault;
    textFieldToReturn.returnKeyType = UIReturnKeyDone;
    return textFieldToReturn;
}


@end
