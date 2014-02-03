//
//  block.m
//  Tetris
//
//  Created by 佐野　隼輔 on 13/12/12.
//  Copyright (c) 2013年 University_of_Kitakyusyu. All rights reserved.
//

#import "block.h"
#import "ViewController.h"

@implementation block


//次のブロックをランダムに決定
-(void)randomBlock
{
    nextBlock = arc4random()%7+2;  //乱数で2〜8の値をnextBlockに格納
}


//fieldの初期化
-(void)fieldInit
{
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            field[i][j] = 0;
        }
    }
}


//displayの初期化
-(void)displayInit
{
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            if(j==0 || j==WIDTH-1 || i==HEIGHT-1 || i==HEIGHT-2){
                display[i][j] = 1;
            }else{
                display[i][j] = 0;
            }
        }
    }
}


//tempの初期化
-(void)tempInit
{
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            temp[i][j] = 0;
        }
    }
}


//次のブロックを現在のブロックへ遷移させ、次のブロックを決める
-(void)flowBlock
{
    currentBlock = nextBlock;   //次のブロックを現在のブロックへ遷移させる
    [self randomBlock];         //randomBlockにより次のブロックを決める
}


//ブロックを初期位置に配置
//配列を使用すればもう少し簡単になるとの指摘を受けた。時間的に可能であれば簡単にしたい。
-(void)createBlock
{
    //currentBlock = 7;
    originX = WIDTH/3+1;    //ブロックの原点、ブロックの左上の座標を管理する。
    originY = 0;            //この点から最大4×4の範囲に落下中のブロックが存在する。
    switch(currentBlock){     //currentBlockの値によって初期位置に値を代入する。
        case 2:
            field[0][WIDTH/3+1] = 2;
            field[0][WIDTH/3+2] = 2;
            field[1][WIDTH/3+1] = 2;
            field[1][WIDTH/3+2] = 2;
            break;
        case 3:
            field[0][WIDTH/3+1] = 3;
            field[0][WIDTH/3+2] = 3;
            field[1][WIDTH/3+2] = 3;
            field[1][WIDTH/3+3] = 3;
            break;
        case 4:
            field[0][WIDTH/3+2] = 4;
            field[0][WIDTH/3+3] = 4;
            field[1][WIDTH/3+1] = 4;
            field[1][WIDTH/3+2] = 4;
            break;
        case 5:
            field[0][WIDTH/3+1] = 5;
            field[1][WIDTH/3+1] = 5;
            field[1][WIDTH/3+2] = 5;
            field[1][WIDTH/3+3] = 5;
            break;
        case 6:
            field[0][WIDTH/3+3] = 6;
            field[1][WIDTH/3+1] = 6;
            field[1][WIDTH/3+2] = 6;
            field[1][WIDTH/3+3] = 6;
            break;
        case 7:
            field[0][WIDTH/3+1] = 7;
            field[0][WIDTH/3+2] = 7;
            field[0][WIDTH/3+3] = 7;
            field[0][WIDTH/3+4] = 7;
            break;
        case 8:
            field[0][WIDTH/3+2] = 8;
            field[1][WIDTH/3+1] = 8;
            field[1][WIDTH/3+2] = 8;
            field[1][WIDTH/3+3] = 8;
            break;
    }
}


//ブロックの描画
//格納された値に合った画像が表示される。
-(void)drawBlock
{
    for(int i=0;i<HEIGHT-2;i++){
        for(int j=1;j<WIDTH-1;j++){
            if(field[i][j]==0 || display[i][j]==0){
                img[i][j].image = [UIImage imageNamed:@"black.png"];
            }
            
            if(field[i][j]==2 || display[i][j]==2){
                img[i][j].image = [UIImage imageNamed:@"blocks2.jpg"];
            }
            
            else if(field[i][j]==3 || display[i][j]==3){
                img[i][j].image = [UIImage imageNamed:@"blocks3.jpg"];
            }
            
            else if(field[i][j]==4 || display[i][j]==4){
                img[i][j].image = [UIImage imageNamed:@"blocks4.jpg"];
            }
            
            else if(field[i][j]==5 || display[i][j]==5){
                img[i][j].image = [UIImage imageNamed:@"blocks5.jpg"];
            }
            
            else if(field[i][j]==6 || display[i][j]==6){
                img[i][j].image = [UIImage imageNamed:@"blocks6.jpg"];
            }
            
            else if(field[i][j]==7 || display[i][j]==7){
                img[i][j].image = [UIImage imageNamed:@"blocks7.jpg"];
            }
            
            else if(field[i][j]==8 || display[i][j]==8){
                img[i][j].image = [UIImage imageNamed:@"blocks8.jpg"];
            }
        }
    }
}


