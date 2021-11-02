Unit control;

interface

Uses GraphABC,ABCObjects,ABCSprites,heroes, gameInterface,sprites;

var
  p1_jump,p1_left,p1_right,p1_atack,p2_jump,p2_left,p2_right,p2_atack,p1_atackExtra,p2_atackExtra:boolean;//кнопки управления

procedure control_1;
procedure control_2;
procedure botControl(dif: integer);

procedure keyDown(k: integer);
procedure keyUp(k: integer);

procedure spriteLife(state: string);

implementation

procedure botControl();
var
  e,a:integer;
begin

  
  if (abs(p1.sprite.Center.X-p2.sprite.Center.X) <= 100) and (p2.name <> 'mage') then
  begin
    p2_atack:=true;
    p2_atackExtra:=true;
  end
  else if (p2.name <> 'mage') then
    p2_atack:=false;

  if (p2.name = 'mage') and (fire.Active = false) and (stm2.Width >= p2.endurance) then
  begin
    p2_atack:=true;    
  end
  else
    p2_atack:=false;
  
  if (p2.sprite.Center.X < p1.sprite.Center.X) and (p2.name <> 'mage') then
  begin
    p2_left:=false;
    p2_right:=true;
  end
  else if (p2.sprite.Center.X > p1.sprite.Center.X) and (p2.name <> 'mage') then
  begin
    p2_right:=false;
    p2_left:=true;
  end
  else if (p2.name = 'mage') then 
  begin
    if (abs(p2.sprite.Center.X - p1.sprite.Center.X) < 100) and ((900 - p2.sprite.Position.X < 100) or (p2.sprite.Position.X < 100)) then
    begin
      if (p1.direction = 'R') then
      begin
        p2.sprite.MoveTo(p1.sprite.Position.X-10, 320);
      end
      else if (p1.direction = 'L') then
      begin
        p2.sprite.MoveTo(p1.sprite.Position.X+10, 320);
      end;
    end;
    if (abs(p2.sprite.Center.X - p1.sprite.Center.X) < 300) then
    begin
      if (p1.direction = 'R') then
      begin
        p2_left:=false;
        p2_right:=true;
      end
      else if (p1.direction = 'L') then
      begin
        p2_left:=true;
        p2_right:=false;
      end;
    end
    else if (abs(p2.sprite.Center.X - p1.sprite.Center.X) >= 300) then
    begin
      if (p1.direction = 'R') then
      begin
        p2_left:=true;
        p2_right:=false;
      end
      else if (p1.direction = 'L') then
      begin
        p2_left:=false;
        p2_right:=true;
      end;
    end;
  end;
  if (fire.Position.X <> 900) then
  begin
    if (abs(p2.sprite.Center.X-fire.Center.X) < 100) and (p2.name = 'rogue') then
    begin
      a:= random(0,100);
      if a = 50 then
        p2_jump:=true
      else
        p2_jump:=false;
      
      if fire.dx > 0 then
      begin
        p2_left:=false;
        p2_right:=true;
      end
      else if fire.dx < 0 then
      begin
        p2_right:=false;
        p2_left:=true;
      end
      else
      begin
        p2_right:=false;
        p2_left:=false;
      end;
      
    end
    else if (abs(p2.sprite.Center.X-fire.Center.X) < 200) and (p2.name = 'viking') and (fire.StateName <> 'hurt'+p2.direction) then
    begin
      p2_atack:= true;
    end;
  end;
end;

///Обработчик клавиш
procedure keyDown(k: integer);
begin
  case k of
    //Кнопки первого игрока
    VK_W: p1_jump := true;
    VK_A: p1_left := true;
    VK_D: p1_right := true;
    VK_Space: p1_atack := true;
    VK_E: p1_atackExtra := true;
  end;
  
  if botOn = false then
    case k of
      VK_NumPad8: p2_jump := true;
      VK_NumPad4: p2_left := true;
      VK_NumPad6: p2_right := true;
      VK_NumPad0: p2_atack := true;
      VK_NumPad7: p2_atackExtra := true;
    end;
end;

procedure keyUp(k: integer);
begin
  
  case k of
    //First player
    VK_W: p1_jump := false;
    VK_A: p1_left := false;
    VK_D: p1_right := false;
    VK_Space: p1_atack := false;
    VK_E: p1_atackExtra := false;
    //Second player or bot
  end;
  if botOn = false then
    case k of
      VK_NumPad8: p2_jump := false;
      VK_NumPad4: p2_left := false;
      VK_NumPad6: p2_right := false;
      VK_NumPad0: p2_atack := false;
      VK_NumPad7: p2_atackExtra := false;
    end;
end;
//-----------------

///Управление первым игроком
procedure control_1;
begin
  
  if p1.sprite.Center.X > p2.sprite.Center.X then
  begin
    p1.direction:='L';
    p2.direction:='R';
  end
  else if p2.sprite.Center.X > p1.sprite.Center.X then
  begin
    p1.direction:='R';
    p2.direction:='L';
  end;
  
  if p1_atack then
  begin
    if stm1.Width > p2.endurance then
      p1.atack
    else
      p1.stand;
    p1.sprite.dx:=0;
  end
  else if (p1_atackExtra)and(pwr1.Width=181) then
    p1.atackExtra
  else if p1_jump then
    p1.jump
  else if p1_left then
    p1.moveL
  else if p1_right then
    p1.moveR  
  else
    p1.stand;
end;

///Управление вторым игроком
procedure control_2;
begin


  if (p2_atackExtra)and(pwr2.Width=181) then
    p2.atackExtra
  else if p2_atack then
  begin
    if stm2.Width > p2.endurance then
      p2.atack
    else
      p2.stand;
    p2.sprite.dx:=0;
  end
  else if p2_jump then
    p2.jump
  else if p2_left then
    p2.moveL
  else if p2_right then
    p2.moveR  
  else
    p2.stand;
    
  
end;

///процедура доигрывает нужные состояние спрайта до конца
  procedure spriteLife(state:string);
  begin
    if (p1.sprite.StateName <> 'move'+p1.direction) and (p1.sprite.StateName <> 'stand'+p1.direction) and (p2.sprite.StateName <> 'move'+p2.direction) and (p2.sprite.StateName <> 'stand'+p2.direction) then
    begin
      if (p1.sprite.Frame = p1.sprite.FrameCount) then
        control_1;
      if (p2.sprite.Frame = p2.sprite.FrameCount) then
        control_2;
    end
    else if (p1.sprite.StateName = state) and (p1.sprite.Frame <> p1.sprite.FrameCount) and ((p2.sprite.StateName = 'stand'+p2.direction)or(p2.sprite.StateName = 'move'+p2.direction)) then
    begin
      control_2;
    end
    else if (p2.sprite.StateName = state) and (p2.sprite.Frame <> p2.sprite.FrameCount) and ((p1.sprite.StateName = 'stand'+p1.direction)or(p1.sprite.StateName = 'move'+p1.direction)) then
    begin
      control_1;
    end
    else
    begin
      control_1;
      control_2;
    end;
    
  end;

end.