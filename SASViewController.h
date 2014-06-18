//
//  SASViewController.h
//  Hesap Makinesi
//
//  Created by Şakir Şensoy on 16/06/14.
//  Copyright (c) 2014 Şakir Şensoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SASCalculator.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface SASViewController : UIViewController

#pragma mark - Classes
@property (strong, nonatomic) SASCalculator *calculator;

#pragma mark - Number buttons
@property (weak, nonatomic) IBOutlet UIButton *b0;
@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;
@property (weak, nonatomic) IBOutlet UIButton *b4;
@property (weak, nonatomic) IBOutlet UIButton *b5;
@property (weak, nonatomic) IBOutlet UIButton *b6;
@property (weak, nonatomic) IBOutlet UIButton *b7;
@property (weak, nonatomic) IBOutlet UIButton *b8;
@property (weak, nonatomic) IBOutlet UIButton *b9;

#pragma mark - Operation buttons
@property (weak, nonatomic) IBOutlet UIButton *plus;
@property (weak, nonatomic) IBOutlet UIButton *minus;
@property (weak, nonatomic) IBOutlet UIButton *divide;
@property (weak, nonatomic) IBOutlet UIButton *multiply;
@property (weak, nonatomic) IBOutlet UIButton *result;
@property (weak, nonatomic) IBOutlet UIButton *cancel;

#pragma mark - Screen label
@property (weak, nonatomic) IBOutlet UILabel *screen;

#pragma mark - Player
@property (strong, nonatomic) AVAudioPlayer *player;

#pragma mark - Temp values
@property (strong, nonatomic) NSString *number1;
@property (strong, nonatomic) NSString *number2;

#pragma mark - Events
- (IBAction)numberButtonPressed:(id)sender;
- (IBAction)processButtonPressed:(id)sender;
- (IBAction)resultButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

#pragma mark - Methods
- (void)screenOrganize;
- (void)cancelProcess;

@end
