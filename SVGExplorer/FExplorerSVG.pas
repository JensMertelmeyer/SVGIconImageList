unit FExplorerSVG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.ImageList, Vcl.ImgList,
  SVGIconImageList, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.FileCtrl,
  SVGIconImage, Vcl.WinXCtrls, System.Actions, Vcl.ActnList, Vcl.Menus,
  SVGIconImageListBase;

type
  TfmExplorerSVG = class(TForm)
    paDir: TPanel;
    DirSelection: TDirectoryListBox;
    spVertical: TSplitter;
    PaList: TPanel;
    ImageListLabel: TLabel;
    SVGIconImageList: TSVGIconImageList;
    paRicerca: TPanel;
    paPreview: TPanel;
    spRight: TSplitter;
    SVGIconImage: TSVGIconImage;
    ImageView: TListView;
    btDelete: TButton;
    BtRename: TButton;
    DrivePanel: TPanel;
    DriveComboBox: TDriveComboBox;
    StatusBar: TStatusBar;
    SearchBox: TSearchBox;
    PopupMenu: TPopupMenu;
    ActionList: TActionList;
    DeleteAction: TAction;
    RenameAction: TAction;
    Delete1: TMenuItem;
    Rename1: TMenuItem;
    paSVGText: TPanel;
    SVGMemo: TMemo;
    spBottom: TSplitter;
    ShowTextCheckBox: TCheckBox;
    procedure DirSelectionChange(Sender: TObject);
    procedure ImageViewSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure paPreviewResize(Sender: TObject);
    procedure ImageViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SearchBoxInvokeSearch(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SVGIconImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DeleteActionExecute(Sender: TObject);
    procedure RenameActionExecute(Sender: TObject);
    procedure ActionUpdate(Sender: TObject);
    procedure ShowTextCheckBoxClick(Sender: TObject);
  private
    fpaPreviewSize: Integer;
    procedure LoadFilesDir(const APath: string; const AFilter: string = '');
    procedure UpdateStatusBar(Index: Integer);
    procedure SetSVGIconImage(const AIndex: Integer);
  protected
    procedure Loaded; override;
  public
    { Public declarations }
    procedure UpdateListView;
  end;

var
  fmExplorerSVG: TfmExplorerSVG;

implementation

uses
  SVGIconUtils
  , UITypes;

{$R *.dfm}

{ TForm10 }

procedure TfmExplorerSVG.ActionUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := ImageView.Selected <> nil;
end;

procedure TfmExplorerSVG.DeleteActionExecute(Sender: TObject);
var
  LFileName: string;
  LOldImageIndex: Integer;
begin
  LFileName := IncludeTrailingPathDelimiter(DirSelection.Directory)+
    SVGIconImageList.Names[ImageView.Selected.ImageIndex]+'.svg';
  if MessageDlg(Format('Do you really want to delete file "%s"?',[LFileName]),
    mtWarning, [mbNo, mbYes], 0, mbNo) = mrYes then
  begin
    Screen.Cursor := crHourGlass;
    try
      DeleteFile(LFileName);
      LOldImageIndex := ImageView.Selected.ImageIndex;
      SVGIconImageList.Delete(LOldImageIndex);
      LoadFilesDir(DirSelection.Directory, SearchBox.Text);
      if LOldImageIndex < ImageView.Items.Count then
        ImageView.ItemIndex := LOldImageIndex
      else
        ImageView.ItemIndex := LOldImageIndex-1;
      SetSVGIconImage(ImageView.ItemIndex);
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfmExplorerSVG.DirSelectionChange(Sender: TObject);
begin
  SearchBox.Text := '';
  LoadFilesDir(DirSelection.Directory);
end;

procedure TfmExplorerSVG.FormCreate(Sender: TObject);
begin
  Caption := Application.Title;
  fpaPreviewSize := paPreview.Width;
end;

procedure TfmExplorerSVG.FormShow(Sender: TObject);
var
  LPath: string;
begin
  LPath := ParamStr(1);
  if LPath = '' then
    LPath := ExtractFilePath(ParamStr(0));
  DirSelection.Directory := LPath;
end;

procedure TfmExplorerSVG.ImageViewKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DELETE) then btDelete.Click();
end;

