Unit gameInterface;

interface

Uses GraphABC, ABCObjects, heroes, Timers;

var
  path:string;
  hp1,hp2,pwr1,pwr2,stm1,stm2:RectangleABC;
  button,button2,timeBoard,param1,param2,fightStartPct: PictureABC;
  hp2X,pwr2X,stm2X:integer;
  space,right,left,up,down,back,enter,botOn:boolean;
  stmTimer: Timer;
  name1,name2,mapName:string;

procedure menuInterfaceHandler;

procedure drawMenu;
procedure drawTutorial;
procedure drawAbout;

procedure keyDownMenu(k:integer);
procedure keyUpMenu(k:integer);

procedure drawGameInterface;
procedure gameInterfaceHandler;
procedure drawChoiceChr;
procedure drawChoiceMap;


implementation

//Управление меню
procedure keyDownMenu(k:integer);
begin
  if (path = 'menu') or (path = 'maps') then
  begin
    if (k = VK_W) and (button.Position.Y <> 135) then
      up:=true
    else if (k = VK_S) and (button.Position.Y <> 255) then
      down:=true
    else if (k = VK_Space) then
      space:=true;
  end
  else
  begin
    if (k = VK_Escape) then
      back:=true;
  end;
  
  if (path = '1 player') or (path = '2 player') or (path = 'maps') then
  begin
    
    if (k = VK_A) then
      left:=true
    else if (k = VK_D)then
      right:=true
    else if (k = VK_Space) then
      space:=true;

    if path = '2 player' then
    begin
      
      if (k = VK_Numpad4) then
        up:=true
      else if (k = VK_Numpad6)then
        down:=true
      else if (k = VK_Numpad0) then
        enter:=true;
      
    end;
    
  end

end;

procedure keyUpMenu(k:integer);
begin    
  if (k = VK_Numpad4) then
    up:=false
  else if (k = VK_Numpad6) then
    down:=false
  else if (k = VK_Escape) then
    back:=false
  else if (k = VK_Numpad0) then
    enter:=false
  else if (k = VK_A) then
    left:=false
  else if (k = VK_D)then
    right:=false
  else if (k = VK_Space) then
    space:=false;
end;

//Процедуры для отрисовки интерфейса

///Рисует страницу обучения
procedure drawTutorial;
var
  t1,t2,t3,t4,t5,t6,t7,t8: TextABC;
begin
  Window.Fill('assets\interface\menu\boardMenu.png');
  
  t1:= TextABC.Create(290,80,26,'Игрок 1:',Color.BlanchedAlmond);
  t2:= TextABC.Create(290,130,26,'w a d - движение',Color.Black);
  t3:= TextABC.Create(290,170,26,'space - атака',Color.Black);
  t4:= TextABC.Create(290,210,26,'e - усиленная атака',Color.Black);
  t5:= TextABC.Create(290,270,26,'Игрок 2 (NumPad):',Color.BlanchedAlmond);
  t6:= TextABC.Create(290,320,26,'8 4 6 - движение',Color.Black);
  t7:= TextABC.Create(290,360,26,'0 - атака',Color.Black);
  t8:= TextABC.Create(290,400,26,'7 - усиленная атака',Color.Black);

  while true do
  begin
    
    onKeyDown:=keyDownMenu;
    onKeyUp:=keyUpMenu;
    
    if back then
      path:='menu';    
    
    if path <> 'tutorial' then
    begin
      t1.Destroy;
      t2.Destroy;
      t3.Destroy;
      t4.Destroy;
      t5.Destroy;
      t6.Destroy;
      t7.Destroy;
      t8.Destroy;
      menuInterfaceHandler;
      break;
    end;
  end;
end;

///Рисует страницу об авторе
procedure drawAbout;
var
  t1: TextABC;
begin
  Window.Fill('assets\interface\menu\boardMenu.png');
  t1:= TextABC.Create(300,250,26,'Марат Кундетов',Color.Black);
  while true do
  begin
    
    onKeyDown:=keyDownMenu;
    onKeyUp:=keyUpMenu;
    
    if back then
      path:='menu';
    
    if path <> 'about' then
    begin
      t1.Destroy;
      menuInterfaceHandler;
      break;
    end;
  end;
end;

///Рисует окно для выбора персонажа
procedure drawChoiceChr;
var
  rct1,rct2: PictureABC;
  f1,f2: boolean;
