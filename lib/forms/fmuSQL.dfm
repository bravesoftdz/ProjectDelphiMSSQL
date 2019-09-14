inherited fmSQL: TfmSQL
  ClientHeight = 184
  ClientWidth = 327
  ExplicitWidth = 343
  ExplicitHeight = 223
  PixelsPerInch = 96
  TextHeight = 13
  object gbLoginPassword: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 321
    Height = 81
    Align = alTop
    TabOrder = 0
    object paLogin: TPanel
      Left = 2
      Top = 15
      Width = 317
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object lbLogin: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 125
        Height = 23
        Align = alClient
        Alignment = taRightJustify
        Layout = tlCenter
        ExplicitLeft = 125
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object edLogin: TEdit
        AlignWithMargins = True
        Left = 134
        Top = 3
        Width = 180
        Height = 23
        Align = alRight
        TabOrder = 0
        ExplicitHeight = 21
      end
    end
    object paPassword: TPanel
      Left = 2
      Top = 44
      Width = 317
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object lbPassword: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 125
        Height = 23
        Align = alClient
        Alignment = taRightJustify
        Layout = tlCenter
        ExplicitLeft = 125
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object edPassword: TEdit
        AlignWithMargins = True
        Left = 134
        Top = 3
        Width = 180
        Height = 23
        Align = alRight
        TabOrder = 0
        ExplicitHeight = 21
      end
    end
  end
  object gbServerConnection: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 90
    Width = 321
    Height = 81
    Align = alTop
    TabOrder = 1
    object paServer: TPanel
      Left = 2
      Top = 15
      Width = 317
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object lbServer: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 125
        Height = 23
        Align = alClient
        Alignment = taRightJustify
        Layout = tlCenter
        ExplicitLeft = 125
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object btReloadServers: TSpeedButton
        AlignWithMargins = True
        Left = 291
        Top = 3
        Width = 23
        Height = 23
        Align = alRight
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFA4BE8086AC4E79A53A7BA63D8CB05AB0C593FF00FFFF00
          FFFF00FF7BA63DFF00FFFF00FFFF00FFFF00FFB2C6967BA63E79A53A79A53A79
          A53A79A53A79A53A79A53A83AB4BFF00FFFF00FF7CA73F7BA63DFF00FFFF00FF
          ADC38E79A53A79A53A98B76DC5D1B5FF00FFFF00FFBBCBA58AAE5579A53A7CA6
          3FBECDA979A53A7CA63FFF00FFC4D0B379A53B79A53BB6C89CFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF9AB87079A53A7EA84379A53A79A53AFF00FF8BAF58
          79A53AA6BF82FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF88AE
          5379A53A79A53A79A53AFF00FF79A53A7FA843FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF7BA63D7CA63F79A53A79A53A79A53A79A53A79A53AAFC49179A53A
          9DB974FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7BA63D7AA53B79A5
          3A79A53A79A53A79A53AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF79A53A79A53A79A53A79A53A7CA73F7BA63DFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF94B56679A53AB7C99E79A53A79A53A
          79A53A79A53A79A53A80A9457BA63DFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF7BA63D79A53AFF00FF79A53A79A53A79A53A8EB15CFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF9EBA7679A53A93B464FF00FF79A53A79A53A
          7DA74179A53AA1BC7AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFACC28C79A5
          3A7BA63DFF00FFFF00FF7AA53B7AA53BBECDA97AA53B79A53A8DB05ABDCCA8FF
          00FFFF00FFC1CEAE93B46379A53A79A53AB4C799FF00FFFF00FF7AA53C7BA63E
          FF00FFC2CFAF81A94779A53A79A53A79A53A79A53A79A53A79A53A7DA741B9CA
          A2FF00FFFF00FFFF00FFFF00FF7BA63DFF00FFFF00FFFF00FFAEC38F8CB0597B
          A63E7BA63D8AAE55A9C188FF00FFFF00FFFF00FFFF00FFFF00FF}
        ExplicitLeft = 310
        ExplicitTop = 0
      end
      object cbServers: TComboBox
        AlignWithMargins = True
        Left = 134
        Top = 3
        Width = 151
        Height = 21
        Align = alRight
        TabOrder = 0
      end
    end
    object paDB: TPanel
      Left = 2
      Top = 44
      Width = 317
      Height = 29
      Align = alTop
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 1
      object lbDB: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 125
        Height = 23
        Align = alClient
        Alignment = taRightJustify
        Layout = tlCenter
        ExplicitLeft = 125
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object btReloadDBs: TSpeedButton
        AlignWithMargins = True
        Left = 291
        Top = 3
        Width = 23
        Height = 23
        Align = alRight
        Flat = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C30E0000C30E00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFA4BE8086AC4E79A53A7BA63D8CB05AB0C593FF00FFFF00
          FFFF00FF7BA63DFF00FFFF00FFFF00FFFF00FFB2C6967BA63E79A53A79A53A79
          A53A79A53A79A53A79A53A83AB4BFF00FFFF00FF7CA73F7BA63DFF00FFFF00FF
          ADC38E79A53A79A53A98B76DC5D1B5FF00FFFF00FFBBCBA58AAE5579A53A7CA6
          3FBECDA979A53A7CA63FFF00FFC4D0B379A53B79A53BB6C89CFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF9AB87079A53A7EA84379A53A79A53AFF00FF8BAF58
          79A53AA6BF82FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF88AE
          5379A53A79A53A79A53AFF00FF79A53A7FA843FF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF7BA63D7CA63F79A53A79A53A79A53A79A53A79A53AAFC49179A53A
          9DB974FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7BA63D7AA53B79A5
          3A79A53A79A53A79A53AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF79A53A79A53A79A53A79A53A7CA73F7BA63DFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF94B56679A53AB7C99E79A53A79A53A
          79A53A79A53A79A53A80A9457BA63DFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FF7BA63D79A53AFF00FF79A53A79A53A79A53A8EB15CFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FF9EBA7679A53A93B464FF00FF79A53A79A53A
          7DA74179A53AA1BC7AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFACC28C79A5
          3A7BA63DFF00FFFF00FF7AA53B7AA53BBECDA97AA53B79A53A8DB05ABDCCA8FF
          00FFFF00FFC1CEAE93B46379A53A79A53AB4C799FF00FFFF00FF7AA53C7BA63E
          FF00FFC2CFAF81A94779A53A79A53A79A53A79A53A79A53A79A53A7DA741B9CA
          A2FF00FFFF00FFFF00FFFF00FF7BA63DFF00FFFF00FFFF00FFAEC38F8CB0597B
          A63E7BA63D8AAE55A9C188FF00FFFF00FFFF00FFFF00FFFF00FF}
        ExplicitLeft = 302
      end
      object cbDB: TComboBox
        AlignWithMargins = True
        Left = 134
        Top = 3
        Width = 151
        Height = 21
        Align = alRight
        TabOrder = 0
      end
    end
  end
end
