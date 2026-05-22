Add-Type -AssemblyName System.Drawing

function New-Icon($size, $path, $padding) {
  $bmp = New-Object System.Drawing.Bitmap($size, $size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

  # Background: dark base with subtle red glow from bottom-right
  $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
  $c1 = [System.Drawing.Color]::FromArgb(255, 0x14, 0x14, 0x1c)  # near-black
  $c2 = [System.Drawing.Color]::FromArgb(255, 0x35, 0x14, 0x18)  # dark red tint
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $c1, $c2, 135)
  $g.FillRectangle($brush, $rect)
  $brush.Dispose()

  # Layout text "Cal" (white) + "Pro+" (red) — single line, centered
  $inset = [int]($size * $padding)
  $iconArea = $size - ($inset * 2)
  # Pick font size so "CalPro+" fits horizontally with some breathing room
  $fontSize = [int]($iconArea * 0.30)
  $fontFamily = 'Segoe UI'
  $fontStyle = [System.Drawing.FontStyle]::Bold
  $font = New-Object System.Drawing.Font($fontFamily, $fontSize, $fontStyle, [System.Drawing.GraphicsUnit]::Pixel)

  # Measure parts so we can position them side-by-side, vertically centered
  $whiteText = 'Cal'
  $redText = 'Pro+'
  $fmt = New-Object System.Drawing.StringFormat
  $fmt.FormatFlags = [System.Drawing.StringFormatFlags]::NoWrap
  $whiteSize = $g.MeasureString($whiteText, $font, [int]($size * 2), $fmt)
  $redSize = $g.MeasureString($redText, $font, [int]($size * 2), $fmt)
  $totalW = $whiteSize.Width + $redSize.Width
  $startX = ($size - $totalW) / 2
  $textY = ($size - $whiteSize.Height) / 2

  $whiteBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
  $redBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(255, 0xff, 0x4d, 0x4d))

  # Draw "Cal" with subtle drop shadow
  $shadowBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(80, 0, 0, 0))
  $g.DrawString($whiteText, $font, $shadowBrush, $startX + 1, $textY + 2)
  $g.DrawString($whiteText, $font, $whiteBrush, $startX, $textY)
  # Draw "Pro+" with red + shadow
  $redX = $startX + $whiteSize.Width
  $g.DrawString($redText, $font, $shadowBrush, $redX + 1, $textY + 2)
  $g.DrawString($redText, $font, $redBrush, $redX, $textY)

  $whiteBrush.Dispose()
  $redBrush.Dispose()
  $shadowBrush.Dispose()
  $font.Dispose()
  $fmt.Dispose()
  $g.Dispose()

  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Host "Created: $path ($size x $size)"
}

$root = Split-Path $PSScriptRoot -Parent

New-Icon 192 (Join-Path $root 'icon-192.png') 0.10
New-Icon 512 (Join-Path $root 'icon-512.png') 0.10
New-Icon 512 (Join-Path $root 'icon-maskable-512.png') 0.22
New-Icon 180 (Join-Path $root 'apple-touch-icon.png') 0.10
New-Icon 32 (Join-Path $root 'favicon-32.png') 0.05

Write-Host "All icons generated with new 'Cal Pro+' design."