begin
  space:=false;
  //1 player
  if path = '1 player' then
  begin
    botOn:=true;
    Window.Fill('assets\interface\menu\choice1Character.png');
    
    button:= new PictureABC(255,200,'assets\interface\menu\choice.png');//250, 410, 570;
    button.Scale(1.3);
    
    rct1:= new PictureABC(238,237,'assets\interface\menu\frame.png');
    rct1.Scale(1.05);
    
    while true do
    begin
      onKeyDown:=keyDownMenu;
      onKeyUp:=keyUpMenu;
      
      if back then
      begin
        path:='menu';
        rct1.Destroy;
        button.Destroy;
        menuInterfaceHandler;
        break;
      end
      else if space then
      begin
        case button.Position.X of
          255:name1:='rogue';
          410:name1:='mage';
          570:name1:='viking';
        end;
        rct1.Destroy;
        button.Destroy;
        path:='maps';
        menuInterfaceHandler;
        break;
      end;
      
      if (right) then
      begin
        if (button.Position.X = 255) then
        begin
          right:=false;
          button.MoveTo(410, 200);
          rct1.MoveTo(393, 237);
        end
        else if (button.Position.X = 410) then
        begin
          right:=false;
          button.MoveTo(570, 200);
          rct1.MoveTo(555, 237);
        end;
      end
      else if (left) then
      begin
        if (button.Position.X = 570) then
        begin
          left:=false;
          button.MoveTo(410, 200);
          rct1.MoveTo(393, 237);
        end
        else if (button.Position.X = 410) then
        begin
          left:=false;
          button.MoveTo(255, 200);
          rct1.MoveTo(238, 237);
        end;
      end;
      
    end;
  end//2 player
  else if path = '2 player' then
  begin
    botOn:=false;
    Window.Fill('assets\interface\menu\choice2Character.png');
    
    button:= new PictureABC(51,210,'assets\interface\menu\choice.png');//(15)51, 185, 319;
    button.Scale(1.3);
    button2:= new PictureABC(501,210,'assets\interface\menu\choice.png');//501, 635, 769;
    button2.Scale(1.3);
    
    rct1:= new PictureABC(button.Position.X-15,247,'assets\interface\menu\frame.png');//36,170,304
    rct1.Scale(1.05);
    rct2:= new PictureABC(button2.Position.X-15,247,'assets\interface\menu\frame.png');//486,620,754
    rct2.Scale(1.05);
    
    while true do
    begin
      
      onKeyDown:=keyDownMenu;
      onKeyUp:=keyUpMenu;
      
      if back then
      begin
        path:='menu';
        rct1.Destroy;
        rct2.Destroy;
        button.Destroy;
        button2.Destroy;
        menuInterfaceHandler;
        break;
      end
      else if (space) or (enter) then
      begin
        
        if (space) then
        begin
          case button.Position.X of
            51:name1:='rogue';
            185:name1:='mage';
            319:name1:='viking';
          end;
          rct1.Destroy;
          rct1:= new PictureABC(button.Position.X - 15, 247,'assets/interface/menu/frameReady.png');
          rct1.Scale(1.05);
          f1:=true;
        end;
        
        if (enter) then
        begin
          case button2.Position.X of
            501:name2:='rogue';
            635:name2:='mage';
            769:name2:='viking';
          end;
          rct2.Destroy;
          rct2:= new PictureABC(button2.Position.X - 15, 247, 'assets/interface/menu/frameReady.png');
          rct2.Scale(1.05);
          f2:=true;
        end;  
      end;
      
     if (f1) and (f2) then
      begin
        rct1.Destroy;
        rct2.Destroy;
        button.Destroy;
        button2.Destroy;
        path:='maps';
        menuInterfaceHandler;
        break;
      end;
      
      if f2 = false then
      begin
        if (down) then
        begin
          if (button2.Position.X <> 769) then
          begin
            down:=false;
            button2.MoveTo(button2.Position.X+134, 210);
            rct2.MoveTo(button2.Position.X-15, 247);
          end;
        end
        else if (up) then
        begin
          if (button2.Position.X <> 501) then
          begin
            up:=false;
            button2.MoveTo(button2.Position.X-134, 210);
            rct2.MoveTo(button2.Position.X-15, 247);
          end
        end;
      end;
      
      if f1 = false then
      begin
        if (right) then
        begin
          if (button.Position.X <> 319) then
          begin
            right:=false;
            button.MoveTo(button.Position.X+134, 210);
            rct1.MoveTo(button.Position.X-15, 247);
          end;
        end
        else if (left) then
        begin
          if (button.Position.X <> 51) then
          begin
            left:=false;
            button.MoveTo(button.Position.X-134, 210);
            rct1.MoveTo(button.Position.X-15, 247);
          end
        end;
      end;
      
    end;
  end;
end;

