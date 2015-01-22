//
//  TipCalculatorViewController.m
//  TipCalculator
//
//  Created by Tejas Lagvankar on 1/21/15.
//  Copyright (c) 2015 Yahoo!. All rights reserved.
//

#import "TipCalculatorViewController.h"
#import "SettingsViewController.h"

@interface TipCalculatorViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (void) updateValues;
- (void) initTipControl;
@end

@implementation TipCalculatorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Tip Calculator";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)viewDidAppear:(BOOL)animated {
    [self initTipControl];
    [self updateValues];
}

- (void)initTipControl {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int intValue = [defaults integerForKey:@"default_tip_index"];
    intValue = intValue == 0 ? 3 : intValue;
    self.tipControl.selectedSegmentIndex = intValue - 1;
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateValues {

    if (self.billTextField.text.length == 0)
        return;

    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValues = @[@(0.1), @(0.2), @(0.3)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    
    float totalFloatAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"%f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"%f", totalFloatAmount];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
    [self updateValues];
}

- (IBAction)onTipValueChanged:(id)sender {
    [self updateValues];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
