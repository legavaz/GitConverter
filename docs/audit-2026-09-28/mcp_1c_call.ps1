param(
    [Parameter(Mandatory=$true)][string]$Method,
    [string]$Params = '{}',
    [string]$ParamsFile = '',
    [string]$BaseUrl = 'http://localhost:6003/mcp',
    [string]$OutFile = ''
)
$ErrorActionPreference = 'Stop'
$accept = @{ 'Accept' = 'application/json, text/event-stream' }
if ($ParamsFile -ne '') { $Params = [System.IO.File]::ReadAllText($ParamsFile, [System.Text.Encoding]::UTF8) }

function Parse-Sse($text) {
    $lines = $text -split "`n"
    $data = ($lines | Where-Object { $_ -like 'data: *' } | ForEach-Object { $_ -replace '^data: ', '' }) -join ''
    if ([string]::IsNullOrWhiteSpace($data)) { return $text }
    return $data
}

$initBody = '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"cline-http","version":"1.0"}}}'
$jsonCt = 'application/json; charset=utf-8'
$initResp = Invoke-WebRequest -Uri $BaseUrl -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($initBody)) -ContentType $jsonCt -Headers $accept -TimeoutSec 15 -UseBasicParsing
$sid = $initResp.Headers['mcp-session-id']
if ($sid -is [array]) { $sid = $sid[0] }

$notifyBody = '{"jsonrpc":"2.0","method":"notifications/initialized"}'
try {
    Invoke-WebRequest -Uri $BaseUrl -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($notifyBody)) -ContentType $jsonCt -Headers (@{ 'Accept' = 'application/json, text/event-stream'; 'mcp-session-id' = $sid }) -TimeoutSec 10 -UseBasicParsing | Out-Null
} catch { }

$callBody = '{"jsonrpc":"2.0","id":2,"method":"' + $Method + '","params":' + $Params + '}'
$resp = Invoke-WebRequest -Uri $BaseUrl -Method POST -Body ([System.Text.Encoding]::UTF8.GetBytes($callBody)) -ContentType $jsonCt -Headers (@{ 'Accept' = 'application/json, text/event-stream'; 'mcp-session-id' = $sid }) -TimeoutSec 120 -UseBasicParsing
$rawBytes = $resp.RawContentStream.ToArray()
$rawText = [System.Text.Encoding]::UTF8.GetString($rawBytes)
$text = Parse-Sse $rawText
if ($OutFile -ne '') {
    [System.IO.File]::WriteAllText($OutFile, $text, (New-Object System.Text.UTF8Encoding($false)))
    Write-Output ('written: ' + $OutFile + ' (' + $text.Length + ' символов)')
    # распаковать вложенный text (ответ инструмента) в отдельный файл — читается без искажений
    try {
        $parsed = $text | ConvertFrom-Json
        $inner = $parsed.result.content[0].text
        if ($inner) {
            [System.IO.File]::WriteAllText(($OutFile + '.text.txt'), $inner, (New-Object System.Text.UTF8Encoding($false)))
            Write-Output ('inner text: ' + $OutFile + '.text.txt (' + $inner.Length + ' символов)')
        }
    } catch { }
} else {
    Write-Output $text
}