//
//  SettingsViewController.m
//  SDDrawingBoard
//
//  Created by sdong on 2/7/15.
//  Copyright (c) 2015 SD. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@property (strong, nonatomic) UISlider *brushControl;
@property (strong, nonatomic) UILabel *brushValueLabel;
@property (strong, nonatomic) UIImageView *brushPreview;
@property (strong, nonatomic) UISlider *opacityControl;
@property (strong, nonatomic) UILabel *opacityValueLabel;
@property (strong, nonatomic) UISlider *redControl;
@property (strong, nonatomic) UILabel *redLabel;
@property (strong, nonatomic) UISlider *greenControl;
@property (strong, nonatomic) UILabel *greenLabel;
@property (strong, nonatomic) UISlider *blueControl;
@property (strong, nonatomic) UILabel *blueLabel;


@end

@implementation SettingsViewController

-(void)SetPaint:(CGFloat) brush opacity:(CGFloat)opacity red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    self.brush = brush;
    self.opacity = opacity;
    self.red = red;
    self.green = green;
    self.blue =blue;
}

-(void) setSliderControllerValue:(UISlider*)slider
                            minimumValue:(float) minimumValue
                            maximumValue:(float) maximumValue
                            value:(float) value{
    
    [slider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
    [slider setMinimumValue:minimumValue];
    [slider setMaximumValue:maximumValue];
    slider.continuous = YES;
    slider.value = value;
}



-(UISlider *)brushControl{
    
    if(!_brushControl){
        _brushControl = [[UISlider alloc]init];
        [self setSliderControllerValue:_brushControl minimumValue:1.0 maximumValue:120 value:10];
    }
    return _brushControl;
}

-(UILabel *)brushValueLabel{
    if(!_brushValueLabel){
        _brushValueLabel = [[UILabel alloc]init];
    }
    return _brushValueLabel;
}

-(UIImageView *)brushPreview{
    if(!_brushPreview){
        _brushPreview = [[UIImageView alloc]init];
    }
    return _brushPreview;
}

-(UISlider *)opacityControl{
    if(!_opacityControl){
        _opacityControl = [[UISlider alloc]init];
        [self setSliderControllerValue:_opacityControl minimumValue:0.05 maximumValue:1 value:1];
    }
    return _opacityControl;
}

-(UILabel *)opacityValueLabel{
    if(!_opacityValueLabel){
        _opacityValueLabel = [[UILabel alloc]init];
    }
    return _opacityValueLabel;
}

-(UISlider *)redControl{
    if(!_redControl){
        _redControl = [[UISlider alloc]init];
        [self setSliderControllerValue:_redControl minimumValue:0 maximumValue:255 value:255];
    }
    return _redControl;
}

-(UILabel *)redLabel{
    if(!_redLabel){
        _redLabel = [[UILabel alloc]init];
    }
    return _redLabel;
}

-(UISlider *)blueControl{
    if(!_blueControl){
        _blueControl = [[UISlider alloc]init];
        [self setSliderControllerValue:_blueControl minimumValue:0 maximumValue:255 value:255];
    }
    return _blueControl;
}

-(UILabel *)blueLabel{
    if(!_blueLabel){
        _blueLabel = [[UILabel alloc]init];
    }
    return _blueLabel;
}


-(UISlider *)greenControl{
    if(!_greenControl){
        _greenControl = [[UISlider alloc]init];
        [self setSliderControllerValue:_greenControl minimumValue:0 maximumValue:255 value:255];
    }
    return _greenControl;
}

-(UILabel *)greenLabel{
    if(!_greenLabel){
        _greenLabel = [[UILabel alloc]init];
    }
    return _greenLabel;
}

- (CGRect)makeFrameXPositionToScreenWidth:(CGFloat)xPropotionToScreenWidth
                    yPositionToScreenHeight:(CGFloat)yPositionToScreenHeight
                     widthToScreenwidth:(CGFloat)widthToScreenwidth
                    heightToScreenHeight:(CGFloat)heightToScreenHeight{
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGRectMake(screenWidth * xPropotionToScreenWidth,
                      screenHeight * yPositionToScreenHeight,
                      screenWidth * widthToScreenwidth,
                      screenHeight * heightToScreenHeight);
}

- (CGRect)makeFrameSameWidthToScreenwidth:(CGFloat)widthToScreenwidth
                           XPositionToScreenWidth:(CGFloat)xPropotionToScreenWidth
                            yPositionToScreenHeight:(CGFloat)yPositionToScreenHeight{
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGRectMake(screenWidth * xPropotionToScreenWidth,
                      screenHeight * yPositionToScreenHeight,
                      screenWidth * widthToScreenwidth,
                      screenWidth * widthToScreenwidth);
}


- (CGRect)makeFrameSameWidthToScreenHeight:(CGFloat)heightToScreenHeight
                           XPositionToScreenWidth:(CGFloat)xPropotionToScreenWidth
                            yPositionToScreenHeight:(CGFloat)yPositionToScreenHeight{
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    return CGRectMake(screenWidth * xPropotionToScreenWidth,
                      screenHeight * yPositionToScreenHeight,
                      screenHeight * heightToScreenHeight,
                      screenHeight * heightToScreenHeight);
}

-(void)initButtons{
    
    [self.view addSubview:self.brushPreview];
    [self.brushPreview setFrame:[self makeFrameSameWidthToScreenwidth:0.5
                                               XPositionToScreenWidth:0.25
                                              yPositionToScreenHeight:0.15]];
    
    [self.view addSubview:self.brushControl];
    [self.brushControl setFrame:[self makeFrameXPositionToScreenWidth: 0.1
                                              yPositionToScreenHeight:0.5
                                                   widthToScreenwidth:0.5
                                                 heightToScreenHeight:0.1]];

    [self.view addSubview:self.brushValueLabel];
    [self.brushValueLabel setFrame:[self makeFrameXPositionToScreenWidth: 0.65
                                                 yPositionToScreenHeight:0.5
                                                      widthToScreenwidth:0.3
                                                    heightToScreenHeight:0.1]];

    [self.view addSubview:self.opacityControl];
    [self.opacityControl setFrame:[self makeFrameXPositionToScreenWidth: 0.1
                                                yPositionToScreenHeight:0.6
                                                     widthToScreenwidth:0.5
                                                   heightToScreenHeight:0.1]];

    [self.view addSubview:self.opacityValueLabel];
    [self.opacityValueLabel setFrame:[self makeFrameXPositionToScreenWidth: 0.65
                                                   yPositionToScreenHeight:0.6
                                                        widthToScreenwidth:0.3
                                                      heightToScreenHeight:0.1]];

    [self.view addSubview:self.redControl];
    [self.redControl setFrame:[self makeFrameXPositionToScreenWidth: 0.1
                                                yPositionToScreenHeight:0.7
                                                     widthToScreenwidth:0.5
                                                   heightToScreenHeight:0.1]];
    
    [self.view addSubview:self.redLabel];
    [self.redLabel setFrame:[self makeFrameXPositionToScreenWidth: 0.65
                                                   yPositionToScreenHeight:0.7
                                                        widthToScreenwidth:0.3
                                                      heightToScreenHeight:0.1]];

    [self.view addSubview:self.blueControl];
    [self.blueControl setFrame:[self makeFrameXPositionToScreenWidth: 0.1
                                                yPositionToScreenHeight:0.8
                                                     widthToScreenwidth:0.5
                                                   heightToScreenHeight:0.1]];
    
    [self.view addSubview:self.blueLabel];
    [self.blueLabel setFrame:[self makeFrameXPositionToScreenWidth: 0.65
                                                   yPositionToScreenHeight:0.8
                                                        widthToScreenwidth:0.3
                                                      heightToScreenHeight:0.1]];

    [self.view addSubview:self.greenControl];
    [self.greenControl setFrame:[self makeFrameXPositionToScreenWidth: 0.1
                                                yPositionToScreenHeight:0.9
                                                     widthToScreenwidth:0.5
                                                   heightToScreenHeight:0.1]];
    
    [self.view addSubview:self.greenLabel];
    [self.greenLabel setFrame:[self makeFrameXPositionToScreenWidth: 0.65
                                                   yPositionToScreenHeight:0.9
                                                        widthToScreenwidth:0.3
                                                      heightToScreenHeight:0.1]];
    
    CGRect screenRect = [self.view bounds];
    CGFloat screenWidth = screenRect.size.width;
    UINavigationBar *navBar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 50)];
    [self.view addSubview:navBar];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]initWithTitle:@"Back"
                                     style:UIBarButtonItemStylePlain
                                    target:self action:@selector(goBack:)];
    UINavigationItem *item = [[UINavigationItem alloc] initWithTitle:@""];
    item.rightBarButtonItem = backButton;
    item.hidesBackButton = YES;
    [navBar pushNavigationItem:item animated:NO];

}