//次ブロックの描画
//格納された値に合った画像が表示される。
-(void)drawNextBlock
{
    switch(nextBlock){
        case 2:
            nextImg.image = [UIImage imageNamed:@"tetriminos2.jpg"];
            break;
        case 3:
            nextImg.image = [UIImage imageNamed:@"tetriminos3.jpg"];
            break;
        case 4:
            nextImg.image = [UIImage imageNamed:@"tetriminos4.jpg"];
            break;
        case 5:
            nextImg.image = [UIImage imageNamed:@"tetriminos5.jpg"];
            break;
        case 6:
            nextImg.image = [UIImage imageNamed:@"tetriminos6.jpg"];
            break;
        case 7:
            nextImg.image = [UIImage imageNamed:@"tetriminos7.jpg"];
            break;
        case 8:
            nextImg.image = [UIImage imageNamed:@"tetriminos8.jpg"];
            break;
    }
}


//ホールドブロックの描画
//格納された値に合った画像が表示される。
-(void)drawHoldBlock
{
    switch(holdBlock){
        case 2:
            holdImg.image = [UIImage imageNamed:@"tetriminos2.jpg"];
            break;
        case 3:
            holdImg.image = [UIImage imageNamed:@"tetriminos3.jpg"];
            break;
        case 4:
            holdImg.image = [UIImage imageNamed:@"tetriminos4.jpg"];
            break;
        case 5:
            holdImg.image = [UIImage imageNamed:@"tetriminos5.jpg"];
            break;
        case 6:
            holdImg.image = [UIImage imageNamed:@"tetriminos6.jpg"];
            break;
        case 7:
            holdImg.image = [UIImage imageNamed:@"tetriminos7.jpg"];
            break;
        case 8:
            holdImg.image = [UIImage imageNamed:@"tetriminos8.jpg"];
            break;
    }
}


//右へ移動できるかどうかを判定する
-(int)checkRightBlock
{
    for(int j=originX;j<originX+4;j++){      //原点から4×4の範囲を走査し、
        for(int i=originY;i<originY+4;i++){
            if(field[i][j] >= 2){      //fieldの値が2以上つまり、落下中のブロックが存在するマスを見る
                if(display[i][j+1])   //上で見たマスの1つ右のマスに値が存在するつまり、ブロックがあれば
                    return 0;         //0を返す
            }
        }
    }
    return 1;       //ブロックがなければ移動できるとし、1を返す
}


//右へ移動
//原点（ブロックの左上の座標）を管理し、そこから4*4の範囲を切り取ってコピー、ずらして貼付け
//原点を管理するのはブロックの場所を探す走査を4*4の範囲に限定し、計算を短くするためである。
-(void)moveRightBlock
{
    for(int j=originX+3;j>=originX;j--){       //原点から4×4の範囲を走査し、
        for(int i=originY;i<originY+4;i++){
            temp[i][j] = field[i][j];          //落下中のブロックを一時的にtempへコピー
            field[i][j] = 0;                   //fieldを0に
        }
    }
    originX++;      //原点を1つ右へずらす
    for(int j=originX+3;j>=originX;j--){       //原点から4×4の範囲を走査し、
        for(int i=originY;i<originY+4;i++){
            field[i][j] = temp[i][j-1];        //tempに格納した値をfieldに戻す
            temp[i][j-1] = 0;                  //tempを0に
        }
    }
}


//左へ移動できるかどうかを判定する
-(int)checkLeftBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(field[i][j] >= 2){
                if(display[i][j-1])
                    return 0;
            }
        }
    }
    return 1;
}


//左へ移動
//右の移動と同じのため説明省略
-(void)moveLeftBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            temp[i][j] = field[i][j];
            field[i][j] = 0;
        }
    }
    originX--;
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            field[i][j] = temp[i][j+1];
            temp[i][j+1] = 0;
        }
    }
}


//下へ移動できるかどうかを判定する
-(int)checkUnderBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(field[i][j] >= 2){
                if(display[i+1][j])
                    return 0;
            }
        }
    }
    return 1;
}


//下へ移動
//左右の移動と同じのため説明省略
-(void)moveUnderBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            temp[i][j] = field[i][j];
            field[i][j] = 0;
        }
    }
    originY++;
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            field[i][j] = temp[i-1][j];
            temp[i-1][j] = 0;
        }
    }
}


//落下が終わるとdisplayに値をコピー 移動、回転が不可能に。また、当たり判定がつく
//落下中はfieldで、落下済みはdisplayで管理することによって値の管理をしやすくしている。
-(void)copyDisplay
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(field[i][j] >= 2){
                display[i][j] = field[i][j];
                field[i][j] = 0;
            }
        }
    }
}


