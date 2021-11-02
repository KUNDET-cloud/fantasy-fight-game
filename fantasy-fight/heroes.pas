Unit heroes;

interface  
  
  Uses ABCSprites, sprites;
  
  type Hero = class
    public
      sprite: SpriteABC;
      speed: integer;
      damage:integer;
      endurance:integer;
      direction:char;
      name:string;
      
      procedure moveR;
      begin
        sprite.StateName:='move' + direction;
        sprite.dx:=speed;
      end;
      
      procedure moveL;
      begin
        sprite.StateName:='move' + direction;
        sprite.dx:=-speed;
      end;
      
      procedure stand;
      begin
        sprite.StateName:='stand' + direction;
        sprite.dx:=0;
        sprite.dy:=0;
      end;
      
      procedure hurt;
      begin
        sprite.StateName:= 'hurt'+direction;
        sprite.dx:=0;
      end;
      
      procedure atackExtra;
      begin
        sprite.dx:=0;
        case name of
          'rogue':
          begin
            damage:=20;
            if direction = 'R' then
              sprite.dx:=10
            else
              sprite.dx:=-10;
          end;
          'viking':
          begin
            damage:=80;
            if direction = 'R' then
              sprite.dx:=5
            else
              sprite.dx:=-5;
          end;
          'mage':damage:=80;
        end;
        
        sprite.StateName:='atackExtra'+direction;
      end;
      
      
      procedure atack;
      begin
        case name of
          'rogue': damage:=10;
          'mage': damage:=20;
          'viking': damage:=40;
        end;
        sprite.StateName:='atack'+direction;
        sprite.dx:=0;
      end;
      
      procedure jump;
      begin                
        sprite.StateName:='jump'+direction;
      end;
      
      procedure victory;
      begin                
        sprite.StateName:='victory'+direction;
      end;
      
      procedure death;
      begin                
        sprite.StateName:='death'+direction;
      end;
      
      constructor Create(spr:SpriteABC;s,d,e:integer;dir:char;n:string);
      begin
        sprite:=spr;
        name:=n;
        speed:=s;
        damage:=d;
        endurance:=e;
        direction:=dir;
      end;
  end;
  
  var
    p1,p2: Hero;
  
implementation
  
end.