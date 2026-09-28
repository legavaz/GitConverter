$ErrorActionPreference = 'Continue'
$usr = 'Администратор'
$cs = 'Srvr="localhost";Ref="GitConv";Usr="' + $usr + '";Pwd="";'
$outFile = 'E:\rep\_verify\gk_verify_data.txt'
$T = New-Object System.Collections.ArrayList
function Add-L($s) { [void]$T.Add([string]$s) }

function P($o, $n) {
    $r = $o.GetType().InvokeMember($n, [System.Reflection.BindingFlags]::GetProperty, $null, $o, $null)
    return ,$r
}
function M($o, $n, $a) {
    if ($null -eq $a) { $a = @() }
    $r = $o.GetType().InvokeMember($n, [System.Reflection.BindingFlags]::InvokeMethod, $null, $o, $a)
    return ,$r
}
function Has($o, $n) { try { $v = P $o $n; return ($null -ne $v) } catch { return $false } }
function Prop($o, $n) { try { return [string](P $o $n) } catch { return '<нет свойства ' + $n + '>' } }

$conn = (New-Object -ComObject 'V83.COMConnector').Connect($cs)
Write-Output 'connected OK'

Add-L '=== ВЕРИФИКАЦИЯ БАЗЫ ГИТКОНВЕРТЕРА (COM, только чтение) ==='
Add-L ('Дата: ' + (Get-Date -Format 'dd.MM.yyyy HH:mm:ss'))
Add-L ''

