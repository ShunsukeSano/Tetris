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
    holdButtom.enabled = NO;
    m_block = [[block alloc]init];
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

//アニメーション設定  指定した関数のみ無限ループ
    timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(loopDownBlock)];
    [timer setFrameInterval:20];  //ループ間隔
    [timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
//アニメーション設定end
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//ループされる関数
-(void)loopDownBlock{
        if([m_block checkUnderBlock] == 1){  //下に移動できるなら
            [m_block moveUnderBlock];        //下に移動
        }else{                               //できないなら
            [m_block copyDisplay];           //落下中から落下済みへ
            if([m_block checkGameOver] == 1){   //ゲームオーバーかどうか
                [[self gameOverLabel] setText:@"GAMEOVER"];  //GAMEOVERの表示
                holdButtom.enabled = NO;         //全ボタンを効かなくする
                spinLeftButtom.enabled = NO;
                spinRightButtom.enabled = NO;
                upButtom.enabled = NO;
                leftButtom.enabled = NO;
                rightButtom.enabled = NO;
                downButtom.enabled = NO;
                return;
            }
            
            [m_block deleteLine];   //行の消去
            [m_block flowBlock];    //ブロックの遷移
            [m_block createBlock];
            [m_block drawBlock];     //ブロック描画
            for(int i=0;i<HEIGHT;i++){
                for(int j=0;j<WIDTH;j++){
                    [self.disp addSubview:img[i][j]];
                }
            }
            [m_block drawNextBlock];   //次ブロック描画
            [self.nextLabel addSubview:nextImg];
            holdButtom.enabled = YES;
        }
    [m_block drawBlock];
    for(int i=0;i<HEIGHT-2;i++){
        for(int j=1;j<WIDTH-1;j++){
            [self.disp addSubview:img[i][j]];
        }
    }

    
}



- (IBAction)holdButtom:(id)sender {
    [m_block holdBlock];   //ホールド処理
    [m_block drawHoldBlock];   //ホールドブロックの描画
    [self.holdLabel addSubview:holdImg];
    [m_block drawNextBlock];   //次ブロック描画
    [self.nextLabel addSubview:nextImg];
    [m_block drawBlock];    //ブロックの描画
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
     holdButtom.enabled = NO;   //ホールドボタンの使用は1落下につき1回
}

- (IBAction)spinButtom:(id)sender {
    UIButton *b = (UIButton *)sender;
    if(b.tag == 0){//Rが押された
        if([m_block checkSpinRightBlock] == 1)  //右回転できるなら
            [m_block spinRightBlock];           //右回転
    }else{//Lが押された
        if([m_block checkSpinLeftBlock] == 1)   //左回転できるなら
        [m_block spinLeftBlock];                //左回転
    }    
    [m_block drawBlock];          //ブロックの描画
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            [self.disp addSubview:img[i][j]];
        }
    }
}

- (IBAction)rigthLeftButtom:(id)sender {
    UIButton *b = (UIButton *)sender;
    if(b.tag == 0){  //右が押された
        if([m_block checkRightBlock] == 1){    //右に移動できるなら
            [m_block moveRightBlock];          //右へ移動
        }
    }else{   //左が押された
        if([m_block checkLeftBlock] == 1){     //左へ移動できるなら
            [m_block moveLeftBlock];           //左へ移動
        }
    }
    [m_block drawBlock];         //ブロックの描画
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
    holdButtom.enabled = YES;
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
