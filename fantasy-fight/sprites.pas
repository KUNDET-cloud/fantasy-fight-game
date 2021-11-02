Unit sprites;

interface

Uses ABCSprites;

var
  fire: SpriteABC;

function addSprite(name:string;x,y:integer): SpriteABC;
function addFire(x,y:integer): SpriteABC;

implementation

///Создает спрайт персонажа
function addSprite(name:string;x,y:integer): SpriteABC;
var
  heroSpr:SpriteABC;
begin
  
  heroSpr:= new SpriteABC(x,y,'assets\characters\' + name + '\' + name + '.spinf');
  //Без этого спрайты становятся частично прозрачными
  heroSpr.Transparent:= false;
  
  Result:=heroSpr;
end;

function addFire(x,y:integer): SpriteABC;
var
  f: SpriteABC;
begin
  
  f:= new SpriteABC(x,y,'assets\characters\fire\fire.spinf');
  f.Transparent:= false;
  
  Result:=f;
end;


end.