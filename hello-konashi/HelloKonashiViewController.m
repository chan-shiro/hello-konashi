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
@synthesize led3Button = _led3Button;
@synthesize led4Button = _led4Button;
@synthesize led5Button = _led5Button;
@synthesize clearButton = _clearButton;

int pinState[6];

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Konashi initilize
    
    [Konashi initialize];
    [Konashi addObserver:self selector:@selector(ready) name:KONASHI_EVENT_READY];
    [Konashi addObserver:self selector:@selector(updateLabel) name:KONASHI_EVENT_DISCONNECTED];
    [Konashi addObserver:self selector:@selector(pio_updated) name:KONASHI_EVENT_UPDATE_PIO_INPUT];
    

    [self.led2Button setHidden:true];
    [self.led3Button setHidden:true];
    [self.led4Button setHidden:true];
    [self.led5Button setHidden:true];
    [self.clearButton setHidden:true];
    
    // Initialize pinState
    for (int i = 0; i < 6; ++i) {
        pinState[i] = LOW;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    NSString *senderName = sender.currentTitle;
    int senderPin = [[senderName substringFromIndex:(senderName.length -1)] intValue];
    NSLog(@"String length = %d", senderName.length);
    NSLog(@"LED%d", senderPin);
    int setValue = 0;
    
    if (pinState[senderPin] == HIGH)
    {
        setValue = LOW;
        NSLog(@"set HIGH");
    }
    else
    {
        setValue = HIGH;
        NSLog(@"set LOW");
    }
    [Konashi digitalWrite:[self setPinNum:senderPin] value:setValue];
    pinState[senderPin] = setValue;

}

- (int) setPinNum:(int) senderNum
{
    int returnValue;
    switch(senderNum)
    {
        case 5:
            returnValue = LED5;
            break;
        case 4:
            returnValue = LED4;
            break;
        case 3:
            returnValue = LED3;
            break;
        case 2:
            returnValue = LED2;
            break;
    }
    return returnValue;
}

- (IBAction)clearLED:(id)sender
{
    [Konashi digitalWrite:LED2 value:LOW];
    [Konashi digitalWrite:LED3 value:LOW];
    [Konashi digitalWrite:LED4 value:LOW];
    [Konashi digitalWrite:LED5 value:LOW];
    for (int i = 0; i < 6; ++i)
    {
        pinState[i] = LOW;
    }

}


- (void)ready
{
    [Konashi pinMode:PIO0 mode:INPUT];
    [Konashi pinMode:LED2 mode:OUTPUT];
    [Konashi pinMode:LED3 mode:OUTPUT];
    [Konashi pinMode:LED4 mode:OUTPUT];
    [Konashi pinMode:LED5 mode:OUTPUT];
    self.connectionLabel.text = @"Connected";
    NSLog(@"connection ready");
    [self.led2Button setHidden:false];
    [self.led3Button setHidden:false];
    [self.led4Button setHidden:false];
    [self.led5Button setHidden:false];
    [self.clearButton setHidden:false];

}

- (void)updateLabel
{
    self.connectionLabel.text = @"Not connected";
    [self.led2Button setHidden:true];
    [self.led3Button setHidden:true];
    [self.led4Button setHidden:true];
    [self.led5Button setHidden:true];
    [self.clearButton setHidden:true];

}

- (void)pio_updated
{
    if ([Konashi digitalRead:PIO0] == HIGH)
    {
        [self clearLED:nil];
    }
}

@end
