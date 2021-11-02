Program main;

Uses GraphABC, ABCObjects, ABCSprites, Timers, sprites, control, heroes, handler, gameInterface;

var
  t: Timer;
  //Timer
  minuteTxt,secondTxt:string;
  minute,second:integer;
  timeText: TextABC;


procedure gameTime;
  begin
    
    if second = 0 then
    begin
      second:=59;
      minute-=1;
    end
    else
      second-=1;
        
    if (minute = 0) and (second = 0) then
      t.Stop;
    
    minuteTxt:='0'+minute;
    
    if second < 10 then
      secondTxt:='0'+second
    else
      secondTxt:=''+second;
    timeText.Text:=minuteTxt+':'+secondTxt;    
    
  end;
  
  procedure gameStart();
  var
    w1,w2:TextABC;
  begin
    //Menu
    menuInterfaceHandler;
    
    //Fight
    Window.Fill('assets\maps\'+mapName+'.png');
    
    case name1 of
      'rogue':p1:= new Hero(addSprite(name1,10,320),8,20,60,'R',name1);
      'mage':p1:= new Hero(addSprite(name1,10,320),6,20,60,'R',name1);
      'viking':p1:= new Hero(addSprite(name1,10,320),4,20,60,'R',name1);
    end;
    
    if (name1 = 'mage') and ((botOn)or(name2='mage')) then
    begin
      case random(0,1) of
        0:name2:='rogue';
        1:name2:='viking';
      end;
    end
    else if (botOn) then
    begin
      case random(0,2) of
        0:name2:='rogue';
        1:name2:='mage';
        2:name2:='viking';
      end;
    end;
    
    case name2 of
      'rogue':p2:= new Hero(addSprite(name2,700,320),8,20,60,'L',name2);
      'mage':p2:= new Hero(addSprite(name2,700,320),6,20,60,'L',name2);
      'viking':p2:= new Hero(addSprite(name2,700,320),4,20,60,'L',name2);
    end;
    
    p2.sprite.StateName:='standL';
    p1.sprite.StateName:='standR';
    
    //fireball mage
    fire := addSprite('fire', 900, 500);
    fire.Visible:= false;
    fire.StateName:='hurtR';
  
    p1.sprite.Speed:=8;
    p2.sprite.Speed:=8;
    
    drawGameInterface;
    //Timer
    second:=30;
    minute:=1;
    timeText:= new TextABC(405,25,28,'01:30',Color.Goldenrod);
    t:= new Timer(995, gameTime);
    t.Start;
    
    fightStartPct:= new PictureABC(300,200,'assets\interface\game\fight.png');
    sleep(1000);
    fightStartPct.Destroy;
  
    LockDrawingObjects;
    
    //Начало игры
    while true do
    begin
      
      RedrawObjects;
      p1.sprite.NextTick;
      p2.sprite.NextTick;
      
      OnKeyDown:= keyDown;
      OnKeyUp:= keyUp;
      
      //Обработка состояний спрайтов
      if (p1.sprite.StateName <> 'move'+p1.direction) and (p1.sprite.StateName <> 'stand'+p1.direction) then
        spriteLife(p1.sprite.StateName);
      
      if (p2.sprite.StateName <> 'move'+p2.direction) and (p2.sprite.StateName <> 'stand'+p2.direction) then
        spriteLife(p2.sprite.StateName);
      
      if ((p1.sprite.StateName='move'+p1.direction) or (p1.sprite.StateName='stand'+p1.direction)) and ((p2.sprite.StateName='move'+p2.direction) or (p2.sprite.StateName='stand'+p2.direction))then
      begin
        control_1;
        control_2;
      end;
      
      if ((p1.sprite.Center.X+50 > 900) and (p1.sprite.dx > 0))or((p1.sprite.Center.X-50 < 1) and (p1.sprite.dx < 0)) then
        p1.sprite.dx:=0;
      if ((p2.sprite.Center.X+50 > 900) and (p2.sprite.dx > 0))or((p2.sprite.Center.X-50 < 1) and (p2.sprite.dx < 0)) then
        p2.sprite.dx:=0;
      
      if botOn then
        botControl(2);
      
      if ((p1.sprite.StateName = 'death'+p1.direction) and (p1.sprite.Frame = p1.sprite.FrameCount-1)) or ((second=0)and(minute=0)and(hp2.Width > hp1.Width)) then
      begin
        p1.sprite.Active:=false;
        p2.victory;
      end
      else if ((p2.sprite.StateName = 'death'+p2.direction) and (p2.sprite.Frame = p2.sprite.FrameCount-1)) or ((second=0)and(minute=0)and(hp1.Width > hp2.Width)) then
      begin
        p2.sprite.Active:=false;
        p1.victory;
      end;
      
      p1.sprite.Move;
      p2.sprite.Move;
      
      //Обработка боя
      fightHandler();
      
      if ((second = 0) and (minute = 0)) or ((hp1.Width <= 1) or (hp2.Width <= 1)) then
      begin
        if hp1.Width = 1 then
        begin
          p1.death;
          p2.victory;
        end
        else if hp2.Width = 1 then
        begin
          p2.death;
          p1.victory;
        end;
        
        path:='menu';
        UnlockDrawingObjects;
        if (p1.sprite.Active = false) then
        begin
          if p2.sprite.Frame = p2.sprite.FrameCount-1 then
          begin
            p1.sprite.Destroy;
            p2.sprite.Destroy;
            p1.stand;
            p2.stand;
            param1.Destroy;
            param2.Destroy;
            t.Stop;
            hp1.Destroy;
            hp2.Destroy;
            stm1.Destroy;
            stm2.Destroy;
            pwr1.Destroy;
            pwr2.Destroy;
            timeText.Destroy;
            timeBoard.Destroy;
            Window.Clear;
            Window.Fill('assets\interface\menu\winnerBoard.png');
            w1:=TextABC.Create(350,180,40,'Player 2',Color.Black);
            Sleep(3500);
            w1.Destroy;
            break
          end;
        end
        else if (p2.sprite.Active = false) then
        begin
          if p1.sprite.Frame = p1.sprite.FrameCount-1 then
          begin
            p1.sprite.Destroy;
            p2.sprite.Destroy;
            p1.stand;
            p2.stand;
            param1.Destroy;
            param2.Destroy;
            t.Stop;
            hp1.Destroy;
            hp2.Destroy;
            stm1.Destroy;
            stm2.Destroy;
            pwr1.Destroy;
            pwr2.Destroy;
            timeText.Destroy;
            timeBoard.Destroy;
            Window.Clear;
            Window.Fill('assets\interface\menu\winnerBoard.png');
            w2:=TextABC.Create(350,180,40,'Player 1',Color.Black);
            Sleep(3500);
            w2.Destroy;
            break
          end;
        end 
        
      end;
      
    end;
    gameStart;
    
  end;
Begin
  
  SetWindowSize(900,500);
  Window.IsFixedSize:= true;
  Window.Caption:= 'FantasyFight';

  gameStart;
end.