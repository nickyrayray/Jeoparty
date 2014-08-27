//
//  NRFGameDescriptionViewController.m
//  You'reInJeopardy
//
//  Created by Nicholas Falba on 8/26/14.
//  Copyright (c) 2014 Nicholas Falba. All rights reserved.
//

#import "NRFGameDescriptionViewController.h"

@interface NRFGameDescriptionViewController () <UITextFieldDelegate, UITextViewDelegate>

@property (strong, nonatomic)UITextField *gameTitleTextField;
@property (strong, nonatomic)UITextView *gameDescriptionTextView;
@property (strong, nonatomic)NRFJeopardyGameEditable *game;

@end

@implementation NRFGameDescriptionViewController

-(id)initWithGame:(NRFJeopardyGameEditable *)game
{
    self = [super init];
    if (self) {
        self.game = game;
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    scrollView.backgroundColor = [UIColor blueColor];
    self.view = scrollView;
    
    self.gameTitleTextField = [self textFieldSetupWithFrame:CGRectMake(self.view.bounds.size.height/3, 10, self.view.bounds.size.height/3, 30)];
    self.gameTitleTextField.delegate = self;
    self.gameDescriptionTextView = [self textViewToSetupWithFrame:CGRectMake(self.view.bounds.size.height/4, 70, self.view.bounds.size.height/2,self.view.bounds.size.height/2)];
    self.gameDescriptionTextView.delegate = self;
    
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    if([self.game gameTitleCreated])
        self.gameTitleTextField.text = self.game.gameTitle;
    if([self.game gameDescriptionCreated]){
        self.gameDescriptionTextView.textColor = [UIColor whiteColor];
        self.gameDescriptionTextView.text = self.game.gameDescription;
    }
    [self.view addSubview:self.gameTitleTextField];
    [self.view addSubview:self.gameDescriptionTextView];

}

-(UITextField *)textFieldSetupWithFrame:(CGRect)frame
{
    UITextField *textFieldToReturn = [[UITextField alloc] initWithFrame:frame];
    textFieldToReturn.borderStyle = UITextBorderStyleRoundedRect;
    textFieldToReturn.font = [UIFont systemFontOfSize:17];
    textFieldToReturn.placeholder = @"Enter Game Title";
    textFieldToReturn.autocorrectionType = UITextAutocorrectionTypeYes;
    textFieldToReturn.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textFieldToReturn.keyboardType = UIKeyboardTypeDefault;
    textFieldToReturn.returnKeyType = UIReturnKeyDefault;
    return textFieldToReturn;
}

-(UITextView *)textViewToSetupWithFrame:(CGRect)frame
{
    UITextView *textViewToReturn = [[UITextView alloc]initWithFrame:frame];
    textViewToReturn.backgroundColor = [UIColor blueColor];
    textViewToReturn.font = [UIFont systemFontOfSize:17];
    textViewToReturn.textColor = [UIColor whiteColor];
    textViewToReturn.textAlignment = NSTextAlignmentLeft;
    textViewToReturn.autocapitalizationType = UITextAutocapitalizationTypeSentences;
    [self setPlaceHolderText:@"Tap to Enter Game Description" forTextView:textViewToReturn];
    return textViewToReturn;
}

-(void)setPlaceHolderText:(NSString *)text forTextView:(UITextView *)textView
{
    textView.textColor = [UIColor yellowColor];
    textView.text = text;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.text && ![textField.text isEqualToString:@""])
        self.game.gameTitle = textField.text;
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Tap to Enter Game Description"]){
        textView.text = @"";
        textView.textColor = [UIColor whiteColor];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text && ![textView.text isEqualToString:@""])
        self.game.gameDescription = textView.text;
    else
        [self setPlaceHolderText:@"Tap to Enter Game Description" forTextView:textView];
    [(NRFTabBarViewController *)self.tabBarController checkForGameIsCompletelyEditedAndUpdateTabBarController];
}


@end
