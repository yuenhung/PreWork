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
    [self updateValues];
    
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
    [self.view endEditing:YES];
    [self updateValues];
}

-(void)updateValues {

    float billAmount = [self.billTextField.text floatValue];
    
    NSArray *tipValue = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValue[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}

- (void) loadDefaultSetting {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger defaultValue = [defaults floatForKey:@"getDefaultSetting"];
    self.tipControl.selectedSegmentIndex = defaultValue;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    [self loadDefaultSetting];
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

@end
