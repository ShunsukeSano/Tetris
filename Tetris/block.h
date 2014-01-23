//
//  block.h
//  Tetris
//
//  Created by 佐野　隼輔 on 13/12/12.
//  Copyright (c) 2013年 University_of_Kitakyusyu. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "ViewController.h"
#define WIDTH 12
#define HEIGHT 27

@interface block : NSObject
{
    int blocks[4][4];   //4*4のマスでブロックを宣言
    int blocksTemp[4][4];  //blocks内の値を一時的にコピー
    int field[HEIGHT][WIDTH];   //fieldの大きさ field:落下中のブロックを管理
    int display[HEIGHT][WIDTH];  //displayの大きさ display:落下済みのブロックを管理
    int temp[HEIGHT][WIDTH];     //tempの大きさ temp:値を一時的に格納する 移動、回転で使用
    NSInteger currentBlock;   //現在落下中のブロックの番号
    NSInteger nextBlock;      //次に落ちてくるブロックの番号
    NSInteger holdBlock;      //HOLDされているブロックの番号
    NSInteger memoryBlock;    //ブロックの番号を一時的に記憶させる HOLDで使用
    NSInteger count;      //落下間隔
    NSInteger lineCount;   //一列消せるかどうかを判定
    NSInteger lineNumber;  //消す行の番号
    NSInteger originX;    //ブロックの原点x座標
    NSInteger originY;    //ブロックの原点y座標
}

//初期化
-(void)fieldInit;  //fieldの初期化
-(void)displayInit;   //displayの初期化
-(void)tempInit;      //tempの初期化

//ブロック関係
-(void)randomBlock;   //乱数の発生
-(void)flowBlock;     //次のブロックを現在のブロックへ遷移させ、次のブロックを決める
-(void)createBlock;   //ブロックを初期位置に配置

//描画関係
-(void)drawBlock;     //ブロックの描画
-(void)drawNextBlock;  //次ブロックの描画
-(void)drawHoldBlock;  //ホールドブロックの描画


//ブロックの移動
-(int)checkRightBlock;   //右へ移動できるかどうか
-(void)moveRightBlock;   //右へ移動
-(int)checkLeftBlock;    //左へ移動できるかどうか
-(void)moveLeftBlock;    //左へ移動
-(int)checkUnderBlock;   //下へ移動できるかどうか
-(void)moveUnderBlock;   //下へ移動



-(void)copyDisplay;    //落下が終わるとdisplayに値をコピー 移動、回転が不可能にまた、当たり判定がつく


//ブロックの回転
-(int)checkSpinRightBlock;  //右回転できるかどうか
-(void)spinRightBlock;      //右回転
-(int)checkSpinLeftBlock;  //左回転できるかどうか
-(void)spinLeftBlock;      //左回転

//行の消去
-(int)checkLine;  //そろっている行の番号を返す 無い場合はHEIGHTを返す
-(void)deleteLine;  //そろった行を消す
//-(void)swapBlock;      //行が消されたとき、その行より上のブロックをずらす


//HOLD関係
-(void)blockDelete;   //現在落下中のブロックを消す
-(void)holdBlock;    //ホールドの処理

//GAMEOVER
-(int)checkGameOver;  //GAMEOVER処理

@end