///Рисует окно для выбора карты
procedure drawChoiceMap;
var
  rct:PictureABC;
begin
  space:=false;
  enter:=false;
  Window.Fill('assets\interface\menu\choiceMap.png');
  
  button:= new PictureABC(165,180,'assets\interface\menu\choice.png');//(180,330)165,326,487,648 (161)
  button.Scale(1.2);
  rct:= new PictureABC(button.Position.X-35,button.Position.Y-70,'assets\interface\menu\frame.png');
  rct.Scale(1.4);
  
  while true do
  begin
    
    onKeyDown:=keyDownMenu;
    onKeyUp:=keyUpMenu;
    
    if space then
    begin
      if button.Position.Y = 180 then
      begin
        case button.Position.X of
          165: mapName:='map1';
          326: mapName:='map2';
          487: mapName:='map3';
          648: mapName:='map4';
        end;
      end
      else if button.Position.Y = 330 then
      begin
        case button.Position.X of
          165: mapName:='map5';
          326: mapName:='map6';
          487: mapName:='map7';
          648: mapName:='map8';
        end;
      end;
      rct.Destroy;
      button.Destroy;
      break;
    end;
    
    if (up) and (button.Position.X <> 180) then
    begin
      up:=false;
      button.MoveTo(button.Position.X, 180);
      rct.MoveTo(button.Position.X-35,button.Position.Y-70);
    end
    else if (down) and (button.Position.X <> 330) then
    begin
      down:=false;
      button.MoveTo(button.Position.X, 330);
      rct.MoveTo(button.Position.X-35,button.Position.Y-70);
    end
    else if (right) and (button.Position.X <> 648) then
    begin
      right:=false;
      button.MoveTo(button.Position.X+161, button.Position.Y);
      rct.MoveTo(button.Position.X-35,button.Position.Y-70);
    end
    else if (left) and (button.Position.X <> 165) then
    begin
      left:=false;
      button.MoveTo(button.Position.X-161, button.Position.Y);
      rct.MoveTo(button.Position.X-35,button.Position.Y-70);
    end
    
  end;
end;
///Рисует главное меню
procedure drawMenu;
var
  t1,t2,t3,t4: TextABC;
begin
  
  Window.Fill('assets\interface\menu\menu.png');
  
  t1:=TextABC.Create(120,150,20,'Играть',Color.Black);
  t2:=TextABC.Create(120,190,20,'2 Игрока',Color.Black);
  t3:=TextABC.Create(120,230,20,'Обучение',Color.Black);
  t4:=TextABC.Create(120,270,20,'Об авторе',Color.Black);
  
  button:= new PictureABC(85,135,'assets\interface\menu\choice.png');

  while true do
  begin
    //Переход между страницами    
    if space then
    begin
      case button.Position.Y of
        135:path:='1 player';
        175:path:='2 player';
        215: path:='tutorial';
        255: path:='about';
      end;
      button.Destroy;
      t1.Destroy;
      t2.Destroy;
      t3.Destroy;
      t4.Destroy;
      space:=false;
      menuInterfaceHandler;
      break;
    end;
    
    //Управление
    if up then
    begin
      button.MoveTo(85, button.Position.Y - 40);
      up:=false;
    end
    else if down then
    begin
      button.MoveTo(85, button.Position.Y + 40);
      down:=false;
    end;
    OnKeyDown:= keyDownMenu;
    OnKeyUp:= keyUpMenu;
    
    if (button.Position.Y = t1.Position.Y-15) then
    begin
      t1.MoveTo(140,t1.Position.Y);
      t1.Color:=Color.AntiqueWhite;
    end
    else
    begin
      t1.MoveTo(120,t1.Position.Y);
      t1.Color:=Color.Black;
    end;
    
    if (button.Position.Y = t2.Position.Y-15) then
    begin
      t2.MoveTo(140,t2.Position.Y);
      t2.Color:=Color.AntiqueWhite;
    end
    else
    begin
      t2.MoveTo(120,t2.Position.Y);
      t2.Color:=Color.Black;
    end;
    
    if (button.Position.Y = t3.Position.Y-15) then
    begin
      t3.MoveTo(140,t3.Position.Y);
      t3.Color:=Color.AntiqueWhite;
    end
    else
    begin
      t3.MoveTo(120,t3.Position.Y);
      t3.Color:=Color.Black;
    end;
    
    if (button.Position.Y = t4.Position.Y-15) then
    begin
      t4.MoveTo(140,t4.Position.Y);
      t4.Color:=Color.AntiqueWhite;
    end
    else
    begin
      t4.MoveTo(120,t4.Position.Y);
      t4.Color:=Color.Black;
    end;
    
  end;
  
  t1.Destroy;
  t2.Destroy;
  t3.Destroy;
  t4.Destroy;
