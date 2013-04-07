//
//  KonashiPWMLED.m
//  hello-konashi
//
//  Created by Shiro Fukuda on 2013/04/07.
//  Copyright (c) 2013年 chan-shiro. All rights reserved.
//

#import "KonashiPWMLED.h"
#import "Konashi.h"

@implementation KonashiPWMLED
@synthesize name = _name; // name is the same name of the button title
@synthesize state = _state;
@synthesize ratio = _ratio; // pwm ratio
@synthesize pinNum = _pinNum; // LED2 - LED5

- (id)initWithName:(NSString *)name pinNum:(int)pinNum state:(int)state ratio:(int)ratio
{
    if (self = [super init]) {
        _name = name;
        _pinNum = pinNum;
        _state = state;
        _ratio = ratio;
    }
    // set LED to pwm led mode
    [Konashi pwmMode:self.pinNum mode:KONASHI_PWM_ENABLE_LED_MODE];
    return self;
}

- (void)outputHigh
{
    // max ratio = 100
    [self updateRatio:100];
}

- (void)outputLow
{
    // min ratio = 0
    [self updateRatio:0];
}

- (void)toggleOutput
{
    int newState;
    newState = HIGH - self.state; // HIGH - HIGH = LOW, HIGH - LOW = HIGH
    if (newState == HIGH)
    {
        [self updateRatio:100];
        self.state = newState;
    }
    else
    {
        [self updateRatio:0];
        self.state = newState;
    }
}

- (void)updateRatio:(int)ratio
{
    [Konashi pwmLedDrive:self.pinNum dutyRatio:ratio];
    self.ratio = ratio;
    if (ratio >= 100)
    {
        self.state = HIGH;
    }
    else if (ratio <= 1)
    {
        self.state = LOW;
    }
}

@end