Add-L '--- 1. Наличие объектов в метаданных ---'
try {
    $md = P $conn 'Metadata'
    $mdConsts = P $md 'Constants'
    foreach ($n in @('ctmПутьКОнеСкриптНаСервере', 'ctmПутьКПлагинамGitsync', 'ctmБазаGitsyncНаСервере', 'ПутьКОнеСкриптНаСервере', 'БазаGitsyncНаСервере', 'ИмяБазыGitsyncНаСервере')) {
        Add-L ('Constant ' + $n + ' : ' + (Has $mdConsts $n))
    }
    $mdJobs = P $md 'ScheduledJobs'
    foreach ($n in @('ctmКонвертацияХранилищаGitsync', 'КонвертацияХранилищаGitsync', 'КонвертацияХранилища', 'ОбработкаОчереди', 'ВыгрузкаВерсииИзКопииХранилища')) {
        Add-L ('ScheduledJob ' + $n + ' : ' + (Has $mdJobs $n))
    }
    $mdCats = P $md 'Catalogs'
    $mdCat = P $mdCats 'ХранилищаКонфигураций'
    $mdAttrs = P $mdCat 'Attributes'
    foreach ($n in @('ctmИспользоватьGitsync', 'ctmИмяРасширения', 'Адрес', 'ВерсияВGit')) {
        Add-L ('Реквизит ХранилищаКонфигураций.' + $n + ' : ' + (Has $mdAttrs $n))
    }
} catch { Add-L ('ОШИБКА блока 1: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 2. Значения констант ---'
try {
    $consts = P $conn 'Constants'
    foreach ($n in @('ctmПутьКОнеСкриптНаСервере', 'ctmПутьКПлагинамGitsync', 'ctmБазаGitsyncНаСервере', 'ПутьКВерсиямПлатформыНаСервере', 'ИспользоватьОчередиВыполнения')) {
        try {
            $cv = P $consts $n
            $val = M $cv 'Get' $null
            Add-L ($n + ' = [' + [string]$val + ']')
        } catch { Add-L ($n + ' : ОШИБКА ' + $_.Exception.Message) }
    }
} catch { Add-L ('ОШИБКА блока 2: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 3. Справочник.ХранилищаКонфигураций ---'
try {
    $cats = P $conn 'Catalogs'
    $hrm = P $cats 'ХранилищаКонфигураций'
    $sel = M $hrm 'Select' $null
    $i = 0
    while ((M $sel 'Next' $null)[0]) {
        $i = $i + 1
        $row = M $sel 'GetCurrentRow' $null
        if ($null -eq $row -or $row -is [System.Object[]]) { $row = $sel }
        Add-L ('[' + $i + '] ' + [string](P $row 'Name') + ' | Адрес=' + (Prop $row 'Адрес') + ' | ctmИспользоватьGitsync=' + (Prop $row 'ctmИспользоватьGitsync'))
        Add-L ('      серверные.базы=' + (Prop $row 'ИспользоватьСерверныеВременныеБазы') + ' | кластер=' + (Prop $row 'КластерВременныхБаз'))
        Add-L ('      ВерсияВGit=' + (Prop $row 'ВерсияВGit') + ' | диапазон=' + (Prop $row 'ПерваяВерсия') + '..' + (Prop $row 'ПоследняяВерсия'))
        Add-L ('      git=' + (Prop $row 'ЛокальныйКаталогGit') + ' | выгрузка=' + (Prop $row 'КаталогВыгрузкиВерсий'))
    }
    Add-L ('итого элементов: ' + $i)
} catch { Add-L ('ОШИБКА блока 3: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 4. Справочник.ноКластеры ---'
try {
    $cats = P $conn 'Catalogs'
    $km = P $cats 'ноКластеры'
    $sel = M $km 'Select' $null
    $i = 0
    while ((M $sel 'Next' $null)[0]) {
        $i = $i + 1
        $row = $sel
        Add-L ('[' + $i + '] ' + [string](P $row 'Name') + ' | сервер=' + (Prop $row 'АдресСервера') + ' | СУБД=' + (Prop $row 'ТипСУБД') + ' | префикс=' + (Prop $row 'ПрефиксИмениБазы'))
    }
    Add-L ('итого кластеров: ' + $i)
} catch { Add-L ('ОШИБКА блока 4: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 5. Справочник.ноВременныеБазы ---'
try {
    $cats = P $conn 'Catalogs'
    $vbm = P $cats 'ноВременныеБазы'
    $sel = M $vbm 'Select' $null
    $i = 0
    while ((M $sel 'Next' $null)[0]) {
        $i = $i + 1
        $row = $sel
        Add-L ('[' + $i + '] ' + [string](P $row 'Name') + ' | база=' + (Prop $row 'ИмяБазыНаСервере') + ' | состояние=' + (Prop $row 'Состояние'))
        Add-L ('      хранилище=' + (Prop $row 'Хранилище') + ' | пользователь=' + (Prop $row 'ИмяПользователяХранилища') + ' | версия=' + (Prop $row 'ВерсияХранилища') + ' | исп=' + (Prop $row 'КоличествоИспользований'))
    }
    Add-L ('итого временных баз: ' + $i)
} catch { Add-L ('ОШИБКА блока 5: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 6. Регламентные задания (факт в базе) ---'
try {
    $sj = P $conn 'ScheduledJobs'
    $jobs = M $sj 'GetScheduledJobs' $null
    $i = 0
    foreach ($j in $jobs) {
        $i = $i + 1
        $mdj = P $j 'Metadata'
        Add-L ([string](P $mdj 'Name') + ' | Использование=' + (Prop $j 'Use') + ' | Расписание=' + (Prop $j 'Schedule'))
    }
    Add-L ('итого записей заданий: ' + $i)
} catch { Add-L ('ОШИБКА блока 6: ' + $_.Exception.Message) }
Add-L ''

Add-L '--- 7. Фоновые задания (фильтр gitsync) ---'
try {
    $fj = P $conn 'BackgroundJobs'
    $list = M $fj 'GetBackgroundJobs' $null
    $i = 0
    $found = 0
    foreach ($f in $list) {
        $i = $i + 1
        $nm = Prop $f 'MethodName'
        $key = Prop $f 'Key'
        if ($nm.ToLower().Contains('gitsync') -or $key.ToLower().Contains('gitsync')) {
            $found = $found + 1
            Add-L ('ФЗ: метод=' + $nm + ' | ключ=' + $key + ' | состояние=' + (Prop $f 'State') + ' | начало=' + (Prop $f 'Start'))
        }
    }
    Add-L ('всего в списке: ' + $i + ' | с gitsync: ' + $found)
} catch { Add-L ('ОШИБКА блока 7: ' + $_.Exception.Message) }

$text = ($T -join "`r`n")
[System.IO.File]::WriteAllText($outFile, $text, (New-Object System.Text.UTF8Encoding($true)))
Write-Output ('written: ' + $outFile + ' (' + $text.Length + ' chars)')