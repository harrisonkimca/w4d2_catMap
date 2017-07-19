//
//  SearchViewController.m
//  2w4d2_catMap
//
//  Created by Seantastic31 on 18/07/2017.
//  Copyright © 2017 Seantastic31. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)runSearch
{
    
}


- (IBAction)locationSwitch:(UISwitch *)sender {
}


- (IBAction)saveButton:(UIButton *)sender {
}



#pragma mark - Keyboard


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    return YES; // returning YES allows editing
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(runSearch) name:UITextFieldTextDidChangeNotification object:nil];
    return YES;
}

// close keyboard (but need event to trigger ==> CUSTOM TOUCH DETECTION)
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
}
// close keyboard and calculate tip when return hit
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.view endEditing:YES];
    [self runSearch];
    return NO;
}
// animate up frame to show keyboard without covering anything up
- (void)keyboardWillShow:(NSNotificationCenter*)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, -110, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
// animate keyboard back down
- (void)keyboardWillHide:(NSNotificationCenter*)notification
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
// use CUSTOM TOUCH DETECTION to so touching anywhere on screen resigns first reponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.searchTextField resignFirstResponder];
}


@end
