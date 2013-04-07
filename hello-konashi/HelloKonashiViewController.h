//
//  HelloKonashiViewController.h
//  hello-konashi
//
//  Created by Shiro Fukuda on 2013/04/07.
//  Copyright (c) 2013年 chan-shiro. Some rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloKonashiViewController : UIViewController

- (IBAction)find:(id)sender;
- (IBAction)disconnect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *connectionLabel;
@property (weak, nonatomic) IBOutlet UIButton *led2Button;
@property (weak, nonatomic) IBOutlet UIButton *led3Button;
@property (weak, nonatomic) IBOutlet UIButton *led4Button;
@property (weak, nonatomic) IBOutlet UIButton *led5Button;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;

@end