- (void)goBack:(id)sender {
    [self.delegate closeSettings:self];
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.backgroundColor = [UIColor lightGrayColor];

    [self initButtons];
}

- (void)viewWillAppear:(BOOL)animated {
    
    // ensure the values displayed are the current values
    int redIntValue = self.red * 255.0;
    self.redControl.value = redIntValue;
    [self sliderChanged:self.redControl];
    
    int greenIntValue = self.green * 255.0;
    self.greenControl.value = greenIntValue;
    [self sliderChanged:self.greenControl];
    
    int blueIntValue = self.blue * 255.0;
    self.blueControl.value = blueIntValue;
    [self sliderChanged:self.blueControl];
    
    self.brushControl.value = self.brush;
    [self sliderChanged:self.brushControl];
    
    self.opacityControl.value = self.opacity;
    [self sliderChanged:self.opacityControl];
    
}

- (void)sliderChanged:(id)sender {
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == self.brushControl) {
        
        self.brush = self.brushControl.value;
        self.brushValueLabel.text = @"Size";
        
    } else if(changedSlider == self.opacityControl) {
        
        self.opacity = self.opacityControl.value;
        self.opacityValueLabel.text = @"Opacity";
        
    } else if(changedSlider == self.redControl) {
        
        self.red = self.redControl.value/255.0;
        self.redLabel.text = [NSString stringWithFormat:@"Red: %d", (int)self.redControl.value];
        self.redLabel.textColor = [UIColor redColor];


    } else if(changedSlider == self.greenControl){
        
        self.green = self.greenControl.value/255.0;
        self.greenLabel.text = [NSString stringWithFormat:@"Green: %d", (int)self.greenControl.value];
        self.greenLabel.textColor = [UIColor greenColor];

    } else if (changedSlider == self.blueControl){
        
        self.blue = self.blueControl.value/255.0;
        self.blueLabel.text = [NSString stringWithFormat:@"Blue: %d", (int)self.blueControl.value];
        self.blueLabel.textColor = [UIColor blueColor];
        
    }
    
    CGFloat x = self.brushPreview.frame.size.width;
    CGFloat y = self.brushPreview.frame.size.height;
    UIGraphicsBeginImageContext(self.brushPreview.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),x/2.0, y/2.0);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),x/2.0, y/2.0);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
