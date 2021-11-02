Unit handler;

interface

Uses ABCObjects,heroes,sprites,gameInterface;

procedure fightHandler();
procedure fireHandler();

procedure shootsHandler;
procedure jumpHandler;

implementation

procedure jumpHandler;
begin
  //Player 1
  if (p1.sprite.StateName = 'jump'+p1.direction) then
  begin
    if p1.sprite.Frame = 1 then
      p1.sprite.dy:=-p1.sprite.FrameCount;
    if p1.sprite.Frame < p1.sprite.FrameCount div 2 then
    begin
      p1.sprite.dy+=1;
    end
    else if p1.sprite.Frame = p1.sprite.FrameCount div 2 then
    begin
      p1.sprite.dy:=0;
    end;
    if p1.sprite.Frame >= p1.sprite.FrameCount div 2 then
    begin
      p1.sprite.dy+=1;
    end;
  end;
  
  if (p1.sprite.Frame = p1.sprite.FrameCount-1) and (p1.sprite.Position.Y <> 320) then
  begin
    p1.sprite.dy:=0;
    p1.sprite.MoveTo(p1.sprite.Position.X, 320);
  end;
  //Player 2
  if (p2.sprite.StateName = 'jump'+p2.direction) then
  begin
    if p2.sprite.Frame = 1 then
      p2.sprite.dy:=-p2.sprite.FrameCount;
    if p2.sprite.Frame < p2.sprite.FrameCount div 2 then
    begin
      p2.sprite.dy+=1;
    end
    else if p2.sprite.Frame = p2.sprite.FrameCount div 2 then
    begin
      p2.sprite.dy:=0;
    end;
    if p2.sprite.Frame >= p2.sprite.FrameCount div 2 then
    begin
      p2.sprite.dy+=1;
    end;
  end;
  
  if (p2.sprite.Frame = p2.sprite.FrameCount-1) and (p2.sprite.Position.Y <> 320) then
  begin
    p2.sprite.dy:=0;
    p2.sprite.MoveTo(p2.sprite.Position.X, 320);
  end;
end;

///Обработчик ударов
procedure shootsHandler;
begin
  
  //ExtraAtack
  if (p1.sprite.StateName = 'atackExtra'+p1.direction) and (p1.name <> 'mage') then
  begin
    if p1.name = 'rogue' then
    begin
      if ((p1.sprite.Frame = 2)or(p1.sprite.Frame = p1.sprite.FrameCount-1)) and (p2.sprite.Intersect(p1.sprite)) then
        p2.hurt;
    end
    else
      if (p1.sprite.Frame = p1.sprite.FrameCount-1) and (p2.sprite.Intersect(p1.sprite)) then
        p2.hurt;
  end  
  else if (p2.sprite.StateName = 'atackExtra'+p2.direction) and (p2.name <> 'mage') then
  begin
    if p2.name = 'rogue' then
    begin
       if ((p2.sprite.Frame = 2)or(p2.sprite.Frame = p2.sprite.FrameCount-1)) and (p2.sprite.Intersect(p1.sprite)) then
         p1.hurt;
    end
    else
      if (p2.sprite.Frame = p2.sprite.FrameCount-1) and (p2.sprite.Intersect(p1.sprite)) then
         p1.hurt;
  end;
  
  //Atack
  if (p1.sprite.StateName = 'atack'+p1.direction) and (p1.name <> 'mage') and (p2.sprite.StateName<>'atackExtra'+p2.direction) then
  begin
    if p1.name = 'rogue' then
    begin
      if ((p1.sprite.Frame = 2)or(p1.sprite.Frame = p1.sprite.FrameCount-1)) and (p2.sprite.Intersect(p1.sprite)) and (p2.sprite.StateName <> 'jump'+p2.direction) then
        p2.hurt;
    end
    else
      if (p1.sprite.Frame = p1.sprite.FrameCount-1) and (p2.sprite.Intersect(p1.sprite)) and (p2.sprite.StateName <> 'jump'+p2.direction) then
        p2.hurt;
  end
  else if (p2.sprite.StateName = 'atack'+p2.direction) and (p2.name <> 'mage') and (p1.sprite.StateName<>'atackExtra'+p1.direction) then
  begin
    if p2.name = 'rogue' then
    begin
       if ((p2.sprite.Frame = 2)or(p2.sprite.Frame = p2.sprite.FrameCount-1)) and (p2.sprite.Intersect(p1.sprite)) and (p1.sprite.StateName <> 'jump'+p1.direction) then
         p1.hurt;
    end
    else
      if (p2.sprite.Frame = p2.sprite.FrameCount-1) and (p2.sprite.Intersect(p1.sprite)) and (p1.sprite.StateName <> 'jump'+p1.direction) then
         p1.hurt;
  end;

