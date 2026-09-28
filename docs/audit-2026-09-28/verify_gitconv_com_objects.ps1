$ErrorActionPreference = 'Continue'
$usr = 'Администратор'
$cs = 'Srvr="localhost";Ref="GitConv";Usr="' + $usr + '";Pwd="";'
$outFile = 'E:\rep\_verify\gk_verify_objects.txt'
$T = New-Object System.Collections.ArrayList
function Add-L($s) { [void]$T.Add([string]$s) }
function P($o, $n) { $r = $o.GetType().InvokeMember($n, [System.Reflection.BindingFlags]::GetProperty, $null, $o, $null); return ,$r }
function M($o, $n, $a) { if ($null -eq $a) { $a = @() }; $r = $o.GetType().InvokeMember($n, [System.Reflection.BindingFlags]::InvokeMethod, $null, $o, $a); return ,$r }
function Prop($o, $n) { try { return [string](P $o $n) } catch { return '<нет>' } }

$conn = (New-Object -ComObject 'V83.COMConnector').Connect($cs)
Write-Output 'connected OK'

Add-L '=== ОБЪЕКТЫ И ДАННЫЕ БАЗЫ ГИТКОНВЕРТЕРА (COM, только чтение) ==='
Add-L ('Дата: ' + (Get-Date -Format 'dd.MM.yyyy HH:mm:ss'))
Add-L ''

function Dump-Table($catalogName, $fields) {
    Add-L ('--- ' + $catalogName + ' ---')
    try {
        $cats = P $conn 'Catalogs'
        $mgr = P $cats $catalogName
        $sel = M $mgr 'Select' $null
        $i = 0
        while ((M $sel 'Next' $null)[0]) {
            $i = $i + 1
            $line = '[' + $i + ']'
            foreach ($f in $fields) { $line = $line + ' | ' + $f + '=' + (Prop $sel $f) }
            Add-L $line
            if ($i -ge 20) { $rest = 0; while ((M $sel 'Next' $null)[0]) { $rest = $rest + 1 }; Add-L ('... ещё ' + $rest + ' строк (вывод ограничен 20)'); break }
        }
        Add-L ('итого элементов: ' + $i)
    } catch { Add-L ('ОШИБКА: ' + $_.Exception.Message) }
    Add-L ''
}

Dump-Table 'ХранилищаКонфигураций' @('Наименование', 'Адрес', 'ctmИспользоватьGitsync', 'ИспользоватьСерверныеВременныеБазы', 'КластерВременныхБаз', 'ВерсияВGit', 'ПерваяВерсия', 'ПоследняяВерсия', 'ЛокальныйКаталогGit', 'КаталогВыгрузкиВерсий')
Dump-Table 'ноКластеры' @('Наименование', 'АдресСервера', 'ТипСУБД', 'ПрефиксИмениБазы', 'КоличествоВременныхБаз', 'ИспользоватьДляВременныхБаз')
Dump-Table 'ноВременныеБазы' @('Наименование', 'ИмяБазыНаСервере', 'Состояние', 'Хранилище', 'ИмяПользователяХранилища', 'ВерсияХранилища', 'КоличествоИспользований', 'Кластер')
Dump-Table 'ноПользователиХранилища' @('Наименование')
Dump-Table 'ОчередиВыполнения' @('Наименование', 'РегламентноеЗадание', 'Операция')
Dump-Table 'ВерсииХранилища' @('Наименование', 'Хранилище', 'Версия', 'Состояние')
Dump-Table 'КопииХранилищКонфигурации' @('Наименование', 'Хранилище', 'Версия', 'ПутьККопии')

Add-L '--- Регламентные задания (факт в базе) ---'
try {
    $sj = P $conn 'ScheduledJobs'
    $jobs = M $sj 'GetScheduledJobs' $null
    $i = 0
    foreach ($j in $jobs) {
        $i = $i + 1
        $mdj = P $j 'Metadata'
        $sch = P $j 'Schedule'
        $schTxt = ''
        foreach ($sn in @('ДатаНачала', 'ПериодПовтораДней', 'ПериодПовтораВТечСуток', 'ВремяНачала', 'ДеньВМесяце')) {
            $v = Prop $sch $sn
            $schTxt = $schTxt + ' ' + $sn + '=' + $v + ';'
        }
        Add-L ([string](P $mdj 'Name') + ' | Использование=' + (Prop $j 'Use') + ' |' + $schTxt)
    }
    Add-L ('итого записей заданий: ' + $i)
} catch { Add-L ('ОШИБКА заданий: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- Фоновые задания (фильтр gitsync) ---'
try {
    $fj = P $conn 'BackgroundJobs'
    $list = M $fj 'GetBackgroundJobs' $null
    $i = 0
    $found = 0
    foreach ($f in $list) {
        $i = $i + 1
        $nm = Prop $f 'ИмяМетода'
        $key = Prop $f 'Ключ'
        if ($nm.ToLower().Contains('gitsync') -or $key.ToLower().Contains('gitsync')) {
            $found = $found + 1
            Add-L ('ФЗ: метод=' + $nm + ' | ключ=' + $key + ' | состояние=' + (Prop $f 'Состояние'))
        }
    }
    Add-L ('всего в списке фоновых: ' + $i + ' | с gitsync: ' + $found)
} catch { Add-L ('ОШИБКА фоновых: ' + $_.Exception.Message) }
Add-L ''

$text = ($T -join "`r`n")
[System.IO.File]::WriteAllText($outFile, $text, (New-Object System.Text.UTF8Encoding($true)))
Write-Output ('written: ' + $outFile + ' (' + $text.Length + ' chars)')