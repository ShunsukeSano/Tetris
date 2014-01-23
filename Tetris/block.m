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


-(void)randomBlock
{
    nextBlock = arc4random()%7+2;
}

-(void)fieldInit
{
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            field[i][j] = 0;
        }
    }
}

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

-(void)tempInit
{
    for(int i=0;i<HEIGHT;i++){
        for(int j=0;j<WIDTH;j++){
            temp[i][j] = 0;
        }
    }
}



-(void)flowBlock
{
    currentBlock = nextBlock;
    [self randomBlock];
}

-(void)createBlock
{
    //currentBlock = 7;
    originX = WIDTH/3+1;
    originY = 0;
    switch(currentBlock){
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

-(void)drawBlock
{
    for(int i=0;i<HEIGHT-2;i++){
        for(int j=1;j<WIDTH-1;j++){
            if(field[i][j]==0 || display[i][j]==0){
                img[i][j].image = [UIImage imageNamed:@"black.png"];
            }
            
            if(field[i][j]==2 || display[i][j]==2){
                img[i][j].image = [UIImage imageNamed:@"block4.jpg"];
            }
            
            else if(field[i][j]==3 || display[i][j]==3){
                img[i][j].image = [UIImage imageNamed:@"block0.jpg"];
            }
            
            else if(field[i][j]==4 || display[i][j]==4){
                img[i][j].image = [UIImage imageNamed:@"block2.jpg"];
            }
            
            else if(field[i][j]==5 || display[i][j]==5){
                img[i][j].image = [UIImage imageNamed:@"block1.jpg"];
            }
            
            else if(field[i][j]==6 || display[i][j]==6){
                img[i][j].image = [UIImage imageNamed:@"block5.jpg"];
            }
            
            else if(field[i][j]==7 || display[i][j]==7){
                img[i][j].image = [UIImage imageNamed:@"block3.jpg"];
            }
            
            else if(field[i][j]==8 || display[i][j]==8){
                img[i][j].image = [UIImage imageNamed:@"block6.jpg"];
            }
        }
    }
}



-(void)drawNextBlock
{
    switch(nextBlock){
        case 2:
            nextImg.image = [UIImage imageNamed:@"tetrimino4.jpg"];
            break;
        case 3:
            nextImg.image = [UIImage imageNamed:@"tetrimino0.jpg"];
            break;
        case 4:
            nextImg.image = [UIImage imageNamed:@"tetrimino2.jpg"];
            break;
        case 5:
            nextImg.image = [UIImage imageNamed:@"tetrimino1.jpg"];
            break;
        case 6:
            nextImg.image = [UIImage imageNamed:@"tetrimino5.jpg"];
            break;
        case 7:
            nextImg.image = [UIImage imageNamed:@"tetrimino3.jpg"];
            break;
        case 8:
            nextImg.image = [UIImage imageNamed:@"tetrimino6.jpg"];
            break;
    }
}

-(void)drawHoldBlock
{
    switch(holdBlock){
        case 2:
            holdImg.image = [UIImage imageNamed:@"tetrimino4.jpg"];
            break;
        case 3:
            holdImg.image = [UIImage imageNamed:@"tetrimino0.jpg"];
            break;
        case 4:
            holdImg.image = [UIImage imageNamed:@"tetrimino2.jpg"];
            break;
        case 5:
            holdImg.image = [UIImage imageNamed:@"tetrimino1.jpg"];
            break;
        case 6:
            holdImg.image = [UIImage imageNamed:@"tetrimino5.jpg"];
            break;
        case 7:
            holdImg.image = [UIImage imageNamed:@"tetrimino3.jpg"];
            break;
        case 8:
            holdImg.image = [UIImage imageNamed:@"tetrimino6.jpg"];
            break;
    }
}



-(int)checkRightBlock
{
    for(int j=originX;j<originX+4;j++){
        for(int i=originY;i<originY+4;i++){
            if(field[i][j] >= 2){
                if(display[i][j+1])
                    return 0;
            }
        }
    }
    return 1;
}


-(void)moveRightBlock
{
    for(int j=originX+3;j>=originX;j--){
        for(int i=originY;i<originY+4;i++){
            temp[i][j] = field[i][j];
            field[i][j] = 0;
        }
    }
    originX++;
    for(int j=originX+3;j>=originX;j--){
        for(int i=originY;i<originY+4;i++){
            field[i][j] = temp[i][j-1];
            temp[i][j-1] = 0;
        }
    }
}

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


-(int)checkSpinLeftBlock
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


-(int)checkLine
{
    for(int i=HEIGHT-2;i>=0;i--){
        for(int j=1;j<WIDTH-1;j++){
            if(display[i][j] >= 2){
                lineCount++;
            }
            if(lineCount >= WIDTH-2){
                lineCount = 0;
                return i;
            }
        }
        lineCount = 0;
    }
    return HEIGHT;
}



-(void)deleteLine
{
    lineNumber = [self checkLine];
    if(lineNumber < HEIGHT){
        for(int j=1;j<WIDTH-1;j++){
            display[lineNumber][j] = 0;
        }
        for(int j=1;j<WIDTH-1;j++){
            for(int i=lineNumber;i>=0;i--){
                temp[i][j] = display[i][j];
                display[i][j] = 0;
            }
        }
        for(int j=1;j<WIDTH-1;j++){
            for(int i=lineNumber;i>=1;i--){
                display[i][j] = temp[i-1][j];
                temp[i-1][j] = 0;
            }
        }
        for(int j=1;j<WIDTH-1;j++){
            display[0][j] = 0;
        }
    }
}

-(void)blockDelete
{
    for(int i=originY;i<originY+4;i++){
        for(int j=originX;j<originX+4;j++){
            field[i][j] = 0;
        }
    }
}


-(void)holdBlock
{
    if(holdBlock == 0){
        holdBlock = currentBlock;
        [self blockDelete];
        [self flowBlock];
        [self createBlock];
    }else{
        memoryBlock = currentBlock;
        currentBlock = holdBlock;
        holdBlock = memoryBlock;
        [self blockDelete];
        [self createBlock];
    }
}

-(int)checkGameOver
{
    for(int j=1;j<WIDTH-1;j++){
        if(display[1][j] >= 2)
            return 1;
    }
    return 0;
}


@end
