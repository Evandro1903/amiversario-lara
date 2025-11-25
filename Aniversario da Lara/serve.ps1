# Pequeno servidor HTTP estático em PowerShell
param(
  [int]$Port = 8000
)

$root = Get-Location
$listener = New-Object System.Net.HttpListener
$prefix = "http://localhost:$Port/"
$listener.Prefixes.Add($prefix)
Write-Host "Iniciando servidor estático em $prefix (raiz: $root)"
$listener.Start()
try{
  while ($true) {
    $context = $listener.GetContext()
    $request = $context.Request
    $path = $request.Url.LocalPath.TrimStart('/')
    if ([string]::IsNullOrEmpty($path)) { $path = 'index.html' }
    $file = Join-Path $root $path
    if (Test-Path $file) {
      $bytes = [System.IO.File]::ReadAllBytes($file)
      $context.Response.ContentLength64 = $bytes.Length
      $context.Response.ContentType = switch ([System.IO.Path]::GetExtension($file).ToLower()) {
        '.html' { 'text/html; charset=utf-8' }
        '.css' { 'text/css; charset=utf-8' }
        '.js' { 'application/javascript; charset=utf-8' }
        '.png' { 'image/png' }
        '.jpg' { 'image/jpeg' }
        '.jpeg' { 'image/jpeg' }
        '.svg' { 'image/svg+xml' }
        '.webp' { 'image/webp' }
        '.mp4' { 'video/mp4' }
        default { 'application/octet-stream' }
      }
      $context.Response.OutputStream.Write($bytes,0,$bytes.Length)
    } else {
      $context.Response.StatusCode = 404
      $msg = [System.Text.Encoding]::UTF8.GetBytes("404 - Not Found: $path")
      $context.Response.OutputStream.Write($msg,0,$msg.Length)
    }
    $context.Response.OutputStream.Close()
  }
} finally {
  $listener.Stop()
  $listener.Close()
}
