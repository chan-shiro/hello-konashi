//
//  HelloKonashiViewController.h
//  hello-konashi
//
//  Created by Shiro Fukuda on 2013/04/07.
//  Copyright (c) 2013 chan-shiro. Some rights reserved.
//

#import <UIKit/UIKit.h>
#import "KonashiPWMLED.h"

@interface HelloKonashiViewController : UIViewController

- (IBAction)find:(id)sender;
- (IBAction)disconnect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *led2Button;
@property (weak, nonatomic) IBOutlet UISlider *led2Slider;
@property (weak, nonatomic) IBOutlet UIButton *led3Button;
@property (weak, nonatomic) IBOutlet UISlider *led3Slider;
@property (weak, nonatomic) IBOutlet UIButton *led4Button;
@property (weak, nonatomic) IBOutlet UISlider *led4Slider;
@property (weak, nonatomic) IBOutlet UIButton *led5Button;
@property (weak, nonatomic) IBOutlet UISlider *led5Slider;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (strong, nonatomic) KonashiPWMLED *led2;
@property (strong, nonatomic) KonashiPWMLED *led3;
@property (strong, nonatomic) KonashiPWMLED *led4;
@property (strong, nonatomic) KonashiPWMLED *led5;

@end
