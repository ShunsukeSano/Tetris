//
//  ViewController.m
//  Tetris
//
//  Created by 佐野　隼輔 on 13/12/12.
//  Copyright (c) 2013年 University_of_Kitakyusyu. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    m_block = [[block alloc]init];
    //初期化
    [m_block randomBlock];
    [m_block fieldInit];
    [m_block displayInit];
    [m_block tempInit];


//盤面の作成
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            if(j==0 || j==WIDTH-1 || i==HEIGHT-1 || i==HEIGHT-2) {
                img[i][j] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"block7.jpg"]];
                img[i][j].frame = CGRectMake(j*15, i*15, 15, 15);
                img[i][j].image = [UIImage imageNamed:@"block7.jpg"];
                [self.disp addSubview:img[i][j]];
            }else{
                img[i][j] = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
                img[i][j].frame = CGRectMake(j*15, i*15, 15, 15);
                img[i][j].image = [UIImage imageNamed:@"black.png"];
                [self.disp addSubview:img[i][j]];
            }
        }
    }
//盤面の作成end

    
//NEXTとHOLDの初期化
    nextImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    holdImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"black.png"]];
    nextImg.frame = CGRectMake(0, 0, 110, 75);
    holdImg.frame = CGRectMake(0, 0, 110, 75);
//NEXTとHOLDの初期化end
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)holdButtom:(id)sender {
    [m_block holdBlock];
    [m_block drawHoldBlock];
    [self.holdLabel addSubview:holdImg];
    [m_block drawBlock];
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
     holdButtom.enabled = NO;
}

- (IBAction)spinButtom:(id)sender {
    UIButton *b = (UIButton *)sender;
    if(b.tag == 0){//Lが押されたら左回転
        if([m_block checkSpinRightBlock] == 1)
            [m_block spinRightBlock];
    }else{//Lが押されたら左回転
        if([m_block checkSpinLeftBlock] == 1)
        [m_block spinLeftBlock];
    }    
    [m_block drawBlock];
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
}

- (IBAction)rigthLeftButtom:(id)sender {
    UIButton *b = (UIButton *)sender;
    if(b.tag == 0){  //右が押された
        if([m_block checkRightBlock] == 1){
            [m_block moveRightBlock];
        }
    }else{   //左が押された
        if([m_block checkLeftBlock] == 1){
            [m_block moveLeftBlock];
        }
    }
    [m_block drawBlock];
    for(int i=0;i<HEIGHT-2;i++){
        for(int j=1;j<WIDTH-1;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
}

- (IBAction)upDownButtom:(id)sender {
    UIButton *b = (UIButton *)sender;
    if(b.tag == 1){  //下が押された
        if([m_block checkUnderBlock] == 1){
            [m_block moveUnderBlock];
        }else{
            [m_block copyDisplay];
            if([m_block checkGameOver] == 1){
                [[self gameOverLabel] setText:@"GAMEOVER"];
                holdButtom.enabled = NO;
                spinLeftButtom.enabled = NO;
                spinRightButtom.enabled = NO;
                upButtom.enabled = NO;
                leftButtom.enabled = NO;
                rightButtom.enabled = NO;
                downButtom.enabled = NO;
                return;
            }

            [m_block deleteLine];
            [m_block flowBlock];
            [m_block createBlock];
            [m_block drawBlock];
            for(int i=0;i<HEIGHT;i++){
                for(int j=0;j<WIDTH;j++){
                    [self.disp addSubview:img[i][j]];
                }
            }
            [m_block drawNextBlock];
            [self.nextLabel addSubview:nextImg];
            holdButtom.enabled = YES;
                    }
    }
    [m_block drawBlock];
    for(int i=0;i<HEIGHT-2;i++){
        for(int j=1;j<WIDTH-1;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
}

- (IBAction)startButtom:(id)sender {
    [m_block flowBlock];
    [m_block createBlock];
    [m_block drawBlock];
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
    [m_block drawNextBlock];
    [self.nextLabel addSubview:nextImg];
    startButtom.hidden = YES;
}



@end