end;

/// Обработка огня mage
procedure fireHandler;
begin
  
  if (fire.StateName<>'hurt'+p2.direction)and(p1.name='mage') and ((p1.sprite.StateName='atack'+p1.direction)or (p1.sprite.StateName='atackExtra'+p1.direction))and(p1.sprite.Frame=1) then
    fire.StateName:='hurt'+p1.direction
  else if (fire.StateName<>'hurt'+p1.direction)and(p2.name='mage') and ((p2.sprite.StateName='atack'+p2.direction)or (p2.sprite.StateName='atackExtra'+p2.direction))and(p2.sprite.Frame=1) then
    fire.StateName:='hurt'+p2.direction;
  
  if (p1.name='mage') and ((p1.sprite.StateName='atack'+p1.direction)or (p1.sprite.StateName='atackExtra'+p1.direction))and(p1.sprite.Frame=p1.sprite.FrameCount-1) then
  begin
    fire.MoveTo(900,500);
    fire.Destroy;
    
    if (p1.direction = 'R') and (p1.sprite.Frame = p1.sprite.FrameCount-1) then
    begin
      fire:= addFire(p1.sprite.Center.X+20, p1.sprite.Center.Y-10);
      fire.dx:=10;
    end
    else if (p1.direction = 'L') and (p1.sprite.Frame = p1.sprite.FrameCount-1) then
    begin
      fire:= addFire(p1.sprite.Center.X-85, p1.sprite.Center.Y-10);
      fire.dx:=-10;
    end;
    
    if p1.sprite.StateName='atackExtra'+p1.direction then
      fire.StateName:='extraFly'+p1.direction
    else
      fire.StateName:='fly'+p1.direction;
    
    fire.Visible:=true;
  end
  else if (p2.name='mage') and ((p2.sprite.StateName='atack'+p2.direction)or (p2.sprite.StateName='atackExtra'+p2.direction))and(p2.sprite.Frame=p2.sprite.FrameCount-1) then
  begin
    fire.MoveTo(900,500);
    fire.Destroy;
    
    if (p2.direction = 'R') and (p2.sprite.Frame = p2.sprite.FrameCount-1) then
    begin
      fire:= addFire(p2.sprite.Center.X+30, p2.sprite.Center.Y-10);
      fire.dx:=10;
    end
    else if (p2.direction = 'L') and (p2.sprite.Frame = p2.sprite.FrameCount-1) then
    begin
      fire:= addFire(p2.sprite.Center.X-90, p2.sprite.Center.Y-10);
      fire.dx:=-10;
    end;
    
    if p2.sprite.StateName='atackExtra'+p2.direction then
      fire.StateName:='extraFly'+p2.direction
    else
      fire.StateName:='fly'+p2.direction;
    
    fire.Visible:=true;
  end;
  //------------
  if (fire.Intersect(p1.sprite)) and (p2.name = 'mage') then
  begin
    if p1.direction = 'R' then
      fire.dx:=-5
    else
      fire.dx:=5;
    
    if fire.StateName='extraFly'+p2.direction then
      fire.StateName:='extraHurt'+p1.direction
    else if fire.StateName='fly'+p2.direction then
      fire.StateName:='hurt'+p1.direction;
    
    if (fire.Frame=fire.FrameCount-3) and (p1.sprite.StateName <> 'jump'+p1.direction) then
      p1.hurt;
    
  end
  else if (fire.Intersect(p2.sprite)) and (p1.name = 'mage') then
  begin
    if p2.direction = 'R' then
      fire.dx:=-5
    else
      fire.dx:=5;
    
    if fire.StateName='extraFly'+p1.direction then
      fire.StateName:='extraHurt'+p2.direction
    else if fire.StateName='fly'+p1.direction then
      fire.StateName:='hurt'+p2.direction;
    
    if (fire.Frame=fire.FrameCount-3) and (p1.sprite.StateName <> 'jump'+p1.direction) then
      p2.hurt;
    
  end;
  
  if (((fire.StateName='hurtR')or(fire.StateName='hurtL'))or((fire.StateName='extraHurtR')or(fire.StateName='extraHurtL'))) and (fire.Frame = fire.FrameCount) then
  begin
    fire.StateName:='hurtR';
    fire.MoveTo(900,500);
    fire.Active:=false;
    fire.Destroy;
  end;
  
  fire.NextTick;
  fire.Move;
  fire.Speed:=8;
  
end;
  
/// Обработка боя
procedure fightHandler;
begin
  
  gameInterfaceHandler;
  fireHandler;
  shootsHandler;
  jumpHandler;
  
end;

end.