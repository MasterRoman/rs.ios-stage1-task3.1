#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) UILabel *labelResultColor;
@property (strong, nonatomic) UILabel *labelRed;
@property (strong, nonatomic) UILabel *labelGreen;
@property (strong, nonatomic) UILabel *labelBlue;
@property (strong, nonatomic) UIView *viewResultColor;
@property (strong, nonatomic) UITextField *textFieldRed;
@property (strong, nonatomic) UITextField *textFieldGreen;
@property (strong, nonatomic) UITextField *textFieldBlue;
@property (strong, nonatomic) UIButton *buttonProcess;

@end

#pragma mark - implemeation

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.labelResultColor = [[UILabel alloc] initWithFrame:CGRectMake(40, 50, 90, 50)];
    self.labelRed = [[UILabel alloc] initWithFrame:CGRectMake(40, 125, 70, 50)];
    self.labelGreen = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 70, 50)];
    self.labelBlue = [[UILabel alloc] initWithFrame:CGRectMake(40, 275, 70, 50)];
    [self.labelRed setText:@"RED"];
    [self.view addSubview:self.labelRed];
    [self.labelGreen setText:@"GREEN"];
    [self.view addSubview:self.labelGreen];
    [self.labelBlue setText:@"BLUE"];
    [self.view addSubview:self.labelBlue];
    [self.labelResultColor setText:@"Color"];
    [self.view addSubview:self.labelResultColor];
    self.viewResultColor = [[UIView alloc] initWithFrame:CGRectMake(140, 45, 180, 60)];
    [self.view addSubview:self.viewResultColor];
    
    self.textFieldRed = [[UITextField alloc] initWithFrame:CGRectMake(120, 125, 200, 50)];
    self.textFieldGreen = [[UITextField alloc] initWithFrame:CGRectMake(120, 200, 200, 50)];
    self.textFieldBlue = [[UITextField alloc] initWithFrame:CGRectMake(120, 275, 200, 50)];
    self.textFieldRed.placeholder = @"0..255";
    self.textFieldGreen.placeholder = @"0..255";
    self.textFieldBlue.placeholder = @"0..255";
    self.textFieldRed.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldGreen.borderStyle = UITextBorderStyleRoundedRect;
    self.textFieldBlue.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.textFieldRed];
    [self.view addSubview:self.textFieldGreen];
    [self.view addSubview:self.textFieldBlue];
    self.buttonProcess = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 50, 350, 100, 60)];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    [self.buttonProcess setTitleColor:UIColor.systemBlueColor forState:UIControlStateNormal];
    [self.view addSubview:self.buttonProcess];
    
    [self.textFieldRed addTarget:self action:@selector(textEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self.textFieldGreen addTarget:self action:@selector(textEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self.textFieldBlue addTarget:self action:@selector(textEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self.buttonProcess addTarget:self action:@selector(process) forControlEvents:UIControlEventTouchUpInside];
    
    
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
#pragma mark - textEdit

- (void)textEdit {
    if (![self.labelResultColor.text isEqual: @"Color"]) {
        self.viewResultColor.backgroundColor = UIColor.clearColor;
        self.labelResultColor.text = @"Color";
        self.textFieldRed.text = @"";
        self.textFieldGreen.text = @"";
        self.textFieldBlue.text = @"";
    }

}
#pragma mark - process
- (void)process {
    NSCharacterSet* digits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    double red = [self.textFieldRed.text doubleValue];
    double green = [self.textFieldGreen.text doubleValue];
    double blue = [self.textFieldBlue.text doubleValue];
    if ( red < 0 || red > 255 || green < 0 || green > 255 || blue < 0 || blue > 255 ||
        !self.textFieldRed.text.length || !self.textFieldGreen.text.length || !self.textFieldBlue.text.length ||
        [self.textFieldRed.text rangeOfCharacterFromSet:digits].location != NSNotFound ||
        [self.textFieldGreen.text rangeOfCharacterFromSet:digits].location != NSNotFound ||
        [self.textFieldBlue.text rangeOfCharacterFromSet:digits].location != NSNotFound)
    {
        self.labelResultColor.text = @"Error";
        self.viewResultColor.backgroundColor = [UIColor clearColor];
    } else {
        self.viewResultColor.backgroundColor = [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
        self.labelResultColor.text = [self hexColor:self.viewResultColor.backgroundColor];
    }
    [self.textFieldRed resignFirstResponder];
    [self.textFieldGreen resignFirstResponder];
    [self.textFieldBlue resignFirstResponder];
    self.textFieldRed.text = @"";
    self.textFieldGreen.text = @"";
    self.textFieldBlue.text = @"";
    
}

#pragma mark - hexColor

- (NSString *)hexColor:(UIColor *)color {
    if (!color) {
        return @"Error";
    }
    const CGFloat *rgb = CGColorGetComponents(color.CGColor);
    return [NSString stringWithFormat:@"0x%02lX%02lX%02lX",lroundf(rgb[0] * 255),lroundf(rgb[1] * 255),lroundf(rgb[2] * 255)];
}
@end
