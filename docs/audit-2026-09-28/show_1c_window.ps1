$ErrorActionPreference = 'Continue'
Add-Type -TypeDefinition @"
using System;
using System.Text;
using System.Runtime.InteropServices;
public class WS {
  public delegate bool Cb(IntPtr h, IntPtr l);
  [DllImport("user32.dll")] public static extern bool EnumWindows(Cb cb, IntPtr l);
  [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr h, out uint pid);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] public static extern int GetWindowText(IntPtr h, StringBuilder s, int n);
  [DllImport("user32.dll", CharSet=CharSet.Unicode)] public static extern int GetClassName(IntPtr h, StringBuilder s, int n);
  [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr h);
  [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr h, int cmd);
  [DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr h, int cmd);
  [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr h);
}
"@
$target = [int]$args[0]
$classFilter = if ($args.Count -gt 1) { $args[1] } else { 'V8TopLevelFrameSDI' }

$found = New-Object System.Collections.ArrayList
$cb = [WS+Cb]{
    param($h, $l)
    $pid2 = 0
    [WS]::GetWindowThreadProcessId($h, [ref]$pid2) | Out-Null
    if ($pid2 -eq $target) {
        $cn = New-Object System.Text.StringBuilder 256
        [WS]::GetClassName($h, $cn, 256) | Out-Null
        if ($cn.ToString() -eq $classFilter) {
            $sb = New-Object System.Text.StringBuilder 512
            [WS]::GetWindowText($h, $sb, 512) | Out-Null
            [void]$found.Add([pscustomobject]@{ HWnd = $h; Title = $sb.ToString(); Visible = [WS]::IsWindowVisible($h) })
        }
    }
    return $true
}
[WS]::EnumWindows($cb, [IntPtr]::Zero) | Out-Null

Write-Output ('найдено окон класса ' + $classFilter + ': ' + $found.Count)
foreach ($w in $found) {
    Write-Output ('  hwnd=' + $w.HWnd + ' | было vis=' + $w.Visible + ' | title=[' + $w.Title + ']')
    [WS]::ShowWindow($w.HWnd, 5) | Out-Null      # SW_SHOW
    [WS]::ShowWindowAsync($w.HWnd, 9) | Out-Null # SW_RESTORE
    Start-Sleep -Milliseconds 400
    [WS]::SetForegroundWindow($w.HWnd) | Out-Null
    Start-Sleep -Milliseconds 600
    Write-Output ('  теперь vis=' + [WS]::IsWindowVisible($w.HWnd))
}