//左回転できるかどうかを判定する
//左回転は行列を転置して行を入れ替えることで実現できる。
//上記の方法で回転を実現させるとき正方行列でなければ上手く動かないのでHEIGHT*WIDTHのtempではなく4*4で宣言したblocksとblocksTempを使用する。
-(int)checkSpinLeftBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            blocks[i-originY][j-originX] = field[i][j];
            //ブロックの値をblocksに格納する。i-originYやj-originXによってどの座標でも0〜3の4*4正方行列に格納できる。
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocksTemp[i][j] = blocks[i][j];  //blocksTempにblocksの値をコピー
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocks[i][j] = blocksTemp[j][3-i];   //blocksにblocksTempの左回転をコピー
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            if(blocks[i][j]>=2){      //blocksに値の入っているマスについて
                if(display[i+originY][j+originX] >=1){  //回転後のブロックを戻したときdisplayにブロックがあるかを判定
                    return 0;     //あれば回転できないとし、0を返す。
                }
            }
        }
    }
    return 1;         //なければ回転できるとし、1を返す
}


//左回転
//checkSpinLeftBlockと同様のやり方
//違うのは最後にfieldにブロックの値を戻すかどうか
-(void)spinLeftBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            blocks[i-originY][j-originX] = field[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocksTemp[i][j] = blocks[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocks[i][j] = blocksTemp[j][3-i];
        }
    }

    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(display[i][j] == 0)
            field[i][j] = blocks[i-originY][j-originX];
        }
    }
}


//右回転できるかどうかを判定する
//右回転は行列を転置して列を入れ替えることで実現できる。
//左回転と同じのため説明省略
-(int)checkSpinRightBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            blocks[i-originY][j-originX] = field[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocksTemp[i][j] = blocks[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocks[i][j] = blocksTemp[3-j][i];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            if(blocks[i][j]>=2){
                if(display[i+originY][j+originX] >=1){
                    return 0;
                }
            }
        }
    }
    return 1;
}


//右回転
//左回転と同じのため説明省略
-(void)spinRightBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            blocks[i-originY][j-originX] = field[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocksTemp[i][j] = blocks[i][j];
        }
    }
    
    for(int j=0;j<4;j++){
        for(int i=0;i<4;i++){
            blocks[i][j] = blocksTemp[3-j][i];
        }
    }
    
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(display[i][j] == 0)
                field[i][j] = blocks[i-originY][j-originX];
        }
    }
}


//そろっている行の番号を返す 無い場合はHEIGHTを返す
-(int)checkLine
{
    for(int i=HEIGHT-2;i>=0;i--){       //一番下の行から1行ずつ走査
        for(int j=1;j<WIDTH-1;j++){
            if(display[i][j] >= 2){     //落下済みブロックがあるなら
                lineCount++;            //lineCountの値を1増加
            }
            if(lineCount >= WIDTH-2){   //lineCountがWIDTH-2以上ならその行のすべての列にブロックが存在する。
                lineCount = 0;          //lineCountを初期化
                return i;               //そろった行の行番号を返す
            }
        }
        lineCount = 0;     //そろわなくても初期化
    }
    return HEIGHT;   //そろわなければHEIGHTを返す。これはそろったときに返され得る数字以外ならなんでも良い。
}


//そろった行を消す
-(void)deleteLine
{
    while(YES){
    lineNumber = [self checkLine];  //そろった行番号をlineNumberに格納
    if(lineNumber < HEIGHT){
        for(int j=1;j<WIDTH-1;j++){
            display[lineNumber][j] = 0;   //そろった行の値を0にする。
        }
        for(int j=1;j<WIDTH-1;j++){  //そろった行より上を、
            for(int i=lineNumber;i>=0;i--){
                temp[i][j] = display[i][j];  //tempにコピー
                display[i][j] = 0;
            }
        }
        for(int j=1;j<WIDTH-1;j++){
            for(int i=lineNumber;i>=1;i--){
                display[i][j] = temp[i-1][j];  //1行ずらしてtempの中身をコピー
                temp[i-1][j] = 0;
            }
        }
        for(int j=1;j<WIDTH-1;j++){
            display[0][j] = 0;
        }
    }else{  //そろった行がないなら
        break;  //ループを抜ける
    }
    }
}


//現在落下中のブロックを消す
-(void)blockDelete
{
    for(int i=originY;i<originY+4;i++){
        for(int j=originX;j<originX+4;j++){
            field[i][j] = 0;
        }
    }
}


//ホールドの処理
-(void)holdBlock
{
    if(holdBlock == 0){      //ホールドされていないなら
        holdBlock = currentBlock;   //現在落下中のブロックをホールド
        [self blockDelete];         //落下中のブロックを消す
        [self flowBlock];           //ブロックの遷移
        [self createBlock];
    }else{                   //ホールドされているブロックがあるなら
        memoryBlock = currentBlock;  //現在のブロックを一時的に保存
        currentBlock = holdBlock;    //ホールドされていたブロックを落下ブロックに
        holdBlock = memoryBlock;     //ホールドされるのは先まで落下していたブロック
        [self blockDelete];          //落下中のブロックを消す
        [self createBlock];          //ブロックの遷移
    }
}


//GAMEOVER処理
//赤いラインより上に来たらゲームオーバー
-(int)checkGameOver
{
    for(int j=1;j<WIDTH-1;j++){
        if(display[1][j] >= 2)
            return 1;
    }
    return 0;
}


@end
