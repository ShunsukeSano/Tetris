//
//  ViewController.h
//  Tetris
//
//  Created by 佐野　隼輔 on 13/12/12.
//  Copyright (c) 2013年 University_of_Kitakyusyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "block.h"
#import <QuartzCore/QuartzCore.h>

#define WIDTH 12
#define HEIGHT 27
UIImageView *img[HEIGHT][WIDTH];
UIImageView *nextImg;
UIImageView *holdImg;


@interface ViewController : UIViewController{
    IBOutlet UIButton *startButtom;
    IBOutlet UIButton *holdButtom;
    IBOutlet UIButton *spinLeftButtom;
    IBOutlet UIButton *spinRightButtom;
    IBOutlet UIButton *upButtom;
    IBOutlet UIButton *leftButtom;
    IBOutlet UIButton *rightButtom;
    IBOutlet UIButton *downButtom;
    block* m_block;
    CADisplayLink *timer;
}

@property (weak, nonatomic) IBOutlet UILabel *disp;

@property (weak, nonatomic) IBOutlet UILabel *holdLabel;

@property (weak, nonatomic) IBOutlet UILabel *nextLabel;

@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;

@property(nonatomic) NSInteger frameInterval;


- (IBAction)holdButtom:(id)sender;

- (IBAction)spinButtom:(id)sender;

- (IBAction)rigthLeftButtom:(id)sender;

- (IBAction)upDownButtom:(id)sender;

- (IBAction)startButtom:(id)sender;

@property enum {holdButtom} state;

@end