procedure TfmExplorerSVG.SetSVGIconImage(const AIndex: Integer);
begin
  if AIndex >= 0 then
  begin
    SVGIconImage.ImageIndex := AIndex;
    SVGIconImage.Repaint;
    SVGMemo.Text := SVGIconImageList.SVGIconItems[AIndex].SVGText;
  end
  else
    SVGMemo.Text := '';
end;

procedure TfmExplorerSVG.ShowTextCheckBoxClick(Sender: TObject);
begin
  paSVGText.Visible := ShowTextCheckBox.Checked;
  spBottom.Visible := paSVGText.Visible;
  spBottom.Top := paSVGText.Top -1;
end;

procedure TfmExplorerSVG.UpdateStatusBar(Index: Integer);
begin
  if Index >= 0 then
  begin
    StatusBar.SimpleText := IncludeTrailingPathDelimiter(DirSelection.Directory)+
      SVGIconImageList.SVGIconItems[Index].IconName+'.svg';
  end
  else
  begin
    StatusBar.SimpleText := DirSelection.Directory;
  end;
  SetSVGIconImage(Index);
end;

procedure TfmExplorerSVG.ImageViewSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  UpdateStatusBar(Item.Index);
end;

procedure TfmExplorerSVG.Loaded;
begin
  Font.Assign(Screen.IconFont);
  inherited;
end;

procedure TfmExplorerSVG.LoadFilesDir(const APath, AFilter: string);
var
  SR: TSearchRec;
  LFiles: TStringList;
  LFilter: string;
begin
  LFiles := TStringList.Create;
  Screen.Cursor := crHourGlass;
  Try
    LFilter := Format('%s*%s*.svg', [IncludeTrailingPathDelimiter(APath), AFilter]);
    if FindFirst(LFilter, faArchive, SR) = 0 then
    begin
      repeat
        LFiles.Add(SR.Name); //Fill the list
      until FindNext(SR) <> 0;
      FindClose(SR);
    end;
    SVGIconImageList.LoadFromFiles(LFiles, False);
    UpdateListView;
    if LFiles.Count > 0 then
    begin
      ImageView.ItemIndex := 0;
      UpdateStatusBar(0);
    end
    else
      UpdateStatusBar(-1);      
  Finally
    LFiles.Free;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfmExplorerSVG.paPreviewResize(Sender: TObject);
begin
  SVGIconImage.Height := SVGIconImage.width;
end;

procedure TfmExplorerSVG.RenameActionExecute(Sender: TObject);
var
  LIndex: Integer;
  LFileName, LPath, LNewFileName: string;
begin
  if ImageView.Selected <> nil then
  begin
    LIndex := ImageView.Selected.ImageIndex;
    LFileName := SVGIconImageList.Names[LIndex];
    LNewFileName := InputBox('Rename icon', 'New filename:', LFileName);
    if (LNewFileName <> '') and (LNewFileName <> LFileName) then
    begin
      LPath := IncludeTrailingPathDelimiter(DirSelection.Directory);
      if FileExists(LPath+LNewFileName+'.svg') then
        raise Exception.CreateFmt('Cannot rename: file "%s" already exists!',
          [LPath+LNewFileName+'.svg'])
      else
        RenameFile(LPath+LFileName+'.svg', LPath+LNewFileName+'.svg');
      SVGIconImageList.Names[LIndex] := LNewFileName;
      UpdateListView;
      UpdateStatusBar(LIndex);
    end;
  end;
end;

procedure TfmExplorerSVG.SearchBoxInvokeSearch(Sender: TObject);
begin
  LoadFilesDir(DirSelection.Directory, SearchBox.Text) ;
end;

procedure TfmExplorerSVG.SVGIconImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and (paPreview.Width * 1.5 < paList.Width) then
    paPreview.Width := Round(paPreview.Width * 1.5)
  else if (Button = mbRight) and (paPreview.Width / 1.5 > fpaPreviewSize) then
    paPreview.Width := Round(paPreview.Width / 1.5);      
end;

procedure TfmExplorerSVG.UpdateListView;
var
  LItemsCount: Integer;
begin
  LItemsCount := UpdateSVGIconListView(ImageView, False);
  ImageListLabel.Caption := Format('SVG Image List Preview: %d icons',[LItemsCount]);
end;

end.
