Add-Type -AssemblyName System.Drawing

function New-Icon($size, $path, $padding) {
  $bmp = New-Object System.Drawing.Bitmap($size, $size)
  $g = [System.Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
  $g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAlias

  $rect = New-Object System.Drawing.Rectangle(0, 0, $size, $size)
  $c1 = [System.Drawing.Color]::FromArgb(255, 0xff, 0x6b, 0x6b)
  $c2 = [System.Drawing.Color]::FromArgb(255, 0xff, 0xa9, 0x4d)
  $brush = New-Object System.Drawing.Drawing2D.LinearGradientBrush($rect, $c1, $c2, 135)
  $g.FillRectangle($brush, $rect)
  $brush.Dispose()

  $inset = [int]($size * $padding)
  $iconArea = $size - ($inset * 2)
  $fontSize = [int]($iconArea * 0.42)
  $font = New-Object System.Drawing.Font('Segoe UI', $fontSize, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Pixel)
  $textBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::White)
  $fmt = New-Object System.Drawing.StringFormat
  $fmt.Alignment = [System.Drawing.StringAlignment]::Center
  $fmt.LineAlignment = [System.Drawing.StringAlignment]::Center
  $textRect = New-Object System.Drawing.RectangleF($inset, $inset, $iconArea, $iconArea)
  $g.DrawString('CP', $font, $textBrush, $textRect, $fmt)
  $font.Dispose()
  $textBrush.Dispose()

  $emojiFontSize = [int]($iconArea * 0.22)
  try {
    $emojiFont = New-Object System.Drawing.Font('Segoe UI Emoji', $emojiFontSize, [System.Drawing.FontStyle]::Regular, [System.Drawing.GraphicsUnit]::Pixel)
    $emojiBrush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::FromArgb(180, 255, 255, 255))
    $emojiRect = New-Object System.Drawing.RectangleF($inset, ($size - $inset - $emojiFontSize - [int]($iconArea * 0.05)), $iconArea, $emojiFontSize)
    $g.DrawString([char]::ConvertFromUtf32(0x1F525), $emojiFont, $emojiBrush, $emojiRect, $fmt)
    $emojiFont.Dispose()
    $emojiBrush.Dispose()
  } catch {}

  $g.Dispose()
  $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
  $bmp.Dispose()
  Write-Host "Created: $path ($size x $size)"
}

$root = Split-Path $PSScriptRoot -Parent

New-Icon 192 (Join-Path $root 'icon-192.png') 0.10
New-Icon 512 (Join-Path $root 'icon-512.png') 0.10
New-Icon 512 (Join-Path $root 'icon-maskable-512.png') 0.20
New-Icon 180 (Join-Path $root 'apple-touch-icon.png') 0.10
New-Icon 32 (Join-Path $root 'favicon-32.png') 0.05

Write-Host "All icons generated."
