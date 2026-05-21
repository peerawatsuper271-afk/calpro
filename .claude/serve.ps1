$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$port = 8765
$listener = [System.Net.HttpListener]::new()
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$port/"
try {
  while ($listener.IsListening) {
    $ctx = $listener.GetContext()
    $req = $ctx.Request
    $res = $ctx.Response
    $path = $req.Url.AbsolutePath.TrimStart('/')
    if (-not $path -or $path -eq '') { $path = 'calpro-app.html' }
    $full = Join-Path $root $path
    try {
      if (Test-Path $full -PathType Leaf) {
        $bytes = [System.IO.File]::ReadAllBytes($full)
        $ext = [System.IO.Path]::GetExtension($full).ToLower()
        $mime = switch ($ext) {
          '.html' { 'text/html; charset=utf-8' }
          '.js'   { 'application/javascript; charset=utf-8' }
          '.css'  { 'text/css; charset=utf-8' }
          '.json' { 'application/json; charset=utf-8' }
          '.png'  { 'image/png' }
          '.jpg'  { 'image/jpeg' }
          '.svg'  { 'image/svg+xml' }
          default { 'application/octet-stream' }
        }
        $res.ContentType = $mime
        $res.ContentLength64 = $bytes.Length
        $res.OutputStream.Write($bytes, 0, $bytes.Length)
        $res.OutputStream.Flush()
      } else {
        $res.StatusCode = 404
        $msg = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $path")
        $res.ContentLength64 = $msg.Length
        $res.OutputStream.Write($msg, 0, $msg.Length)
      }
    } catch {
      Write-Host "Request error: $($_.Exception.Message)"
    } finally {
      try { $res.OutputStream.Close() } catch {}
      try { $res.Close() } catch {}
    }
  }
} finally {
  $listener.Stop()
  $listener.Close()
}