//  t5.Destroy;
 // t6.Destroy;
  button.Destroy;
  
end;

///Обработка событий в меню
procedure menuInterfaceHandler;
begin
  Window.Clear;
  case path of
    'menu':drawMenu;
    'tutorial': drawTutorial;
    'about': drawAbout;
    '1 player': drawChoiceChr;
    '2 player': drawChoiceChr;
    'maps': drawChoiceMap;
  end
end;

///Отрисовка игрового интерфейса
procedure drawGameInterface;
begin
 
  timeBoard:= new PictureABC(380,5,'assets\interface\game\timeBoard.png');
  param1:= new PictureABC(10,10,'assets\interface\game\hp.png');
  param2:= new PictureABC(590,10,'assets\interface\game\hp.png');
  param2.FlipHorizontal;
  
  hp2X:=606;
  pwr2X:=646;
  stm2X:=646;

  hp1:= new RectangleABC(76,19,221,21,Color.Red);
  hp2:= new RectangleABC(hp2X,19,221,21,Color.Red);
  stm1:= new RectangleABC(76,43,181,11,Color.DeepSkyBlue);
  stm2:= new RectangleABC(pwr2X,43,181,11,Color.DeepSkyBlue);
  pwr1:= new RectangleABC(76,56,181,11,Color.DarkViolet);
  pwr2:= new RectangleABC(pwr2X,56,181,11,Color.DarkViolet);
  
  
  PictureABC.Create(23,19,'assets\interface\game\'+p1.name+'icon.png');
  PictureABC.Create(830,19,'assets\interface\game\'+p2.name+'icon.png');
  
end;

procedure recoveryStamina();
begin  
  if stm1.Width < 181 then
    stm1.Width+=1;
  if stm2.Width < 181 then
  begin
    stm2.Width+=1;
    stm2X -= 1;
    stm2.MoveTo(stm2X, 43);
  end;
end;

///Обработчик игрового интерфейса
procedure gameInterfaceHandler;
begin
  //Health
  if ((p1.sprite.StateName = 'hurtR')or(p1.sprite.StateName = 'hurtL')) and (p1.sprite.Frame = p1.sprite.FrameCount-1) then
  begin 
    if pwr1.Width < 180 then
      pwr1.Width += 30;
    
    p1.sprite.NextFrame;
    if hp1.Width < p2.damage then
      hp1.Width := 1
    else
      hp1.Width-=p2.damage;
  end
  else if ((p2.sprite.StateName = 'hurtR')or(p2.sprite.StateName = 'hurtL')) and (p2.sprite.Frame = p2.sprite.FrameCount-1) then
  begin
    if pwr2.Width < 180 then
    begin
      pwr2.Width += 30;
      pwr2X-=30;
      pwr2.MoveTo(pwr2X,56);
    end;
    p2.sprite.NextFrame;
    if hp2.Width < p1.damage then
      hp2.Width:=1
    else
    begin
      hp2.Width-=p1.damage;
      hp2X+=p1.damage;
      hp2.MoveTo(hp2X,19);
    end;
  end;
  
  //Stamina
  if (p1.sprite.StateName = 'atack' + p1.direction) and (p1.sprite.Frame = p1.sprite.FrameCount div 2) then
  begin
    p1.sprite.NextFrame;
    stm1.Width-=p1.endurance;
  end
  else if (p2.sprite.StateName = 'atack' + p2.direction) and (p2.sprite.Frame = p2.sprite.FrameCount div 2) then
  begin
    p2.sprite.NextFrame;
    stm2.Width-=p2.endurance;
    stm2X+=p2.endurance;
    stm2.MoveTo(stm2X,43);
  end;
  
  if (stm1.Width < 181) or (stm2.Width < 181) then
    stmTimer.Start
  else
    stmTimer.Stop;
  
  //Ultra atack
  if (p1.sprite.StateName = 'atackExtra' + p1.direction) and (p1.sprite.Frame = p1.sprite.FrameCount div 2) then
  begin
    p1.sprite.NextFrame;
    pwr1.Width-=180;
  end
  else if (p2.sprite.StateName = 'atackExtra' + p2.direction) and (p2.sprite.Frame = p2.sprite.FrameCount div 2) then
  begin
    p2.sprite.NextFrame;
    pwr2.Width-=180;
    pwr2X+=180;
    pwr2.MoveTo(pwr2X,56);
  end;
  
end;
begin
  
  path:='menu';
  stmTimer:= new Timer(30, recoveryStamina);
  
end.