//
//  tipViewController.m
//  Prework
//
//  Created by Vincent Lai on 6/11/15.
//  Copyright (c) 2015 Vincent Lai. All rights reserved.
//

#import "tipViewController.h"
#import "SettingsViewController.h"

@interface tipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;
- (IBAction)onTap:(id)sender;
- (void)updateValues;
- (void)onSettingsButton;
- (void)loadDefaultSetting;
- (void)viewWillAppear:(BOOL)animated;
- (void)viewDidAppear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;
- (void)viewDidDisappear:(BOOL)animated;
- (void)dismissTheKeyBoard;
- (void)displayTheKeyBoard;
- (IBAction)changePercent:(id)sender;
- (void)setBillAmount;
- (void)getBillAmount;
- (NSString *)formatCurrency:(float)amount;

@end

@implementation tipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        self.title = @"TipCalculator";
    }
    
    return self;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBillAmount];
    [self updateValues];
    [self displayTheKeyBoard];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTap:(id)sender {
    //[self.view endEditing:YES];
    [self getBillAmount];
    [self updateValues];
    [self dismissTheKeyBoard];
}

-(void)updateValues {

    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValue = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValue[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [self formatCurrency:tipAmount];
    self.totalLabel.text = [self formatCurrency:totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void) loadDefaultSetting {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultValue = [defaults integerForKey:@"getDefaultSetting"];
    self.tipControl.selectedSegmentIndex = defaultValue;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self loadDefaultSetting];
    [self displayTheKeyBoard];
    [self updateValues];
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
    //[self loadDefaultSetting];
    //[self updateValues];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

-(void)dismissTheKeyBoard
{
    [self.billTextField resignFirstResponder];
}

-(void)displayTheKeyBoard
{
    [self.billTextField becomeFirstResponder];
}

- (IBAction)changePercent:(id)sender {
    [self getBillAmount];
    [self updateValues];
    [self dismissTheKeyBoard];
}

- (void)setBillAmount {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultValue = [defaults integerForKey:@"billAmount"];
    self.billTextField.text = [NSString stringWithFormat:@"%ld", defaultValue];
}

- (void)getBillAmount {
    NSString *defaultBill = self.billTextField.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:defaultBill forKey:@"billAmount"];
    [defaults synchronize];
    
}

- (NSString *)formatCurrency:(float)amount {
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterCurrencyStyle;
    NSNumber *number = [NSNumber numberWithFloat:amount];
    return [nf stringFromNumber:number];
}

@end
