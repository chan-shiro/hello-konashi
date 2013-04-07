//
//  HelloKonashiViewController.m
//  hello-konashi
//
//  Created by Shiro Fukuda on 2013/04/07.
//  Copyright (c) 2013年 chan-shiro. Some rights reserved.
//

#import "HelloKonashiViewController.h"
#import "Konashi.h"

@interface HelloKonashiViewController ()
@end

@implementation HelloKonashiViewController

@synthesize connectionLabel = _connectionLabel;
@synthesize led2Button = _led2Button;
@synthesize led2Slider = _led2Slider;
@synthesize led3Button = _led3Button;
@synthesize led3Slider = _led3Slider;
@synthesize led4Button = _led4Button;
@synthesize led4Slider = _led4Slider;
@synthesize led5Button = _led5Button;
@synthesize led5Slider = _led5Slider;
@synthesize clearButton = _clearButton;

@synthesize led2 = _led2;
@synthesize led3 = _led3;
@synthesize led4 = _led4;
@synthesize led5 = _led5;

#pragma mark - iOS delegate methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Konashi initilize
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(ready) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(updateLabel) name:KONASHI_EVENT_DISCONNECTED];
    [Konashi addObserver:self selector:@selector(pio_updated) name:KONASHI_EVENT_UPDATE_PIO_INPUT];
    
    [self setVisibilityOfLEDControllers:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)find:(id)sender
{
    [Konashi find];
}

- (IBAction)disconnect:(id)sender
{
    [Konashi disconnect];
}

- (IBAction)toggleLED:(UIButton *)sender
{
    KonashiPWMLED *led = [self findLEDbyName:sender.currentTitle];
    UISlider *slider = [self findSliderbyLEDName:sender.currentTitle];
    [led toggleOutput];
    if (led.state == HIGH)
    {
        [slider setValue:100];
    }
    else
    {
        [slider setValue:0];
    }
}

- (IBAction)clearLED:(id)sender
{
    [self.led2 updateRatio:0];
    [self.led3 updateRatio:0];
    [self.led4 updateRatio:0];
    [self.led5 updateRatio:0];
    [self.led2Slider setValue:0];
    [self.led3Slider setValue:0];
    [self.led4Slider setValue:0];
    [self.led5Slider setValue:0];
}

- (IBAction)updateLED2Duty:(UISlider *)slider
{
    [self.led2 updateRatio:slider.value];
}

- (IBAction)updateLED3Duty:(UISlider *)slider
{
    [self.led3 updateRatio:slider.value];
}

- (IBAction)updateLED4Duty:(UISlider *)slider
{
    [self.led4 updateRatio:slider.value];
}

- (IBAction)updateLED5Duty:(UISlider *)slider
{
    [self.led5 updateRatio:slider.value];
}


#pragma mark - Konashi Observer

- (void)pio_updated
{
    if ([Konashi digitalRead:PIO0] == HIGH)
    {
        [self clearLED:nil];
    }
}

- (void)ready
{
    // Initializing LEDs
    self.led2 = [[KonashiPWMLED alloc] initWithName:@"LED2" pinNum:LED2 state:LOW ratio:100];
    self.led3 = [[KonashiPWMLED alloc] initWithName:@"LED3" pinNum:LED3 state:LOW ratio:100];
    self.led4 = [[KonashiPWMLED alloc] initWithName:@"LED4" pinNum:LED4 state:LOW ratio:100];
    self.led5 = [[KonashiPWMLED alloc] initWithName:@"LED5" pinNum:LED5 state:LOW ratio:100];
    self.connectionLabel.text = @"Connected";
    NSLog(@"connection ready");
    [self.led2Slider setValue:0];
    [self.led3Slider setValue:0];
    [self.led4Slider setValue:0];
    [self.led5Slider setValue:0];
    [self setVisibilityOfLEDControllers:YES];
}

#pragma mark - helper methods

- (KonashiPWMLED *)findLEDbyName:(NSString *)name
{
    KonashiPWMLED *returnLED;
    if ([name isEqualToString:@"LED2"])
    {
        returnLED = self.led2;
    }
    else if ([name isEqualToString:@"LED3"])
    {
        returnLED = self.led3;
    }
    else if ([name isEqualToString:@"LED4"])
    {
        returnLED = self.led4;
    }
    else if ([name isEqualToString:@"LED5"])
    {
        returnLED = self.led5;
    }
    return returnLED;
}

- (UISlider *)findSliderbyLEDName:(NSString *)name
{
    UISlider *returnSlider;
    if ([name isEqualToString:@"LED2"])
    {
        returnSlider = self.led2Slider;
    }
    else if ([name isEqualToString:@"LED3"])
    {
        returnSlider = self.led3Slider;
    }
    else if ([name isEqualToString:@"LED4"])
    {
        returnSlider = self.led4Slider;
    }
    else if ([name isEqualToString:@"LED5"])
    {
        returnSlider = self.led5Slider;
    }
    return returnSlider;
}

- (void)setVisibilityOfLEDControllers:(BOOL)value
{
    [self.led2Button setHidden:!value];
    [self.led3Button setHidden:!value];
    [self.led4Button setHidden:!value];
    [self.led5Button setHidden:!value];
    [self.clearButton setHidden:!value];
    [self.led2Slider setHidden:!value];
    [self.led3Slider setHidden:!value];
    [self.led4Slider setHidden:!value];
    [self.led5Slider setHidden:!value];
}

- (void)updateLabel
{
    self.connectionLabel.text = @"Not connected";
    [self setVisibilityOfLEDControllers:NO];
}
@end
