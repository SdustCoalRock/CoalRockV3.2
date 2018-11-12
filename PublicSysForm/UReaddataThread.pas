unit UReaddataThread;

interface


 uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls,
  Vcl.ComCtrls,uDrawGraphClass;


 type

     TReadDataThread=class(TThread)

      protected
        procedure Execute ;override;

      public
         destructor  Destroy; override;
         constructor  Create(Value:Boolean);
     end;

implementation

{ TReadDataThread }

uses UForm_ContourGraph;

constructor TReadDataThread.Create(Value: Boolean);
begin
   Inherited  Create(Value) ; //继承 创建后 不启动 只有发出Resum才启动
   FreeOnTerminate := True;
end;

destructor TReadDataThread.Destroy;
begin

  inherited;
end;

procedure TReadDataThread.Execute;
begin
  inherited;
   Form_ContourGraph.DrawGzm.ReadThreadBoolean :=true;

   if Form_ContourGraph.DrawGzm.ReadThreadName='ForContour' then  begin
      Form_ContourGraph.DrawGzm.LoadRockPressDataForConTour(1);
     // Form_ContourGraph.RefreshMyCloudChart;
   end;
   Form_ContourGraph.DrawGzm.ReadThreadBoolean :=False;
end;

end.
