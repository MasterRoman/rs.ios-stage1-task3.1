#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) UIButton *buttonProcess;
@property (weak, nonatomic) UITextField *textFieldRed;
@property (weak, nonatomic) UITextField *textFieldGreen;
@property (weak, nonatomic) UITextField *textFieldBlue;
@property (weak, nonatomic) UILabel *labelRed;
@property (weak, nonatomic) UILabel *labelGreen;
@property (weak, nonatomic) UILabel *labelBlue;
@property (weak, nonatomic) UILabel *labelResultColor;
@property (weak, nonatomic) UIView *viewResultColor;
@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.buttonProcess =[[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width / 2 - 50), 350, 100, 60)];
    [self.buttonProcess setTitle:@"Process" forState: UIControlStateNormal];
    [self.buttonProcess setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.buttonProcess addTarget:self action:@selector(process) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.buttonProcess];
    
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(120, 100, 200, 50)];
    [self.textFieldRed setBorderStyle:UITextBorderStyleLine];
    self.textFieldRed.placeholder = @"0..255";
  
    [self.textFieldRed addTarget:self action:@selector (textFieldInput) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:self.textFieldRed];
    
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(120, 180, 200, 50)];
    [self.textFieldGreen setBorderStyle:UITextBorderStyleLine];
    self.textFieldGreen.placeholder = @"0..255";

    [self.textFieldGreen addTarget:self action:@selector (textFieldInput) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:self.textFieldGreen];
    
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(120, 260, 200, 50)];
    [self.textFieldBlue setBorderStyle:UITextBorderStyleLine];
    self.textFieldBlue.placeholder = @"0..255";
  
    [self.textFieldBlue addTarget:self action:@selector(textFieldInput) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:self.textFieldBlue];

    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 70, 50 )];
    [self.labelRed setText:@"RED"];
    [self.view addSubview:self.labelRed];
    
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(40, 180, 70, 50 )];
    [self.labelGreen setText:@"GREEN"];
    [self.view addSubview:self.labelGreen];
  
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(40, 260, 70, 50 )];
    [self.labelBlue setText:@"BLUE"];
    [self.view addSubview:self.labelBlue];
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 80, 50)];
    [self.labelResultColor setText:@"Color"];
    [self.view addSubview:self.labelResultColor];
    
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(140, 15, 180, 60)];
    [self.viewResultColor setBackgroundColor: [UIColor clearColor]];
    [self.view addSubview:self.viewResultColor];
    
    
    self.view.accessibilityIdentifier = @"mainView";
    self.textFieldRed.accessibilityIdentifier = @"textFieldRed";
    self.textFieldGreen.accessibilityIdentifier = @"textFieldGreen";
    self.textFieldBlue.accessibilityIdentifier = @"textFieldBlue";
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    self.labelRed.accessibilityIdentifier = @"labelRed";
    self.labelGreen.accessibilityIdentifier = @"labelGreen";
    self.labelBlue.accessibilityIdentifier = @"labelBlue";
    self.labelResultColor.accessibilityIdentifier = @"labelResultColor";
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
}
-(void) process
{
    NSCharacterSet* notDecimalDigitSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ( (([self.textFieldBlue.text length]!=0) && ([self.textFieldRed.text length]!=0) && ([self.textFieldGreen.text length]!=0) && [self.textFieldRed.text rangeOfCharacterFromSet:notDecimalDigitSet].location == NSNotFound) &&
    [self.textFieldGreen.text rangeOfCharacterFromSet:notDecimalDigitSet].location == NSNotFound &&
    [self.textFieldBlue.text rangeOfCharacterFromSet:notDecimalDigitSet].location == NSNotFound)
    {
        int redValue = [self.textFieldRed.text intValue];
        int greenValue = [self.textFieldGreen.text intValue];
        int blueValue = [self.textFieldBlue.text intValue];
        if (redValue >= 0 && redValue <256 && greenValue >= 0 && greenValue <256 && blueValue >=0 && blueValue < 256)
        {
            self.viewResultColor.backgroundColor = [UIColor colorWithRed:((float)redValue/255) green:((float)greenValue/255) blue:  ((float) blueValue/255) alpha:1];
            NSString *hexString = [[NSString alloc] initWithFormat:@"0x%02X%02X%02X", redValue, greenValue, blueValue];
            self.labelResultColor.text = hexString;
            
        } else {
            self.labelResultColor.text = @"Error";
            self.viewResultColor.backgroundColor = [UIColor clearColor];
        }
    }  else {self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
    }
    [self.view endEditing:YES];
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
    
}

- (void) textFieldInput
{
    if (![self.labelResultColor.text isEqualToString:@"Color"]) {
        self.labelResultColor.text = @"Color";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
   }
}

@end
