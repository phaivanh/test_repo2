inherited FrmSettings: TFrmSettings
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 332
  ClientWidth = 736
  OnActivate = FormActivate
  ExplicitWidth = 742
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 274
    Width = 736
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    Color = 16744448
    ParentBackground = False
    TabOrder = 0
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 658
      Top = 8
      Width = 75
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOK: TButton
      AlignWithMargins = True
      Left = 577
      Top = 8
      Width = 75
      Height = 23
      Margins.Top = 8
      Margins.Bottom = 8
      Align = alRight
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOKClick
    end
    object stat1: TStatusBar
      Left = 0
      Top = 39
      Width = 736
      Height = 19
      Panels = <
        item
          Text = 'aaa'
          Width = 50
        end>
    end
  end
  object AdvOfficePager1: TAdvOfficePager
    Left = 0
    Top = 0
    Width = 736
    Height = 274
    AdvOfficePagerStyler = AdvOfficePagerOfficeStyler1
    Align = alClient
    ActivePage = tabConfig
    ButtonSettings.CloseButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001000001010100000100
      0000000202000100020200000000000202020002020200000000010002020202
      0200010000000101000202020001010000000100020202020200010000000002
      0202000202020000000000020200010002020000000001000001010100000100
      0000}
    ButtonSettings.PageListButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000101010100
      0000010101000200010101000000010100020202000101000000010002020202
      0200010000000002020200020202000000000002020001000202000000000100
      0001010100000100000001010101010101010100000001010101010101010100
      0000}
    ButtonSettings.ScrollButtonPrevPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000001010100
      0000010101000202000101000000010100020202000101000000010002020200
      0101010000000002020200010101010000000100020202000101010000000101
      0002020200010100000001010100020200010100000001010101000001010100
      0000}
    ButtonSettings.ScrollButtonNextPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010000010101010100
      0000010002020001010101000000010002020200010101000000010100020202
      0001010000000101010002020200010000000101000202020001010000000100
      0202020001010100000001000202000101010100000001010000010101010100
      0000}
    ButtonSettings.ScrollButtonFirstPicture.Data = {
      424DC60400000000000036040000280000001000000009000000010008000000
      000000000000C40E0000C40E00000001000000010000427B84FFDEEFEFFFFFFF
      FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF01010101010000010101
      0101000001010101010100020200010101000202000101010100020202000101
      0002020200010101000202020001010002020200010101000202020001010002
      0202000101010101000202020001010002020200010101010100020202000101
      0002020200010101010100020200010101000202000101010101010000010101
      010100000101}
    ButtonSettings.ScrollButtonLastPicture.Data = {
      424DC60400000000000036040000280000001000000009000000010008000000
      000000000000C40E0000C40E00000001000000010000427B84FFDEEFEFFFFFFF
      FFFF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF0000
      00FF000000FF000000FF000000FF000000FF000000FF01010000010101010100
      0001010101010100020200010101000202000101010101000202020001010002
      0202000101010101000202020001010002020200010101010100020202000101
      0002020200010101000202020001010002020200010101000202020001010002
      0202000101010100020200010101000202000101010101010000010101010100
      000101010101}
    ButtonSettings.ClosedListButtonPicture.Data = {
      424DA20400000000000036040000280000000900000009000000010008000000
      00006C000000C30E0000C30E00000001000000010000427B8400DEEFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0001010101000101010100
      0000010101000200010101000000010100020202000101000000010002020202
      0200010000000002020200020202000000000002020001000202000000000100
      0001010100000100000001010101010101010100000001010101010101010100
      0000}
    ButtonSettings.CloseButtonHint = 'Close'
    ButtonSettings.InsertButtonHint = 'Insert new page'
    ButtonSettings.PageListButtonHint = 'Page List'
    ButtonSettings.ScrollButtonNextHint = 'Next'
    ButtonSettings.ScrollButtonPrevHint = 'Previous'
    ButtonSettings.ScrollButtonFirstHint = 'First'
    ButtonSettings.ScrollButtonLastHint = 'Last'
    ButtonSettings.ClosedListButtonHint = 'Closed Pages'
    DoubleBuffered = True
    TabSettings.Rounding = 0
    Text = ''
    ShowShortCutHints = False
    TabOrder = 2
    NextPictureChanged = False
    PrevPictureChanged = False
    object tabExportMatiere: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 734
      Height = 246
      Caption = 'Export mati'#232're'
      DoubleBuffered = True
      PageAppearance.BorderColor = 13027014
      PageAppearance.Color = 16448250
      PageAppearance.ColorTo = 16448250
      PageAppearance.ColorMirror = 16448250
      PageAppearance.ColorMirrorTo = 16448250
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      TabVisible = False
      Text = ''
      TabAppearance.BorderColor = 13027014
      TabAppearance.BorderColorHot = clNone
      TabAppearance.BorderColorSelected = 13027014
      TabAppearance.BorderColorSelectedHot = 13027014
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = 13027014
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 16448250
      TabAppearance.ColorSelectedTo = clNone
      TabAppearance.ColorDisabled = 15658734
      TabAppearance.ColorDisabledTo = clNone
      TabAppearance.ColorHot = 16448250
      TabAppearance.ColorHotTo = clNone
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 16448250
      TabAppearance.ColorMirrorHotTo = clNone
      TabAppearance.ColorMirrorSelected = 16448250
      TabAppearance.ColorMirrorSelectedTo = clNone
      TabAppearance.ColorMirrorDisabled = 15658734
      TabAppearance.ColorMirrorDisabledTo = clNone
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggVertical
      TabAppearance.GradientMirrorHot = ggVertical
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clBlack
      TabAppearance.TextColorHot = clBlack
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clNone
      TabAppearance.HighLightColor = clNone
      TabAppearance.HighLightColorHot = clNone
      TabAppearance.HighLightColorSelected = clNone
      TabAppearance.HighLightColorSelectedHot = clNone
      TabAppearance.HighLightColorDown = clNone
      TabAppearance.BackGround.Color = 16185078
      TabAppearance.BackGround.ColorTo = clNone
      TabAppearance.BackGround.Direction = gdHorizontal
    end
    object tabConfig: TAdvOfficePage
      Left = 1
      Top = 26
      Width = 734
      Height = 246
      Caption = 'Configuration'
      DoubleBuffered = True
      PageAppearance.BorderColor = 13027014
      PageAppearance.Color = 16448250
      PageAppearance.ColorTo = 16448250
      PageAppearance.ColorMirror = 16448250
      PageAppearance.ColorMirrorTo = 16448250
      PageAppearance.Gradient = ggVertical
      PageAppearance.GradientMirror = ggVertical
      Text = ''
      TabAppearance.BorderColor = 13027014
      TabAppearance.BorderColorHot = clNone
      TabAppearance.BorderColorSelected = 13027014
      TabAppearance.BorderColorSelectedHot = 13027014
      TabAppearance.BorderColorDisabled = clNone
      TabAppearance.BorderColorDown = 13027014
      TabAppearance.Color = clBtnFace
      TabAppearance.ColorTo = clWhite
      TabAppearance.ColorSelected = 16448250
      TabAppearance.ColorSelectedTo = clNone
      TabAppearance.ColorDisabled = 15658734
      TabAppearance.ColorDisabledTo = clNone
      TabAppearance.ColorHot = 16448250
      TabAppearance.ColorHotTo = clNone
      TabAppearance.ColorMirror = clWhite
      TabAppearance.ColorMirrorTo = clWhite
      TabAppearance.ColorMirrorHot = 16448250
      TabAppearance.ColorMirrorHotTo = clNone
      TabAppearance.ColorMirrorSelected = 16448250
      TabAppearance.ColorMirrorSelectedTo = clNone
      TabAppearance.ColorMirrorDisabled = 15658734
      TabAppearance.ColorMirrorDisabledTo = clNone
      TabAppearance.Font.Charset = DEFAULT_CHARSET
      TabAppearance.Font.Color = clWindowText
      TabAppearance.Font.Height = -11
      TabAppearance.Font.Name = 'Tahoma'
      TabAppearance.Font.Style = []
      TabAppearance.Gradient = ggVertical
      TabAppearance.GradientMirror = ggVertical
      TabAppearance.GradientHot = ggVertical
      TabAppearance.GradientMirrorHot = ggVertical
      TabAppearance.GradientSelected = ggVertical
      TabAppearance.GradientMirrorSelected = ggVertical
      TabAppearance.GradientDisabled = ggVertical
      TabAppearance.GradientMirrorDisabled = ggVertical
      TabAppearance.TextColor = clBlack
      TabAppearance.TextColorHot = clBlack
      TabAppearance.TextColorSelected = clBlack
      TabAppearance.TextColorDisabled = clGray
      TabAppearance.ShadowColor = clNone
      TabAppearance.HighLightColor = clNone
      TabAppearance.HighLightColorHot = clNone
      TabAppearance.HighLightColorSelected = clNone
      TabAppearance.HighLightColorSelectedHot = clNone
      TabAppearance.HighLightColorDown = clNone
      TabAppearance.BackGround.Color = 16185078
      TabAppearance.BackGround.ColorTo = clNone
      TabAppearance.BackGround.Direction = gdHorizontal
      object pnlMainConfig: TPanel
        Left = 2
        Top = 2
        Width = 730
        Height = 242
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlConnectionDetail: TPanel
          AlignWithMargins = True
          Left = 10
          Top = 104
          Width = 717
          Height = 111
          Margins.Left = 10
          Margins.Top = 1
          Margins.Bottom = 0
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object pnlHost: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 60
            Width = 715
            Height = 24
            Alignment = taLeftJustify
            BevelOuter = bvNone
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = True
            ParentFont = False
            TabOrder = 0
            object lblHost: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 158
              Height = 14
              AutoSize = False
              Caption = 'Host:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtHost: TEdit
              Left = 162
              Top = 0
              Width = 200
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = edtHostChange
            end
          end
          object pnlPort: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 31
            Width = 715
            Height = 24
            Margins.Top = 0
            Margins.Bottom = 0
            Alignment = taLeftJustify
            BevelOuter = bvNone
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = True
            ParentFont = False
            TabOrder = 1
            object lblPort: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 158
              Height = 14
              AutoSize = False
              Caption = 'TCP/IP Port:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtPort: TEdit
              Left = 163
              Top = 0
              Width = 200
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = edtPortChange
            end
          end
          object pnlCharset: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 87
            Width = 715
            Height = 24
            Margins.Top = 0
            Margins.Bottom = 0
            Alignment = taLeftJustify
            BevelOuter = bvNone
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentColor = True
            ParentFont = False
            TabOrder = 2
            object lblCharset: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 3
              Width = 158
              Height = 14
              AutoSize = False
              Caption = 'CharacterSet:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object cbbCharset: TComboBox
              Left = 163
              Top = 0
              Width = 200
              Height = 21
              Style = csDropDownList
              DropDownCount = 20
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
          object pnl1: TPanel
            AlignWithMargins = True
            Left = 4
            Top = 3
            Width = 715
            Height = 24
            Alignment = taLeftJustify
            BevelOuter = bvNone
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = True
            ParentFont = False
            TabOrder = 3
            object lblDBName: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 4
              Width = 158
              Height = 14
              AutoSize = False
              Caption = 'Database name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtDBName: TEdit
              Left = 162
              Top = 1
              Width = 200
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = edtDBNameChange
            end
          end
        end
        object pnl_section_Employee: TPanel
          Tag = 1
          AlignWithMargins = True
          Left = 3
          Top = 20
          Width = 724
          Height = 24
          Margins.Top = 20
          Margins.Bottom = 0
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BorderWidth = 5
          Caption = 'Employ'#233'e'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentColor = True
          ParentFont = False
          TabOrder = 1
          Visible = False
        end
        object pnlEmployeeDetail: TPanel
          AlignWithMargins = True
          Left = 10
          Top = 45
          Width = 717
          Height = 24
          Margins.Left = 10
          Margins.Top = 1
          Margins.Bottom = 0
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 2
          object pnlEmployeeName: TPanel
            AlignWithMargins = True
            Left = 3
            Top = 0
            Width = 711
            Height = 24
            Margins.Top = 0
            Margins.Bottom = 0
            Align = alTop
            Alignment = taLeftJustify
            BevelOuter = bvNone
            BorderWidth = 2
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentBackground = False
            ParentColor = True
            ParentFont = False
            TabOrder = 0
            object lblEmployeeName: TLabel
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 150
              Height = 14
              Align = alLeft
              AutoSize = False
              Caption = 'Name:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              Visible = False
              ExplicitLeft = 2
              ExplicitTop = 7
            end
            object cbbEmployeeName: TComboBox
              Left = 158
              Top = 2
              Width = 551
              Height = 21
              Align = alClient
              Style = csDropDownList
              DropDownCount = 20
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentColor = True
              ParentFont = False
              TabOrder = 0
              Visible = False
            end
          end
        end
        object pnl17: TPanel
          Tag = 1
          AlignWithMargins = True
          Left = 3
          Top = 79
          Width = 724
          Height = 24
          Margins.Top = 10
          Margins.Bottom = 0
          Align = alTop
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BorderWidth = 5
          Caption = 'Database properties'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentBackground = False
          ParentColor = True
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
  object FolderDialog1: TFolderDialog
    DialogX = 0
    DialogY = 0
    Version = '1.1.4.0'
    Left = 39
    Top = 723
  end
  object AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler
    Style = psOffice2013LightGray
    GlowButtonAppearance.BorderColor = 13027014
    GlowButtonAppearance.BorderColorHot = 15381630
    GlowButtonAppearance.BorderColorDown = 15048022
    GlowButtonAppearance.BorderColorChecked = 16750899
    GlowButtonAppearance.BorderColorDisabled = 11316396
    GlowButtonAppearance.Color = 16185078
    GlowButtonAppearance.ColorTo = clNone
    GlowButtonAppearance.ColorChecked = 16185078
    GlowButtonAppearance.ColorCheckedTo = clNone
    GlowButtonAppearance.ColorDisabled = 15658734
    GlowButtonAppearance.ColorDisabledTo = clNone
    GlowButtonAppearance.ColorDown = 16573128
    GlowButtonAppearance.ColorDownTo = clNone
    GlowButtonAppearance.ColorHot = 16576740
    GlowButtonAppearance.ColorHotTo = clNone
    GlowButtonAppearance.ColorMirror = 16185078
    GlowButtonAppearance.ColorMirrorTo = clNone
    GlowButtonAppearance.ColorMirrorHot = 16576740
    GlowButtonAppearance.ColorMirrorHotTo = clNone
    GlowButtonAppearance.ColorMirrorDown = 16573128
    GlowButtonAppearance.ColorMirrorDownTo = clNone
    GlowButtonAppearance.ColorMirrorChecked = 16185078
    GlowButtonAppearance.ColorMirrorCheckedTo = clNone
    GlowButtonAppearance.ColorMirrorDisabled = 15658734
    GlowButtonAppearance.ColorMirrorDisabledTo = clNone
    GlowButtonAppearance.GradientHot = ggVertical
    GlowButtonAppearance.GradientMirrorHot = ggVertical
    GlowButtonAppearance.GradientDown = ggVertical
    GlowButtonAppearance.GradientMirrorDown = ggVertical
    GlowButtonAppearance.GradientChecked = ggVertical
    MetroColor = clActiveBorder
    PageAppearance.BorderColor = 13027014
    PageAppearance.Color = 16448250
    PageAppearance.ColorTo = 16448250
    PageAppearance.ColorMirror = 16448250
    PageAppearance.ColorMirrorTo = 16448250
    PageAppearance.Gradient = ggVertical
    PageAppearance.GradientMirror = ggVertical
    TabAppearance.BorderColor = 13027014
    TabAppearance.BorderColorHot = clNone
    TabAppearance.BorderColorSelected = 13027014
    TabAppearance.BorderColorSelectedHot = 13027014
    TabAppearance.BorderColorDisabled = clNone
    TabAppearance.BorderColorDown = 13027014
    TabAppearance.Color = clBtnFace
    TabAppearance.ColorTo = clWhite
    TabAppearance.ColorSelected = 16448250
    TabAppearance.ColorSelectedTo = clNone
    TabAppearance.ColorDisabled = 15658734
    TabAppearance.ColorDisabledTo = clNone
    TabAppearance.ColorHot = 16448250
    TabAppearance.ColorHotTo = clNone
    TabAppearance.ColorMirror = clWhite
    TabAppearance.ColorMirrorTo = clWhite
    TabAppearance.ColorMirrorHot = 16448250
    TabAppearance.ColorMirrorHotTo = clNone
    TabAppearance.ColorMirrorSelected = 16448250
    TabAppearance.ColorMirrorSelectedTo = clNone
    TabAppearance.ColorMirrorDisabled = 15658734
    TabAppearance.ColorMirrorDisabledTo = clNone
    TabAppearance.Font.Charset = DEFAULT_CHARSET
    TabAppearance.Font.Color = clWindowText
    TabAppearance.Font.Height = -11
    TabAppearance.Font.Name = 'Tahoma'
    TabAppearance.Font.Style = []
    TabAppearance.Gradient = ggVertical
    TabAppearance.GradientMirror = ggVertical
    TabAppearance.GradientHot = ggVertical
    TabAppearance.GradientMirrorHot = ggVertical
    TabAppearance.GradientSelected = ggVertical
    TabAppearance.GradientMirrorSelected = ggVertical
    TabAppearance.GradientDisabled = ggVertical
    TabAppearance.GradientMirrorDisabled = ggVertical
    TabAppearance.TextColor = clBlack
    TabAppearance.TextColorHot = clBlack
    TabAppearance.TextColorSelected = clBlack
    TabAppearance.TextColorDisabled = clGray
    TabAppearance.ShadowColor = clNone
    TabAppearance.HighLightColor = clNone
    TabAppearance.HighLightColorHot = clNone
    TabAppearance.HighLightColorSelected = clNone
    TabAppearance.HighLightColorSelectedHot = clNone
    TabAppearance.HighLightColorDown = clNone
    TabAppearance.BackGround.Color = 16185078
    TabAppearance.BackGround.ColorTo = clNone
    TabAppearance.BackGround.Direction = gdHorizontal
    TabRounding = 0
    Left = 656
    Top = 640
  end
end
