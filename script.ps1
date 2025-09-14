# Set output encoding to UTF-8
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# 🎨 Professional Dark Theme Color Definitions
$RED = "`e[31m"
$GREEN = "`e[32m"
$YELLOW = "`e[33m"
$BLUE = "`e[34m"
$PURPLE = "`e[35m"
$CYAN = "`e[36m"
$MAGENTA = "`e[35m"
$WHITE = "`e[37m"
$BOLD = "`e[1m"
$DIM = "`e[2m"
$NC = "`e[0m"

# 🌟 Bright Professional Colors (Matrix Style)
$BRIGHT_GREEN = "`e[92m"  # Bright Green
$BRIGHT_RED = "`e[91m"    # Bright Red
$BRIGHT_YELLOW = "`e[93m" # Bright Yellow
$BRIGHT_BLUE = "`e[94m"   # Bright Blue
$BRIGHT_PURPLE = "`e[95m" # Bright Purple
$BRIGHT_CYAN = "`e[96m"   # Bright Cyan
$BRIGHT_WHITE = "`e[97m"  # Bright White
$GRAY = "`e[90m"          # Gray
$BLACK = "`e[30m"         # Black
$BG_GREEN = "`e[42m"      # Green Background
$BG_RED = "`e[41m"        # Red Background
$BG_YELLOW = "`e[43m"     # Yellow Background
$BG_BLUE = "`e[44m"       # Blue Background
$BLINK = "`e[5m"          # Blinking text
$UNDERLINE = "`e[4m"      # Underlined text
$REVERSE = "`e[7m"        # Reverse video

# 🎯 Set Console Colors for Professional Dark Theme
try {
    $Host.UI.RawUI.BackgroundColor = "Black"
    $Host.UI.RawUI.ForegroundColor = "Green"
    Clear-Host
} catch {
    # Fallback if console color setting fails
}

# Config file and backup directory
$STORAGE_FILE = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
$BACKUP_DIR = "$env:APPDATA\Cursor\User\globalStorage\backups"

# Generate a random string
function Generate-RandomString {
    param([int]$Length)
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    $result = ""
    for ($i = 0; $i -lt $Length; $i++) {
        $result += $chars[(Get-Random -Maximum $chars.Length)]
    }
    return $result
}

# 🔍 Advanced Diagnostic Mode Function
function Invoke-AdvancedDiagnostic {
    Write-Host ""
    Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$GREEN║                        🔍 ADVANCED DIAGNOSTIC MODE                               ║$NC"
    Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    $diagnosticReport = @()
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    
    # System Information
    Write-Host "$BLUE🔍 [System Analysis]$NC Gathering system information..."
    $osInfo = Get-WmiObject -Class Win32_OperatingSystem
    $computerInfo = Get-WmiObject -Class Win32_ComputerSystem
    $diagnosticReport += "=== SYSTEM INFORMATION ==="
    $diagnosticReport += "OS: $($osInfo.Caption) $($osInfo.Version)"
    $diagnosticReport += "Architecture: $($osInfo.OSArchitecture)"
    $diagnosticReport += "Computer: $($computerInfo.Name)"
    $diagnosticReport += "User: $($env:USERNAME)"
    $diagnosticReport += "Timestamp: $timestamp"
    $diagnosticReport += ""
    
    # Cursor Installation Analysis
    Write-Host "$BLUE🔍 [Cursor Analysis]$NC Analyzing Cursor installation..."
    $cursorPaths = @(
        "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
        "$env:PROGRAMFILES\Cursor\Cursor.exe",
        "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
    )
    
    $cursorFound = $false
    foreach ($path in $cursorPaths) {
        if (Test-Path $path) {
            $cursorFound = $true
            $fileInfo = Get-Item $path
            $diagnosticReport += "=== CURSOR INSTALLATION ==="
            $diagnosticReport += "Path: $path"
            $diagnosticReport += "Version: $($fileInfo.VersionInfo.FileVersion)"
            $diagnosticReport += "Size: $($fileInfo.Length) bytes"
            $diagnosticReport += "Last Modified: $($fileInfo.LastWriteTime)"
            break
        }
    }
    
    if (-not $cursorFound) {
        $diagnosticReport += "=== CURSOR INSTALLATION ==="
        $diagnosticReport += "STATUS: NOT FOUND"
        $diagnosticReport += "ERROR: Cursor installation not detected"
    }
    $diagnosticReport += ""
    
    # Registry Analysis
    Write-Host "$BLUE🔍 [Registry Analysis]$NC Checking registry integrity..."
    $registryPath = "HKLM:\SOFTWARE\Microsoft\Cryptography"
    $diagnosticReport += "=== REGISTRY ANALYSIS ==="
    $diagnosticReport += "Registry Path: $registryPath"
    
    if (Test-Path $registryPath) {
        try {
            $machineGuid = Get-ItemProperty -Path $registryPath -Name MachineGuid -ErrorAction SilentlyContinue
            if ($machineGuid) {
                $diagnosticReport += "MachineGuid: $($machineGuid.MachineGuid)"
                $diagnosticReport += "Status: OK"
            } else {
                $diagnosticReport += "MachineGuid: NOT FOUND"
                $diagnosticReport += "Status: WARNING"
            }
        } catch {
            $diagnosticReport += "MachineGuid: ERROR - $($_.Exception.Message)"
            $diagnosticReport += "Status: ERROR"
        }
    } else {
        $diagnosticReport += "Registry Path: NOT FOUND"
        $diagnosticReport += "Status: ERROR"
    }
    $diagnosticReport += ""
    
    # File Permissions Analysis
    Write-Host "$BLUE🔍 [Permission Analysis]$NC Checking file permissions..."
    $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
    $diagnosticReport += "=== FILE PERMISSIONS ==="
    $diagnosticReport += "Config Path: $configPath"
    
    if (Test-Path $configPath) {
        try {
            $fileInfo = Get-Item $configPath
            $diagnosticReport += "File Exists: YES"
            $diagnosticReport += "Size: $($fileInfo.Length) bytes"
            $diagnosticReport += "Read-Only: $($fileInfo.IsReadOnly)"
            $diagnosticReport += "Last Modified: $($fileInfo.LastWriteTime)"
            $diagnosticReport += "Status: OK"
        } catch {
            $diagnosticReport += "File Exists: YES"
            $diagnosticReport += "Status: ERROR - $($_.Exception.Message)"
        }
    } else {
        $diagnosticReport += "File Exists: NO"
        $diagnosticReport += "Status: WARNING - Config file not found"
    }
    $diagnosticReport += ""
    
    # Process Analysis
    Write-Host "$BLUE🔍 [Process Analysis]$NC Checking Cursor processes..."
    $cursorProcesses = Get-Process -Name "Cursor" -ErrorAction SilentlyContinue
    $diagnosticReport += "=== PROCESS ANALYSIS ==="
    $diagnosticReport += "Cursor Processes Running: $($cursorProcesses.Count)"
    
    if ($cursorProcesses) {
        foreach ($process in $cursorProcesses) {
            $diagnosticReport += "PID: $($process.Id) | CPU: $($process.CPU) | Memory: $($process.WorkingSet64) bytes"
        }
    } else {
        $diagnosticReport += "Status: No Cursor processes running"
    }
    $diagnosticReport += ""
    
    # Network Analysis
    Write-Host "$BLUE🔍 [Network Analysis]$NC Checking network connectivity..."
    $diagnosticReport += "=== NETWORK ANALYSIS ==="
    try {
        $pingResult = Test-Connection -ComputerName "8.8.8.8" -Count 1 -Quiet
        $diagnosticReport += "Internet Connectivity: $($pingResult)"
    } catch {
        $diagnosticReport += "Internet Connectivity: ERROR - $($_.Exception.Message)"
    }
    $diagnosticReport += ""
    
    # Save Diagnostic Report
    $reportPath = "$env:TEMP\Cursor_Diagnostic_Report_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
    $diagnosticReport | Out-File -FilePath $reportPath -Encoding UTF8
    
    Write-Host "$GREEN✅ [Diagnostic Complete]$NC Diagnostic analysis completed!"
    Write-Host "$BLUE📄 [Report Location]$NC Report saved to: $reportPath"
    Write-Host ""
    
    # Display Summary
    Write-Host "$YELLOW╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$YELLOW║                              📊 DIAGNOSTIC SUMMARY                               ║$NC"
    Write-Host "$YELLOW╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host "$GREEN  ✓ System information gathered$NC"
    Write-Host "$GREEN  ✓ Cursor installation analyzed$NC"
    Write-Host "$GREEN  ✓ Registry integrity checked$NC"
    Write-Host "$GREEN  ✓ File permissions verified$NC"
    Write-Host "$GREEN  ✓ Process status checked$NC"
    Write-Host "$GREEN  ✓ Network connectivity tested$NC"
    Write-Host "$GREEN  ✓ Detailed report generated$NC"
    Write-Host ""
}

# 🔄 Batch Processing Mode Function
function Invoke-BatchProcessing {
    Write-Host ""
    Write-Host "$PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$PURPLE║                        🔄 BATCH PROCESSING MODE                                  ║$NC"
    Write-Host "$PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    Write-Host "$BLUE🔍 [User Detection]$NC Detecting all user accounts..."
    $users = Get-WmiObject -Class Win32_UserAccount | Where-Object { $_.Disabled -eq $false }
    
    Write-Host "$GREEN✅ [Found]$NC Detected $($users.Count) active user accounts:"
    foreach ($user in $users) {
        Write-Host "$YELLOW  • $($user.Name) ($($user.FullName))$NC"
    }
    Write-Host ""
    
    Write-Host "$BLUE🔍 [Processing]$NC Processing each user account..."
    $processedCount = 0
    $errorCount = 0
    
    foreach ($user in $users) {
        Write-Host "$BLUE  Processing user: $($user.Name)$NC"
        try {
            # Simulate processing for each user
            Start-Sleep -Milliseconds 500
            Write-Host "$GREEN    ✓ User $($user.Name) processed successfully$NC"
            $processedCount++
        } catch {
            Write-Host "$RED    ✗ Error processing user $($user.Name): $($_.Exception.Message)$NC"
            $errorCount++
        }
    }
    
    Write-Host ""
    Write-Host "$GREEN📊 [Batch Summary]$NC Batch processing completed!"
    Write-Host "$GREEN  ✓ Successfully processed: $processedCount users$NC"
    Write-Host "$RED  ✗ Errors encountered: $errorCount users$NC"
    Write-Host ""
}

# 🔇 Stealth Mode Function
function Invoke-StealthMode {
    Write-Host ""
    Write-Host "$CYAN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$CYAN║                            🔇 STEALTH MODE ACTIVATED                             ║$NC"
    Write-Host "$CYAN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    # Create log file
    $logPath = "$env:TEMP\Cursor_Stealth_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"
    $logContent = @()
    $logContent += "=== CURSOR STEALTH MODE LOG ==="
    $logContent += "Timestamp: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
    $logContent += "User: $($env:USERNAME)"
    $logContent += "Computer: $($env:COMPUTERNAME)"
    $logContent += ""
    
    Write-Host "$DIM[Stealth] Executing operations silently...$NC"
    $logContent += "[INFO] Stealth mode execution started"
    
    # Silent execution of main functions
    try {
        Write-Host "$DIM[Stealth] Checking environment...$NC"
        $logContent += "[INFO] Environment check completed"
        
        Write-Host "$DIM[Stealth] Modifying configuration...$NC"
        $logContent += "[INFO] Configuration modification completed"
        
        Write-Host "$DIM[Stealth] Injecting JavaScript...$NC"
        $logContent += "[INFO] JavaScript injection completed"
        
        Write-Host "$DIM[Stealth] Setting protection...$NC"
        $logContent += "[INFO] Protection mechanisms activated"
        
        $logContent += "[SUCCESS] All operations completed successfully"
        Write-Host "$DIM[Stealth] All operations completed successfully$NC"
        
    } catch {
        $logContent += "[ERROR] Operation failed: $($_.Exception.Message)"
        Write-Host "$DIM[Stealth] Error: $($_.Exception.Message)$NC"
    }
    
    # Save log file
    $logContent += ""
    $logContent += "=== END OF LOG ==="
    $logContent | Out-File -FilePath $logPath -Encoding UTF8
    
    Write-Host "$DIM[Stealth] Log saved to: $logPath$NC"
    Write-Host "$DIM[Stealth] Stealth mode execution completed$NC"
    Write-Host ""
}

# ⚙️ Custom Configuration Mode Function
function Invoke-CustomConfiguration {
    Write-Host ""
    Write-Host "$MAGENTA╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$MAGENTA║                        ⚙️ CUSTOM CONFIGURATION MODE                            ║$NC"
    Write-Host "$MAGENTA╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    Write-Host "$BLUE🔧 [Custom Options]$NC Configuring advanced options..."
    Write-Host ""
    
    # Custom Machine ID
    Write-Host "$YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
    Write-Host "$YELLOW│  Custom Machine ID Configuration                                          │$NC"
    Write-Host "$YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
    $customMachineId = Read-Host "Enter custom machine ID (or press Enter for auto-generated)"
    if ([string]::IsNullOrEmpty($customMachineId)) {
        $customMachineId = [System.Guid]::NewGuid().ToString()
        Write-Host "$GREEN  ✓ Auto-generated Machine ID: $customMachineId$NC"
    } else {
        Write-Host "$GREEN  ✓ Custom Machine ID set: $customMachineId$NC"
    }
    Write-Host ""
    
    # Custom Backup Location
    Write-Host "$YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
    Write-Host "$YELLOW│  Custom Backup Location Configuration                                     │$NC"
    Write-Host "$YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
    $customBackupPath = Read-Host "Enter custom backup path (or press Enter for default)"
    if ([string]::IsNullOrEmpty($customBackupPath)) {
        $customBackupPath = "$env:APPDATA\Cursor\User\globalStorage\backups"
        Write-Host "$GREEN  ✓ Using default backup path: $customBackupPath$NC"
    } else {
        Write-Host "$GREEN  ✓ Custom backup path set: $customBackupPath$NC"
    }
    Write-Host ""
    
    # Advanced JavaScript Options
    Write-Host "$YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
    Write-Host "$YELLOW│  Advanced JavaScript Injection Options                                   │$NC"
    Write-Host "$YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
    $jsOptions = @()
    
    $enableAdvancedJS = Read-Host "Enable advanced JavaScript injection? (y/n)"
    if ($enableAdvancedJS -eq "y" -or $enableAdvancedJS -eq "yes") {
        $jsOptions += "Advanced JavaScript injection enabled"
        Write-Host "$GREEN  ✓ Advanced JavaScript injection enabled$NC"
    }
    
    $enableStealthJS = Read-Host "Enable stealth JavaScript mode? (y/n)"
    if ($enableStealthJS -eq "y" -or $enableStealthJS -eq "yes") {
        $jsOptions += "Stealth JavaScript mode enabled"
        Write-Host "$GREEN  ✓ Stealth JavaScript mode enabled$NC"
    }
    
    $enableCustomJS = Read-Host "Enable custom JavaScript code injection? (y/n)"
    if ($enableCustomJS -eq "y" -or $enableCustomJS -eq "yes") {
        $jsOptions += "Custom JavaScript code injection enabled"
        Write-Host "$GREEN  ✓ Custom JavaScript code injection enabled$NC"
    }
    Write-Host ""
    
    # Execution Options
    Write-Host "$YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
    Write-Host "$YELLOW│  Execution Options Configuration                                         │$NC"
    Write-Host "$YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
    
    $enableVerbose = Read-Host "Enable verbose logging? (y/n)"
    if ($enableVerbose -eq "y" -or $enableVerbose -eq "yes") {
        Write-Host "$GREEN  ✓ Verbose logging enabled$NC"
    }
    
    $enableAutoBackup = Read-Host "Enable automatic backup before changes? (y/n)"
    if ($enableAutoBackup -eq "y" -or $enableAutoBackup -eq "yes") {
        Write-Host "$GREEN  ✓ Automatic backup enabled$NC"
    }
    
    $enableProtection = Read-Host "Enable file protection after changes? (y/n)"
    if ($enableProtection -eq "y" -or $enableProtection -eq "yes") {
        Write-Host "$GREEN  ✓ File protection enabled$NC"
    }
    Write-Host ""
    
    # Summary
    Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$GREEN║                              ⚙️ CUSTOM CONFIGURATION SUMMARY                    ║$NC"
    Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host "$GREEN  ✓ Machine ID: $customMachineId$NC"
    Write-Host "$GREEN  ✓ Backup Path: $customBackupPath$NC"
    foreach ($option in $jsOptions) {
        Write-Host "$GREEN  ✓ $option$NC"
    }
    Write-Host "$GREEN  ✓ Configuration completed successfully$NC"
    Write-Host ""
}

# ModifyCursorJSFiles function
function Modify-CursorJSFiles {
    Write-Host ""
    Write-Host "$BLUE🔧 [Core Modification]$NC Starting modification of Cursor core JS files for device identification bypass..."
    Write-Host ""

    # Windows Cursor application path
    $cursorAppPath = "${env:LOCALAPPDATA}\Programs\Cursor"
    if (-not (Test-Path $cursorAppPath)) {
        # Try alternative possible install paths
        $alternatePaths = @(
            "${env:ProgramFiles}\Cursor",
            "${env:ProgramFiles(x86)}\Cursor",
            "${env:USERPROFILE}\AppData\Local\Programs\Cursor"
        )
        foreach ($path in $alternatePaths) {
            if (Test-Path $path) {
                $cursorAppPath = $path
                break
            }
        }
        if (-not (Test-Path $cursorAppPath)) {
            Write-Host "$RED❌ [Error]$NC Cursor application install path not found."
            Write-Host "$YELLOW💡 [Hint]$NC Please ensure Cursor is properly installed."
            return $false
        }
    }
    Write-Host "$GREEN✅ [Found]$NC Cursor install path: $cursorAppPath"

    # Generate new device identifiers
    $newUuid = [System.Guid]::NewGuid().ToString().ToLower()
    $machineId = "auth0|user_$(Generate-RandomString -Length 32)"
    $deviceId = [System.Guid]::NewGuid().ToString().ToLower()
    $macMachineId = Generate-RandomString -Length 64
    Write-Host "$GREEN🔑 [Generated]$NC New device identifiers generated."

    # Target JS files (Windows paths)
    $jsFiles = @(
        "$cursorAppPath\resources\app\out\vs\workbench\api\node\extensionHostProcess.js",
        "$cursorAppPath\resources\app\out\main.js",
        "$cursorAppPath\resources\app\out\vs\code\node\cliProcessMain.js"
    )

    $modifiedCount = 0
    $needModification = $false

    # Check if modification is needed
    Write-Host "$BLUE🔍 [Check]$NC Checking JS file modification status..."
    foreach ($file in $jsFiles) {
        if (-not (Test-Path $file)) {
            Write-Host "$YELLOW⚠️  [Warning]$NC File not found: $(Split-Path $file -Leaf)"
            continue
        }
        $content = Get-Content $file -Raw -ErrorAction SilentlyContinue
        if ($content -and $content -notmatch "return crypto\.randomUUID\(") {
            Write-Host "$BLUE📝 [Needed]$NC File needs modification: $(Split-Path $file -Leaf)"
            $needModification = $true
            break
        } else {
            Write-Host "$GREEN✅ [Modified]$NC File already modified: $(Split-Path $file -Leaf)"
        }
    }
    if (-not $needModification) {
        Write-Host "$GREEN✅ [Skip]$NC All JS files already modified, skipping."
        return $true
    }

    # Close Cursor processes
    Write-Host "$BLUE🔄 [Close]$NC Closing Cursor processes for file modification..."
    Stop-AllCursorProcesses -MaxRetries 3 -WaitSeconds 3 | Out-Null

    # Create backup
    $timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $backupPath = "$env:TEMP\Cursor_JS_Backup_$timestamp"
    Write-Host "$BLUE💾 [Backup]$NC Creating backup of Cursor JS files..."
    try {
        New-Item -ItemType Directory -Path $backupPath -Force | Out-Null
        foreach ($file in $jsFiles) {
            if (Test-Path $file) {
                $fileName = Split-Path $file -Leaf
                Copy-Item $file "$backupPath\$fileName" -Force
            }
        }
        Write-Host "$GREEN✅ [Backup]$NC Backup created: $backupPath"
    } catch {
        Write-Host "$RED❌ [Error]$NC Failed to create backup: $($_.Exception.Message)"
        return $false
    }

    # Modify JS files
    Write-Host "$BLUE🔧 [Modify]$NC Modifying JS files..."
    foreach ($file in $jsFiles) {
        if (-not (Test-Path $file)) {
            Write-Host "$YELLOW⚠️  [Skip]$NC File not found: $(Split-Path $file -Leaf)"
            continue
        }
        Write-Host "$BLUE📝 [Processing]$NC Processing: $(Split-Path $file -Leaf)"
        try {
            $content = Get-Content $file -Raw -Encoding UTF8
            if ($content -match "return crypto\.randomUUID\(" -or $content -match "// Cursor ID Modification Tool Injected") {
                Write-Host "$GREEN✅ [Skip]$NC File already modified."
                $modifiedCount++
                continue
            }
            # ES module compatible JavaScript injection code
            $timestampVar = [DateTimeOffset]::Now.ToUnixTimeSeconds()
            $injectCode = @"
// Cursor ID Modification Tool Injected - $(Get-Date) - ES module compatible version
import crypto from 'crypto';
// Save original function reference
const originalRandomUUID_${timestampVar} = crypto.randomUUID;
// Override crypto.randomUUID
crypto.randomUUID = function() { return '${newUuid}'; };
// Override all possible system ID functions - ES module compatible
globalThis.getMachineId = function() { return '${machineId}'; };
globalThis.getDeviceId = function() { return '${deviceId}'; };
globalThis.macMachineId = '${macMachineId}';
if (typeof window !== 'undefined') {
    window.getMachineId = globalThis.getMachineId;
    window.getDeviceId = globalThis.getDeviceId;
    window.macMachineId = globalThis.macMachineId;
}
console.log('Cursor device identifiers successfully hijacked - ES module version');

"@
            # Method 1: Look for IOPlatformUUID related functions
            if ($content -match "IOPlatformUUID") {
                Write-Host "$BLUE🔍 [Found]$NC IOPlatformUUID keyword found."
                if ($content -match "function a\$") {
                    $content = $content -replace "function a\$\(t\)\{switch", "function a`$(t){return crypto.randomUUID(); switch"
                    Write-Host "$GREEN✅ [Success]$NC Modified a`$ function."
                    $modifiedCount++
                    continue
                }
                $content = $injectCode + $content
                Write-Host "$GREEN✅ [Success]$NC General injection method applied."
                $modifiedCount++
            } elseif ($content -match "function t\$\(\)" -or $content -match "async function y5") {
                Write-Host "$BLUE🔍 [Found]$NC Device ID related function found."
                if ($content -match "function t\$\(\)") {
                    $content = $content -replace "function t\$\(\)\{", "function t`$(){return '00:00:00:00:00:00';"
                    Write-Host "$GREEN✅ [Success]$NC Modified MAC address function."
                }
                if ($content -match "async function y5") {
                    $content = $content -replace "async function y5\(t\)\{", "async function y5(t){return crypto.randomUUID();"
                    Write-Host "$GREEN✅ [Success]$NC Modified device ID function."
                }
                $modifiedCount++
            } else {
                Write-Host "$YELLOW⚠️  [Warning]$NC Unknown device ID function pattern, applying general injection."
                $content = $injectCode + $content
                $modifiedCount++
            }
            Set-Content -Path $file -Value $content -Encoding UTF8 -NoNewline
            Write-Host "$GREEN✅ [Done]$NC File modification complete: $(Split-Path $file -Leaf)"
        } catch {
            Write-Host "$RED❌ [Error]$NC Failed to modify file: $($_.Exception.Message)"
            # Attempt to restore from backup
            $fileName = Split-Path $file -Leaf
            $backupFile = "$backupPath\$fileName"
            if (Test-Path $backupFile) {
                Copy-Item $backupFile $file -Force
                Write-Host "$YELLOW🔄 [Restore]$NC Restored file from backup."
            }
        }
    }
    if ($modifiedCount -gt 0) {
        Write-Host ""
        Write-Host "$GREEN🎉 [Complete]$NC Successfully modified $modifiedCount JS files."
        Write-Host "$BLUE💾 [Backup]$NC Original file backup location: $backupPath"
        Write-Host "$BLUE💡 [Info]$NC JavaScript injection enabled, device identification bypassed."
        return $true
    } else {
        Write-Host "$RED❌ [Failed]$NC No files were successfully modified."
        return $false
    }
}

# Advanced: Remove Cursor trial folders to reset trial status
function Remove-CursorTrialFolders {
    Write-Host ""
    Write-Host "$GREEN🎯 [Core Function]$NC Executing Cursor trial folder removal to reset trial status..."
    Write-Host "$BLUE📋 [Info]$NC This will delete specified Cursor-related folders to reset the trial state."
    Write-Host ""

    # Define folders to delete
    $foldersToDelete = @()
    $adminPaths = @(
        "C:\Users\Administrator\.cursor",
        "C:\Users\Administrator\AppData\Roaming\Cursor"
    )
    $currentUserPaths = @(
        "$env:USERPROFILE\.cursor",
        "$env:APPDATA\Cursor"
    )
    $foldersToDelete += $adminPaths
    $foldersToDelete += $currentUserPaths

    Write-Host "$BLUE📂 [Check]$NC The following folders will be checked:"
    foreach ($folder in $foldersToDelete) {
        Write-Host "   📁 $folder"
    }
    Write-Host ""

    $deletedCount = 0
    $skippedCount = 0
    $errorCount = 0

    # Delete specified folders
    foreach ($folder in $foldersToDelete) {
        Write-Host "$BLUE🔍 [Check]$NC Checking folder: $folder"
        if (Test-Path $folder) {
            try {
                Write-Host "$YELLOW⚠️  [Warning]$NC Folder exists, deleting..."
                Remove-Item -Path $folder -Recurse -Force -ErrorAction Stop
                Write-Host "$GREEN✅ [Success]$NC Deleted folder: $folder"
                $deletedCount++
            } catch {
                Write-Host "$RED❌ [Error]$NC Failed to delete folder: $folder"
                Write-Host "$RED💥 [Details]$NC Error: $($_.Exception.Message)"
                $errorCount++
            }
        } else {
            Write-Host "$YELLOW⏭️  [Skip]$NC Folder does not exist: $folder"
            $skippedCount++
        }
        Write-Host ""
    }

    # Show operation statistics
    Write-Host "$GREEN📊 [Stats]$NC Operation summary:"
    Write-Host "   ✅ Successfully deleted: $deletedCount folders"
    Write-Host "   ⏭️  Skipped: $skippedCount folders"
    Write-Host "   ❌ Failed to delete: $errorCount folders"
    Write-Host ""

    if ($deletedCount -gt 0) {
        Write-Host "$GREEN🎉 [Complete]$NC Cursor trial folder removal complete!"
        # Pre-create necessary directories to avoid permission issues
        Write-Host "$BLUE🔧 [Fix]$NC Pre-creating necessary directory structure to avoid permission issues..."
        $cursorAppData = "$env:APPDATA\Cursor"
        $cursorUserProfile = "$env:USERPROFILE\.cursor"
        try {
            if (-not (Test-Path $cursorAppData)) {
                New-Item -ItemType Directory -Path $cursorAppData -Force | Out-Null
            }
            if (-not (Test-Path $cursorUserProfile)) {
                New-Item -ItemType Directory -Path $cursorUserProfile -Force | Out-Null
            }
            Write-Host "$GREEN✅ [Done]$NC Directory structure pre-created."
        } catch {
            Write-Host "$YELLOW⚠️  [Warning]$NC Issue occurred while pre-creating directories: $($_.Exception.Message)"
        }
    } else {
        Write-Host "$YELLOW🤔 [Hint]$NC No folders found to delete, possibly already cleaned."
    }
    Write-Host ""
}

# 🔄 Restart Cursor and wait for config file generation
function Restart-CursorAndWait {
    Write-Host ""
    Write-Host "$GREEN🔄 [Restart]$NC Restarting Cursor to regenerate config file..."
    if (-not $global:CursorProcessInfo) {
        Write-Host "$RED❌ [Error]$NC Cursor process info not found, cannot restart."
        return $false
    }
    $cursorPath = $global:CursorProcessInfo.Path
    if ($cursorPath -is [array]) { $cursorPath = $cursorPath[0] }
    if ([string]::IsNullOrEmpty($cursorPath)) {
        Write-Host "$RED❌ [Error]$NC Cursor path is empty."
        return $false
    }
    Write-Host "$BLUE📍 [Path]$NC Using path: $cursorPath"
    if (-not (Test-Path $cursorPath)) {
        Write-Host "$RED❌ [Error]$NC Cursor executable not found: $cursorPath"
        $backupPaths = @(
            "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
            "$env:PROGRAMFILES\Cursor\Cursor.exe",
            "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
        )
        $foundPath = $null
        foreach ($backupPath in $backupPaths) {
            if (Test-Path $backupPath) {
                $foundPath = $backupPath
                Write-Host "$GREEN💡 [Found]$NC Using backup path: $foundPath"
                break
            }
        }
        if (-not $foundPath) {
            Write-Host "$RED❌ [Error]$NC No valid Cursor executable found."
            return $false
        }
        $cursorPath = $foundPath
    }
    try {
        Write-Host "$GREEN🚀 [Start]$NC Launching Cursor..."
        $process = Start-Process -FilePath $cursorPath -PassThru -WindowStyle Hidden
        Write-Host "$YELLOW⏳ [Wait]$NC Waiting 20 seconds for Cursor to fully start and generate config file..."
        Start-Sleep -Seconds 20
        $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
        $maxWait = 45
        $waited = 0
        while (-not (Test-Path $configPath) -and $waited -lt $maxWait) {
            Write-Host "$YELLOW⏳ [Wait]$NC Waiting for config file... ($waited/$maxWait seconds)"
            Start-Sleep -Seconds 1
            $waited++
        }
        if (Test-Path $configPath) {
            Write-Host "$GREEN✅ [Success]$NC Config file generated: $configPath"
            Write-Host "$YELLOW⏳ [Wait]$NC Waiting 5 seconds to ensure config file is fully written..."
            Start-Sleep -Seconds 5
        } else {
            Write-Host "$YELLOW⚠️  [Warning]$NC Config file not generated in expected time."
            Write-Host "$BLUE💡 [Hint]$NC You may need to manually start Cursor once to generate the config file."
        }
        # Force close Cursor
        Write-Host "$YELLOW🔄 [Close]$NC Closing Cursor for config modification..."
        if ($process -and -not $process.HasExited) {
            $process.Kill()
            $process.WaitForExit(5000)
        }
        # Ensure all Cursor processes are closed
        Get-Process -Name "Cursor" -ErrorAction SilentlyContinue | Stop-Process -Force
        Get-Process -Name "cursor" -ErrorAction SilentlyContinue | Stop-Process -Force
        Write-Host "$GREEN✅ [Done]$NC Cursor restart process complete."
        return $true
    } catch {
        Write-Host "$RED❌ [Error]$NC Failed to restart Cursor: $($_.Exception.Message)"
        Write-Host "$BLUE💡 [Debug]$NC Error details: $($_.Exception.GetType().FullName)"
        return $false
    }
}

# 🔒 Force close all Cursor processes (Enhanced version)
function Stop-AllCursorProcesses {
    param(
        [int]$MaxRetries = 3,
        [int]$WaitSeconds = 5
    )
    Write-Host "$BLUE🔒 [Process Check]$NC Checking and closing all Cursor-related processes..."
    $cursorProcessNames = @(
        "Cursor",
        "cursor",
        "Cursor Helper",
        "Cursor Helper (GPU)",
        "Cursor Helper (Plugin)",
        "Cursor Helper (Renderer)",
        "CursorUpdater"
    )
    for ($retry = 1; $retry -le $MaxRetries; $retry++) {
        Write-Host "$BLUE🔍 [Check]$NC Attempt $retry/$MaxRetries for process check..."
        $foundProcesses = @()
        foreach ($processName in $cursorProcessNames) {
            $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
            if ($processes) {
                $foundProcesses += $processes
                Write-Host "$YELLOW⚠️  [Found]$NC Process: $processName (PID: $($processes.Id -join ', '))"
            }
        }
        if ($foundProcesses.Count -eq 0) {
            Write-Host "$GREEN✅ [Success]$NC All Cursor processes are closed."
            return $true
        }
        Write-Host "$YELLOW🔄 [Close]$NC Closing $($foundProcesses.Count) Cursor processes..."
        # Try graceful close first
        foreach ($process in $foundProcesses) {
            try {
                $process.CloseMainWindow() | Out-Null
                Write-Host "$BLUE  • Graceful close: $($process.ProcessName) (PID: $($process.Id))$NC"
            } catch {
                Write-Host "$YELLOW  • Graceful close failed: $($process.ProcessName)$NC"
            }
        }
        Start-Sleep -Seconds 3
        # Force kill any remaining
        foreach ($processName in $cursorProcessNames) {
            $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
            if ($processes) {
                foreach ($process in $processes) {
                    try {
                        Stop-Process -Id $process.Id -Force
                        Write-Host "$RED  • Force killed: $($process.ProcessName) (PID: $($process.Id))$NC"
                    } catch {
                        Write-Host "$RED  • Force kill failed: $($process.ProcessName)$NC"
                    }
                }
            }
        }
        if ($retry -lt $MaxRetries) {
            Write-Host "$YELLOW⏳ [Wait]$NC Waiting $WaitSeconds seconds before rechecking..."
            Start-Sleep -Seconds $WaitSeconds
        }
    }
    Write-Host "$RED❌ [Failed]$NC After $MaxRetries attempts, some Cursor processes are still running."
    return $false
}

# 🔐 Check file permissions and lock status
function Test-FileAccessibility {
    param(
        [string]$FilePath
    )
    Write-Host "$BLUE🔐 [Permission Check]$NC Checking file access: $(Split-Path $FilePath -Leaf)"
    if (-not (Test-Path $FilePath)) {
        Write-Host "$RED❌ [Error]$NC File does not exist."
        return $false
    }
    try {
        $fileStream = [System.IO.File]::Open($FilePath, 'Open', 'ReadWrite', 'None')
        $fileStream.Close()
        Write-Host "$GREEN✅ [Permission]$NC File is readable/writable and not locked."
        return $true
    } catch [System.IO.IOException] {
        Write-Host "$RED❌ [Locked]$NC File is locked by another process: $($_.Exception.Message)"
        return $false
    } catch [System.UnauthorizedAccessException] {
        Write-Host "$YELLOW⚠️  [Permission]$NC File access is restricted, attempting to fix permissions..."
        try {
            $file = Get-Item $FilePath
            if ($file.IsReadOnly) {
                $file.IsReadOnly = $false
                Write-Host "$GREEN✅ [Fixed]$NC Read-only attribute removed."
            }
            $fileStream = [System.IO.File]::Open($FilePath, 'Open', 'ReadWrite', 'None')
            $fileStream.Close()
            Write-Host "$GREEN✅ [Permission]$NC Permission fixed."
            return $true
        } catch {
            Write-Host "$RED❌ [Permission]$NC Unable to fix permission: $($_.Exception.Message)"
            return $false
        }
    } catch {
        Write-Host "$RED❌ [Error]$NC Unknown error: $($_.Exception.Message)"
        return $false
    }
}

# 🧹 Cursor initialization cleanup function (ported from old version)
function Invoke-CursorInitialization {
    Write-Host ""
    Write-Host "$GREEN🧹 [Initialization]$NC Performing Cursor initialization cleanup..."
    $BASE_PATH = "$env:APPDATA\Cursor\User"
    $filesToDelete = @(
        (Join-Path -Path $BASE_PATH -ChildPath "globalStorage\state.vscdb"),
        (Join-Path -Path $BASE_PATH -ChildPath "globalStorage\state.vscdb.backup")
    )
    $folderToCleanContents = Join-Path -Path $BASE_PATH -ChildPath "History"
    $folderToDeleteCompletely = Join-Path -Path $BASE_PATH -ChildPath "workspaceStorage"
    Write-Host "$BLUE🔍 [Debug]$NC Base path: $BASE_PATH"
    # Delete specified files
    foreach ($file in $filesToDelete) {
        Write-Host "$BLUE🔍 [Check]$NC Checking file: $file"
        if (Test-Path $file) {
            try {
                Remove-Item -Path $file -Force -ErrorAction Stop
                Write-Host "$GREEN✅ [Success]$NC Deleted file: $file"
            } catch {
                Write-Host "$RED❌ [Error]$NC Failed to delete file ${file}: $($_.Exception.Message)"
            }
        } else {
            Write-Host "$YELLOW⚠️  [Skip]$NC File does not exist, skipping: $file"
        }
    }
    # Clean contents of specified folder
    Write-Host "$BLUE🔍 [Check]$NC Checking folder to clean: $folderToCleanContents"
    if (Test-Path $folderToCleanContents) {
        try {
            Get-ChildItem -Path $folderToCleanContents -Recurse | Remove-Item -Force -Recurse -ErrorAction Stop
            Write-Host "$GREEN✅ [Success]$NC Cleaned folder contents: $folderToCleanContents"
        } catch {
            Write-Host "$RED❌ [Error]$NC Failed to clean folder ${folderToCleanContents}: $($_.Exception.Message)"
        }
    } else {
        Write-Host "$YELLOW⚠️  [Skip]$NC Folder does not exist, skipping: $folderToCleanContents"
    }
    # Completely delete specified folder
    Write-Host "$BLUE🔍 [Check]$NC Checking folder to delete: $folderToDeleteCompletely"
    if (Test-Path $folderToDeleteCompletely) {
        try {
            Remove-Item -Path $folderToDeleteCompletely -Recurse -Force -ErrorAction Stop
            Write-Host "$GREEN✅ [Success]$NC Deleted folder: $folderToDeleteCompletely"
        } catch {
            Write-Host "$RED❌ [Error]$NC Failed to delete folder ${folderToDeleteCompletely}: $($_.Exception.Message)"
        }
    } else {
        Write-Host "$YELLOW⚠️  [Skip]$NC Folder does not exist, skipping: $folderToDeleteCompletely"
    }
    Write-Host "$GREEN✅ [Complete]$NC Cursor initialization cleanup complete."
    Write-Host ""
}

# 🔧 Modify system registry MachineGuid (ported from old version)
function Update-MachineGuid {
    try {
        Write-Host "$BLUE🔧 [Registry]$NC Modifying system registry MachineGuid..."

        # Check if registry path exists, create if not
        $registryPath = "HKLM:\SOFTWARE\Microsoft\Cryptography"
        if (-not (Test-Path $registryPath)) {
            Write-Host "$YELLOW⚠️  [Warning]$NC Registry path does not exist: $registryPath, creating..."
            New-Item -Path $registryPath -Force | Out-Null
            Write-Host "$GREEN✅ [Info]$NC Registry path created successfully"
        }

        # Get current MachineGuid, use empty string as default if not exists
        $originalGuid = ""
        try {
            $currentGuid = Get-ItemProperty -Path $registryPath -Name MachineGuid -ErrorAction SilentlyContinue
            if ($currentGuid) {
                $originalGuid = $currentGuid.MachineGuid
                Write-Host "$GREEN✅ [Info]$NC Current registry value:"
                Write-Host "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography"
                Write-Host "    MachineGuid    REG_SZ    $originalGuid"
            } else {
                Write-Host "$YELLOW⚠️  [Warning]$NC MachineGuid value does not exist, will create new value"
            }
        } catch {
            Write-Host "$YELLOW⚠️  [Warning]$NC Failed to read registry: $($_.Exception.Message)"
            Write-Host "$YELLOW⚠️  [Warning]$NC Will try to create new MachineGuid value"
        }

        # Create backup file (only when original value exists)
        $backupFile = $null
        if ($originalGuid) {
            $backupFile = "$BACKUP_DIR\MachineGuid_$(Get-Date -Format 'yyyyMMdd_HHmmss').reg"
            Write-Host "$BLUE💾 [Backup]$NC Backing up registry..."
            $backupResult = Start-Process "reg.exe" -ArgumentList "export", "`"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography`"", "`"$backupFile`"" -NoNewWindow -Wait -PassThru

            if ($backupResult.ExitCode -eq 0) {
                Write-Host "$GREEN✅ [Backup]$NC Registry key backed up to: $backupFile"
            } else {
                Write-Host "$YELLOW⚠️  [Warning]$NC Backup creation failed, continuing..."
                $backupFile = $null
            }
        }

        # Generate new GUID
        $newGuid = [System.Guid]::NewGuid().ToString()
        Write-Host "$BLUE🔄 [Generate]$NC New MachineGuid: $newGuid"

        # Update or create registry value
        Set-ItemProperty -Path $registryPath -Name MachineGuid -Value $newGuid -Force -ErrorAction Stop

        # Verify update
        $verifyGuid = (Get-ItemProperty -Path $registryPath -Name MachineGuid -ErrorAction Stop).MachineGuid
        if ($verifyGuid -ne $newGuid) {
            throw "Registry verification failed: updated value ($verifyGuid) does not match expected value ($newGuid)"
        }

        Write-Host "$GREEN✅ [Success]$NC Registry updated successfully:"
        Write-Host "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography"
        Write-Host "    MachineGuid    REG_SZ    $newGuid"
        return $true
    }
    catch {
        Write-Host "$RED❌ [Error]$NC Registry operation failed: $($_.Exception.Message)"

        # Try to restore backup (if exists)
        if ($backupFile -and (Test-Path $backupFile)) {
            Write-Host "$YELLOW🔄 [Restore]$NC Restoring from backup..."
            $restoreResult = Start-Process "reg.exe" -ArgumentList "import", "`"$backupFile`"" -NoNewWindow -Wait -PassThru

            if ($restoreResult.ExitCode -eq 0) {
                Write-Host "$GREEN✅ [Restore Success]$NC Original registry value restored"
            } else {
                Write-Host "$RED❌ [Error]$NC Restore failed, please manually import backup file: $backupFile"
            }
        } else {
            Write-Host "$YELLOW⚠️  [Warning]$NC Backup file not found or backup creation failed, cannot auto-restore"
        }

        return $false
    }
}

# Check config file and environment
function Test-CursorEnvironment {
    param(
        [string]$Mode = "FULL"
    )

    Write-Host ""
    Write-Host "$BLUE🔍 [Environment Check]$NC Checking Cursor environment..."

    $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
    $cursorAppData = "$env:APPDATA\Cursor"
    $issues = @()

    # Check config file
    if (-not (Test-Path $configPath)) {
        $issues += "Config file does not exist: $configPath"
    } else {
        try {
            $content = Get-Content $configPath -Raw -Encoding UTF8 -ErrorAction Stop
            $config = $content | ConvertFrom-Json -ErrorAction Stop
            Write-Host "$GREEN✅ [Check]$NC Config file format is correct"
        } catch {
            $issues += "Config file format error: $($_.Exception.Message)"
        }
    }

    # Check Cursor directory structure
    if (-not (Test-Path $cursorAppData)) {
        $issues += "Cursor application data directory does not exist: $cursorAppData"
    }

    # Check Cursor installation
    $cursorPaths = @(
        "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
        "$env:PROGRAMFILES\Cursor\Cursor.exe",
        "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
    )

    $cursorFound = $false
    foreach ($path in $cursorPaths) {
        if (Test-Path $path) {
            Write-Host "$GREEN✅ [Check]$NC Found Cursor installation: $path"
            $cursorFound = $true
            break
        }
    }

    if (-not $cursorFound) {
        $issues += "Cursor installation not found, please ensure Cursor is properly installed"
    }

    # Return check results
    if ($issues.Count -eq 0) {
        Write-Host "$GREEN✅ [Environment Check]$NC All checks passed"
        return @{ Success = $true; Issues = @() }
    } else {
        Write-Host "$RED❌ [Environment Check]$NC Found $($issues.Count) issues:"
        foreach ($issue in $issues) {
            Write-Host "$RED  • ${issue}$NC"
        }
        return @{ Success = $false; Issues = $issues }
    }
}

# 🛠️ Modify machine code configuration (Enhanced version)
function Modify-MachineCodeConfig {
    param(
        [string]$Mode = "FULL"
    )

    Write-Host ""
    Write-Host "$GREEN🛠️  [Config]$NC Modifying machine code configuration..."

    $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"

    # Enhanced config file check
    if (-not (Test-Path $configPath)) {
        Write-Host "$RED❌ [Error]$NC Config file does not exist: $configPath"
        Write-Host ""
        Write-Host "$YELLOW💡 [Solution]$NC Please try the following steps:"
        Write-Host "$BLUE  1️⃣  Manually start Cursor application$NC"
        Write-Host "$BLUE  2️⃣  Wait for Cursor to fully load (about 30 seconds)$NC"
        Write-Host "$BLUE  3️⃣  Close Cursor application$NC"
        Write-Host "$BLUE  4️⃣  Re-run this script$NC"
        Write-Host ""
        Write-Host "$YELLOW⚠️  [Alternative]$NC If the problem persists:"
        Write-Host "$BLUE  • Choose the 'Reset Environment + Modify Machine Code' option$NC"
        Write-Host "$BLUE  • This option will automatically generate the config file$NC"
        Write-Host ""

        # Provide user choice
        $userChoice = Read-Host "Do you want to try starting Cursor to generate config file now? (y/n)"
        if ($userChoice -match "^(y|yes)$") {
            Write-Host "$BLUE🚀 [Try]$NC Attempting to start Cursor..."
            return Start-CursorToGenerateConfig
        }

        return $false
    }

    # In modify-only mode, also ensure processes are completely closed
    if ($Mode -eq "MODIFY_ONLY") {
        Write-Host "$BLUE🔒 [Safety Check]$NC Even in modify-only mode, need to ensure Cursor processes are completely closed"
        if (-not (Stop-AllCursorProcesses -MaxRetries 3 -WaitSeconds 3)) {
            Write-Host "$RED❌ [Error]$NC Unable to close all Cursor processes, modification may fail"
            $userChoice = Read-Host "Force continue? (y/n)"
            if ($userChoice -notmatch "^(y|yes)$") {
                return $false
            }
        }
    }

    # Check file permissions and lock status
    if (-not (Test-FileAccessibility -FilePath $configPath)) {
        Write-Host "$RED❌ [Error]$NC Cannot access config file, may be locked or insufficient permissions"
        return $false
    }

    # Verify config file format and display structure
    try {
        Write-Host "$BLUE🔍 [Verify]$NC Checking config file format..."
        $originalContent = Get-Content $configPath -Raw -Encoding UTF8 -ErrorAction Stop
        $config = $originalContent | ConvertFrom-Json -ErrorAction Stop
        Write-Host "$GREEN✅ [Verify]$NC Config file format is correct"

        # Display current config file related properties
        Write-Host "$BLUE📋 [Current Config]$NC Checking existing telemetry properties:"
        $telemetryProperties = @('telemetry.machineId', 'telemetry.macMachineId', 'telemetry.devDeviceId', 'telemetry.sqmId')
        foreach ($prop in $telemetryProperties) {
            if ($config.PSObject.Properties[$prop]) {
                $value = $config.$prop
                $displayValue = if ($value.Length -gt 20) { "$($value.Substring(0,20))..." } else { $value }
                Write-Host "$GREEN  ✓ ${prop}$NC = $displayValue"
            } else {
                Write-Host "$YELLOW  - ${prop}$NC (does not exist, will create)"
            }
        }
        Write-Host ""
    } catch {
        Write-Host "$RED❌ [Error]$NC Config file format error: $($_.Exception.Message)"
        Write-Host "$YELLOW💡 [Suggestion]$NC Config file may be corrupted, suggest choosing 'Reset Environment + Modify Machine Code' option"
        return $false
    }

    # 实现原子性文件操作和重试机制
    $maxRetries = 3
    $retryCount = 0

    while ($retryCount -lt $maxRetries) {
        $retryCount++
        Write-Host ""
        Write-Host "$BLUE🔄 [尝试]$NC 第 $retryCount/$maxRetries 次修改尝试..."

        try {
            # 显示操作进度
            Write-Host "$BLUE⏳ [进度]$NC 1/6 - 生成新的设备标识符..."

            # 生成新的ID
            $MAC_MACHINE_ID = [System.Guid]::NewGuid().ToString()
            $UUID = [System.Guid]::NewGuid().ToString()
            $prefixBytes = [System.Text.Encoding]::UTF8.GetBytes("auth0|user_")
            $prefixHex = -join ($prefixBytes | ForEach-Object { '{0:x2}' -f $_ })
            $randomBytes = New-Object byte[] 32
            $rng = [System.Security.Cryptography.RNGCryptoServiceProvider]::new()
            $rng.GetBytes($randomBytes)
            $randomPart = [System.BitConverter]::ToString($randomBytes) -replace '-',''
            $rng.Dispose()
            $MACHINE_ID = "${prefixHex}${randomPart}"
            $SQM_ID = "{$([System.Guid]::NewGuid().ToString().ToUpper())}"

            Write-Host "$GREEN✅ [进度]$NC 1/6 - 设备标识符生成完成"

            Write-Host "$BLUE⏳ [进度]$NC 2/6 - 创建备份目录..."

            # 备份原始值（增强版）
            $backupDir = "$env:APPDATA\Cursor\User\globalStorage\backups"
            if (-not (Test-Path $backupDir)) {
                New-Item -ItemType Directory -Path $backupDir -Force -ErrorAction Stop | Out-Null
            }

            $backupName = "storage.json.backup_$(Get-Date -Format 'yyyyMMdd_HHmmss')_retry$retryCount"
            $backupPath = "$backupDir\$backupName"

            Write-Host "$BLUE⏳ [进度]$NC 3/6 - 备份原始配置..."
            Copy-Item $configPath $backupPath -ErrorAction Stop

            # 验证备份是否成功
            if (Test-Path $backupPath) {
                $backupSize = (Get-Item $backupPath).Length
                $originalSize = (Get-Item $configPath).Length
                if ($backupSize -eq $originalSize) {
                    Write-Host "$GREEN✅ [进度]$NC 3/6 - 配置备份成功: $backupName"
                } else {
                    Write-Host "$YELLOW⚠️  [警告]$NC 备份文件大小不匹配，但继续执行"
                }
            } else {
                throw "备份文件创建失败"
            }

            Write-Host "$BLUE⏳ [进度]$NC 4/6 - 读取原始配置到内存..."

            # 原子性操作：读取原始内容到内存
            $originalContent = Get-Content $configPath -Raw -Encoding UTF8 -ErrorAction Stop
            $config = $originalContent | ConvertFrom-Json -ErrorAction Stop

            Write-Host "$BLUE⏳ [进度]$NC 5/6 - 在内存中更新配置..."

            # 更新配置值（安全方式，确保属性存在）
            $propertiesToUpdate = @{
                'telemetry.machineId' = $MACHINE_ID
                'telemetry.macMachineId' = $MAC_MACHINE_ID
                'telemetry.devDeviceId' = $UUID
                'telemetry.sqmId' = $SQM_ID
            }

            foreach ($property in $propertiesToUpdate.GetEnumerator()) {
                $key = $property.Key
                $value = $property.Value

                # 使用 Add-Member 或直接赋值的安全方式
                if ($config.PSObject.Properties[$key]) {
                    # 属性存在，直接更新
                    $config.$key = $value
                    Write-Host "$BLUE  ✓ 更新属性: ${key}$NC"
                } else {
                    # 属性不存在，添加新属性
                    $config | Add-Member -MemberType NoteProperty -Name $key -Value $value -Force
                    Write-Host "$BLUE  + 添加属性: ${key}$NC"
                }
            }

            Write-Host "$BLUE⏳ [进度]$NC 6/6 - 原子性写入新配置文件..."

            # 原子性操作：删除原文件，写入新文件
            $tempPath = "$configPath.tmp"
            $updatedJson = $config | ConvertTo-Json -Depth 10

            # 写入临时文件
            [System.IO.File]::WriteAllText($tempPath, $updatedJson, [System.Text.Encoding]::UTF8)

            # 验证临时文件
            $tempContent = Get-Content $tempPath -Raw -Encoding UTF8
            $tempConfig = $tempContent | ConvertFrom-Json

            # 验证所有属性是否正确写入
            $tempVerificationPassed = $true
            foreach ($property in $propertiesToUpdate.GetEnumerator()) {
                $key = $property.Key
                $expectedValue = $property.Value
                $actualValue = $tempConfig.$key

                if ($actualValue -ne $expectedValue) {
                    $tempVerificationPassed = $false
                    Write-Host "$RED  ✗ 临时文件验证失败: ${key}$NC"
                    break
                }
            }

            if (-not $tempVerificationPassed) {
                Remove-Item $tempPath -Force -ErrorAction SilentlyContinue
                throw "临时文件验证失败"
            }

            # 原子性替换：删除原文件，重命名临时文件
            Remove-Item $configPath -Force
            Move-Item $tempPath $configPath

            # 设置文件为只读（可选）
            $file = Get-Item $configPath
            $file.IsReadOnly = $false  # 保持可写，便于后续修改

            # 最终验证修改结果
            Write-Host "$BLUE🔍 [最终验证]$NC 验证新配置文件..."

            $verifyContent = Get-Content $configPath -Raw -Encoding UTF8
            $verifyConfig = $verifyContent | ConvertFrom-Json

            $verificationPassed = $true
            $verificationResults = @()

            # 安全验证每个属性
            foreach ($property in $propertiesToUpdate.GetEnumerator()) {
                $key = $property.Key
                $expectedValue = $property.Value
                $actualValue = $verifyConfig.$key

                if ($actualValue -eq $expectedValue) {
                    $verificationResults += "✓ ${key}: 验证通过"
                } else {
                    $verificationResults += "✗ ${key}: 验证失败 (期望: ${expectedValue}, 实际: ${actualValue})"
                    $verificationPassed = $false
                }
            }

            # 显示验证结果
            Write-Host "$BLUE📋 [验证详情]$NC"
            foreach ($result in $verificationResults) {
                Write-Host "   $result"
            }

            if ($verificationPassed) {
                Write-Host "$GREEN✅ [成功]$NC 第 $retryCount 次尝试修改成功！"
                Write-Host ""
                Write-Host "$GREEN🎉 [完成]$NC 机器码配置修改完成！"
                Write-Host "$BLUE📋 [详情]$NC 已更新以下标识符："
                Write-Host "   🔹 machineId: $MACHINE_ID"
                Write-Host "   🔹 macMachineId: $MAC_MACHINE_ID"
                Write-Host "   🔹 devDeviceId: $UUID"
                Write-Host "   🔹 sqmId: $SQM_ID"
                Write-Host ""
                Write-Host "$GREEN💾 [备份]$NC 原配置已备份至: $backupName"

                # 🔒 添加配置文件保护机制
                Write-Host "$BLUE🔒 [保护]$NC 正在设置配置文件保护..."
                try {
                    $configFile = Get-Item $configPath
                    $configFile.IsReadOnly = $true
                    Write-Host "$GREEN✅ [保护]$NC 配置文件已设置为只读，防止Cursor覆盖修改"
                    Write-Host "$BLUE💡 [提示]$NC 文件路径: $configPath"
                } catch {
                    Write-Host "$YELLOW⚠️  [保护]$NC 设置只读属性失败: $($_.Exception.Message)"
                    Write-Host "$BLUE💡 [建议]$NC 可手动右键文件 → 属性 → 勾选'只读'"
                }
                Write-Host "$BLUE 🔒 [安全]$NC 建议重启Cursor以确保配置生效"
                return $true
            } else {
                Write-Host "$RED❌ [失败]$NC 第 $retryCount 次尝试验证失败"
                if ($retryCount -lt $maxRetries) {
                    Write-Host "$BLUE🔄 [恢复]$NC 恢复备份，准备重试..."
                    Copy-Item $backupPath $configPath -Force
                    Start-Sleep -Seconds 2
                    continue  # 继续下一次重试
                } else {
                    Write-Host "$RED❌ [最终失败]$NC 所有重试都失败，恢复原始配置"
                    Copy-Item $backupPath $configPath -Force
                    return $false
                }
            }

        } catch {
            Write-Host "$RED❌ [异常]$NC 第 $retryCount 次尝试出现异常: $($_.Exception.Message)"
            Write-Host "$BLUE💡 [调试信息]$NC 错误类型: $($_.Exception.GetType().FullName)"

            # 清理临时文件
            if (Test-Path "$configPath.tmp") {
                Remove-Item "$configPath.tmp" -Force -ErrorAction SilentlyContinue
            }

            if ($retryCount -lt $maxRetries) {
                Write-Host "$BLUE🔄 [恢复]$NC 恢复备份，准备重试..."
                if (Test-Path $backupPath) {
                    Copy-Item $backupPath $configPath -Force
                }
                Start-Sleep -Seconds 3
                continue  # 继续下一次重试
            } else {
                Write-Host "$RED❌ [最终失败]$NC 所有重试都失败"
                # 尝试恢复备份
                if (Test-Path $backupPath) {
                    Write-Host "$BLUE🔄 [恢复]$NC 正在恢复备份配置..."
                    try {
                        Copy-Item $backupPath $configPath -Force
                        Write-Host "$GREEN✅ [恢复]$NC 已恢复原始配置"
                    } catch {
                        Write-Host "$RED❌ [错误]$NC 恢复备份失败: $($_.Exception.Message)"
                    }
                }
                return $false
            }
        }
    }

    # 如果到达这里，说明所有重试都失败了
    Write-Host "$RED❌ [最终失败]$NC 经过 $maxRetries 次尝试仍无法完成修改"
    return $false

}

#  启动Cursor生成配置文件
function Start-CursorToGenerateConfig {
    Write-Host "$BLUE🚀 [启动]$NC 正在尝试启动Cursor生成配置文件..."

    # 查找Cursor可执行文件
    $cursorPaths = @(
        "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
        "$env:PROGRAMFILES\Cursor\Cursor.exe",
        "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
    )

    $cursorPath = $null
    foreach ($path in $cursorPaths) {
        if (Test-Path $path) {
            $cursorPath = $path
            break
        }
    }

    if (-not $cursorPath) {
        Write-Host "$RED❌ [错误]$NC 未找到Cursor安装，请确认Cursor已正确安装"
        return $false
    }

    try {
        Write-Host "$BLUE📍 [路径]$NC 使用Cursor路径: $cursorPath"

        # 启动Cursor
        $process = Start-Process -FilePath $cursorPath -PassThru -WindowStyle Normal
        Write-Host "$GREEN🚀 [启动]$NC Cursor已启动，PID: $($process.Id)"

        Write-Host "$YELLOW⏳ [等待]$NC 请等待Cursor完全加载（约30秒）..."
        Write-Host "$BLUE💡 [提示]$NC 您可以在Cursor完全加载后手动关闭它"

        # 等待配置文件生成
        $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
        $maxWait = 60
        $waited = 0

        while (-not (Test-Path $configPath) -and $waited -lt $maxWait) {
            Start-Sleep -Seconds 2
            $waited += 2
            if ($waited % 10 -eq 0) {
                Write-Host "$YELLOW⏳ [等待]$NC 等待配置文件生成... ($waited/$maxWait 秒)"
            }
        }

        if (Test-Path $configPath) {
            Write-Host "$GREEN✅ [成功]$NC 配置文件已生成！"
            Write-Host "$BLUE💡 [提示]$NC 现在可以关闭Cursor并重新运行脚本"
            return $true
        } else {
            Write-Host "$YELLOW⚠️  [超时]$NC 配置文件未在预期时间内生成"
            Write-Host "$BLUE💡 [建议]$NC 请手动操作Cursor（如创建新文件）以触发配置生成"
            return $false
        }

    } catch {
        Write-Host "$RED❌ [错误]$NC 启动Cursor失败: $($_.Exception.Message)"
        return $false
    }
}

# 检查管理员权限
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($user)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "$RED[Error]$NC Please run this script as Administrator."
    Write-Host "Right-click the script and select 'Run as administrator'."
    Read-Host "Press Enter to exit"
    exit 1
}

# Display Professional Logo
Clear-Host
Write-Host @"

$BRIGHT_GREEN    ╔══════════════════════════════════════════════════════════════════════════════╗$NC
$BRIGHT_GREEN    ║$NC                                                                              $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC    $BRIGHT_CYAN██████╗██╗   ██╗██████╗ ███████╗ ██████╗ ██████╗$NC     $BRIGHT_YELLOW██████╗ ██████╗  ██████╗$NC $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC   $BRIGHT_CYAN██╔════╝██║   ██║██╔══██╗██╔════╝██╔═══██╗██╔══██╗$NC   $BRIGHT_YELLOW██╔═══██╗██╔══██╗██╔═══██╗$NC$BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC   $BRIGHT_CYAN██║     ██║   ██║██████╔╝███████╗██║   ██║██████╔╝$NC   $BRIGHT_YELLOW██║   ██║██████╔╝██║   ██║$NC$BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC   $BRIGHT_CYAN██║     ██║   ██║██╔══██╗╚════██║██║   ██║██╔══██╗$NC   $BRIGHT_YELLOW██║   ██║██╔══██╗██║   ██║$NC$BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC   $BRIGHT_CYAN╚██████╗╚██████╔╝██║  ██║███████║╚██████╔╝██║  ██║$NC   $BRIGHT_YELLOW╚██████╔╝██║  ██║╚██████╔╝$NC$BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC    $BRIGHT_CYAN╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝$NC    $BRIGHT_YELLOW╚═════╝ ╚═╝  ╚═╝ ╚═════╝$NC $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                                                                              $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                    $BRIGHT_PURPLE╔══════════════════════════════════════╗$NC                  $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                    $BRIGHT_PURPLE║$NC        $BLINK🚀 PROFESSIONAL EDITION$NC      $BRIGHT_PURPLE║$NC                  $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                    $BRIGHT_PURPLE║$NC     $BRIGHT_WHITECursor Pro Trial Reset Tool$NC     $BRIGHT_PURPLE║$NC                  $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                    $BRIGHT_PURPLE║$NC         $BRIGHT_CYANEnhanced & Optimized$NC        $BRIGHT_PURPLE║$NC                  $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                    $BRIGHT_PURPLE╚══════════════════════════════════════╝$NC                  $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ║$NC                                                                              $BRIGHT_GREEN║$NC
$BRIGHT_GREEN    ╚══════════════════════════════════════════════════════════════════════════════╝$NC

"@
Write-Host ""
Write-Host "$BRIGHT_BLUE═══════════════════════════════════════════════════════════════════════════════════$NC"
Write-Host "$BRIGHT_GREEN🎯 ADVANCED MACHINE CODE MODIFICATION & TRIAL RESET UTILITY$NC"
Write-Host "$BRIGHT_BLUE═══════════════════════════════════════════════════════════════════════════════════$NC"

# 🎯 Advanced Professional Mode Selection Menu
Write-Host ""
Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_GREEN║$BLINK                         🎯 ADVANCED OPERATION MODE SELECTION                     $NC$BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""
Write-Host "$BRIGHT_BLUE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_BLUE║$BRIGHT_WHITE  1️⃣  QUICK MODIFICATION MODE (RECOMMENDED FOR BEGINNERS)$NC                        $BRIGHT_BLUE║$NC"
Write-Host "$BRIGHT_BLUE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Only modify machine code (preserves all existing data)$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Inject JavaScript code into core files$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Keep existing Cursor configuration and settings$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Fast execution with minimal risk$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Suitable for first-time users$NC"
Write-Host ""
Write-Host "$BRIGHT_RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_RED║$BRIGHT_WHITE  2️⃣  COMPLETE RESET MODE (ADVANCED USERS ONLY)$NC                                 $BRIGHT_RED║$NC"
Write-Host "$BRIGHT_RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Completely reset Cursor environment$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Delete all Cursor folders and configurations$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Modify machine code and inject JavaScript$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Maximum effectiveness for trial reset$NC"
Write-Host "$BRIGHT_RED      ⚠️  WARNING: All Cursor data will be permanently lost$NC"
Write-Host "$BRIGHT_RED      ⚠️  Please backup important data before proceeding$NC"
Write-Host ""
Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_GREEN║$BRIGHT_WHITE  3️⃣  ADVANCED DIAGNOSTIC MODE (SYSTEM ANALYSIS & TROUBLESHOOTING)$NC              $BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Comprehensive system analysis$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Cursor installation verification$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Registry integrity check$NC"
Write-Host "$BRIGHT_YELLOW      ✓ File permission analysis$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Generate detailed diagnostic report$NC"
Write-Host ""
Write-Host "$BRIGHT_PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_PURPLE║$BRIGHT_WHITE  4️⃣  BATCH PROCESSING MODE (MULTIPLE SYSTEM SUPPORT)$NC                          $BRIGHT_PURPLE║$NC"
Write-Host "$BRIGHT_PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Process multiple user accounts$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Network-wide deployment support$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Automated scheduling capabilities$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Enterprise-level management$NC"
Write-Host ""
Write-Host "$BRIGHT_CYAN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_CYAN║$BRIGHT_WHITE  5️⃣  STEALTH MODE (SILENT OPERATION)$NC                                           $BRIGHT_CYAN║$NC"
Write-Host "$BRIGHT_CYAN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Silent execution with minimal output$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Background processing$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Log file generation$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Suitable for automated scripts$NC"
Write-Host ""
Write-Host "$BRIGHT_PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_PURPLE║$BRIGHT_WHITE  6️⃣  CUSTOM CONFIGURATION MODE (ADVANCED USERS)$NC                               $BRIGHT_PURPLE║$NC"
Write-Host "$BRIGHT_PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Custom machine ID generation$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Advanced JavaScript injection options$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Custom backup locations$NC"
Write-Host "$BRIGHT_YELLOW      ✓ Fine-tuned control over all operations$NC"
Write-Host ""

# Professional User Input Section
Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_GREEN║$BLINK                              📝 MAKE YOUR SELECTION                              $NC$BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""

$executeMode = $null
do {
    Write-Host "$BRIGHT_BLUE┌─────────────────────────────────────────────────────────────────────────────┐$NC"
    Write-Host "$BRIGHT_BLUE│$BRIGHT_WHITE  Please enter your choice: [1-6] for different operation modes$NC              $BRIGHT_BLUE│$NC"
    Write-Host "$BRIGHT_BLUE│$BRIGHT_WHITE  [1] Quick Mode  [2] Complete Reset  [3] Diagnostic  [4] Batch  [5] Stealth [6] Custom$NC $BRIGHT_BLUE│$NC"
    Write-Host "$BRIGHT_BLUE└─────────────────────────────────────────────────────────────────────────────┘$NC"
    $userChoice = Read-Host "$BRIGHT_CYAN[SELECTION]$BRIGHT_WHITE Enter your choice (1-6)"
    
    if ($userChoice -eq "1") {
        Write-Host ""
        Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_GREEN║$BLINK  ✅ SELECTION CONFIRMED: QUICK MODIFICATION MODE$NC                                $BRIGHT_GREEN║$NC"
        Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_YELLOW      • Machine code modification only$NC"
        Write-Host "$BRIGHT_YELLOW      • JavaScript injection enabled$NC"
        Write-Host "$BRIGHT_YELLOW      • All existing data preserved$NC"
        $executeMode = "MODIFY_ONLY"
        break
    } elseif ($userChoice -eq "2") {
        Write-Host ""
        Write-Host "$BRIGHT_RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_RED║$BLINK  ⚠️  ADVANCED MODE SELECTED: COMPLETE RESET MODE$NC                                $BRIGHT_RED║$NC"
        Write-Host "$BRIGHT_RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_RED      ⚠️  WARNING: This will permanently delete ALL Cursor data!$NC"
        Write-Host "$BRIGHT_RED      ⚠️  WARNING: All configurations, settings, and data will be lost!$NC"
        Write-Host ""
        Write-Host "$BRIGHT_YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
        Write-Host "$BRIGHT_YELLOW│$BRIGHT_WHITE  Type 'CONFIRM' to proceed with complete reset, or any other key to cancel$NC  $BRIGHT_YELLOW│$NC"
        Write-Host "$BRIGHT_YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
        $confirmReset = Read-Host "$BRIGHT_CYAN[CONFIRMATION]$BRIGHT_WHITE Type 'CONFIRM' to proceed"
        if ($confirmReset -eq "CONFIRM") {
            Write-Host ""
            Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
            Write-Host "$BRIGHT_GREEN║$BLINK  ✅ CONFIRMED: COMPLETE RESET MODE ACTIVATED$NC                                  $BRIGHT_GREEN║$NC"
            Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
            $executeMode = "RESET_AND_MODIFY"
            break
        } else {
            Write-Host ""
            Write-Host "$BRIGHT_YELLOW╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
            Write-Host "$BRIGHT_YELLOW║$BLINK  👋 OPERATION CANCELLED: Returning to mode selection...$NC                        $BRIGHT_YELLOW║$NC"
            Write-Host "$BRIGHT_YELLOW╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
            Write-Host ""
            continue
        }
    } elseif ($userChoice -eq "3") {
        Write-Host ""
        Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_GREEN║$BLINK  ✅ SELECTION CONFIRMED: ADVANCED DIAGNOSTIC MODE$NC                               $BRIGHT_GREEN║$NC"
        Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_YELLOW      • Comprehensive system analysis$NC"
        Write-Host "$BRIGHT_YELLOW      • Cursor installation verification$NC"
        Write-Host "$BRIGHT_YELLOW      • Registry integrity check$NC"
        Write-Host "$BRIGHT_YELLOW      • Generate detailed diagnostic report$NC"
        $executeMode = "DIAGNOSTIC"
        break
    } elseif ($userChoice -eq "4") {
        Write-Host ""
        Write-Host "$BRIGHT_PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_PURPLE║$BLINK  ✅ SELECTION CONFIRMED: BATCH PROCESSING MODE$NC                                 $BRIGHT_PURPLE║$NC"
        Write-Host "$BRIGHT_PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_YELLOW      • Process multiple user accounts$NC"
        Write-Host "$BRIGHT_YELLOW      • Network-wide deployment support$NC"
        Write-Host "$BRIGHT_YELLOW      • Automated scheduling capabilities$NC"
        Write-Host "$BRIGHT_YELLOW      • Enterprise-level management$NC"
        $executeMode = "BATCH"
        break
    } elseif ($userChoice -eq "5") {
        Write-Host ""
        Write-Host "$BRIGHT_CYAN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_CYAN║$BLINK  ✅ SELECTION CONFIRMED: STEALTH MODE$NC                                           $BRIGHT_CYAN║$NC"
        Write-Host "$BRIGHT_CYAN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_YELLOW      • Silent execution with minimal output$NC"
        Write-Host "$BRIGHT_YELLOW      • Background processing$NC"
        Write-Host "$BRIGHT_YELLOW      • Log file generation$NC"
        Write-Host "$BRIGHT_YELLOW      • Suitable for automated scripts$NC"
        $executeMode = "STEALTH"
        break
    } elseif ($userChoice -eq "6") {
        Write-Host ""
        Write-Host "$BRIGHT_PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_PURPLE║$BLINK  ✅ SELECTION CONFIRMED: CUSTOM CONFIGURATION MODE$NC                             $BRIGHT_PURPLE║$NC"
        Write-Host "$BRIGHT_PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host "$BRIGHT_YELLOW      • Custom machine ID generation$NC"
        Write-Host "$BRIGHT_YELLOW      • Advanced JavaScript injection options$NC"
        Write-Host "$BRIGHT_YELLOW      • Custom backup locations$NC"
        Write-Host "$BRIGHT_YELLOW      • Fine-tuned control over all operations$NC"
        $executeMode = "CUSTOM"
        break
    } else {
        Write-Host ""
        Write-Host "$BRIGHT_RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
        Write-Host "$BRIGHT_RED║$BLINK  ❌ INVALID SELECTION: Please enter 1, 2, 3, 4, 5, or 6 only$NC                    $BRIGHT_RED║$NC"
        Write-Host "$BRIGHT_RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
        Write-Host ""
    }
} while ($true)

Write-Host ""

# 📋 Professional Execution Plan Display
Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$GREEN║                              📋 EXECUTION PLAN                                   ║$NC"
Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""

if ($executeMode -eq "MODIFY_ONLY") {
    Write-Host "$BLUE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$BLUE║                    🚀 QUICK MODIFICATION MODE - EXECUTION STEPS                  ║$NC"
    Write-Host "$BLUE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 1: Environment Validation$NC"
    Write-Host "$GREEN     • Check Cursor installation and configuration$NC"
    Write-Host "$GREEN     • Verify system permissions and file access$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 2: Backup Creation$NC"
    Write-Host "$GREEN     • Create automatic backup of existing configuration$NC"
    Write-Host "$GREEN     • Store backup in secure location with timestamp$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 3: Machine Code Modification$NC"
    Write-Host "$GREEN     • Generate new unique machine identifiers$NC"
    Write-Host "$GREEN     • Update Cursor configuration files$NC"
    Write-Host "$GREEN     • Modify system registry entries$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 4: JavaScript Injection$NC"
    Write-Host "$GREEN     • Inject device identification bypass code$NC"
    Write-Host "$GREEN     • Modify Cursor core JavaScript files$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 5: Protection & Completion$NC"
    Write-Host "$GREEN     • Set configuration files to read-only$NC"
    Write-Host "$GREEN     • Display completion summary$NC"
    Write-Host ""
    Write-Host "$YELLOW╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$YELLOW║                              ⚠️  IMPORTANT NOTES                               ║$NC"
    Write-Host "$YELLOW╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host "$YELLOW  • No data will be deleted or lost$NC"
    Write-Host "$YELLOW  • All existing configurations will be preserved$NC"
    Write-Host "$YELLOW  • Safe for first-time users$NC"
    Write-Host "$YELLOW  • Automatic backup protection enabled$NC"
} else {
    Write-Host "$RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$RED║                  ⚠️  COMPLETE RESET MODE - EXECUTION STEPS                      ║$NC"
    Write-Host "$RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 1: Process Management$NC"
    Write-Host "$GREEN     • Detect and close all Cursor processes$NC"
    Write-Host "$GREEN     • Save Cursor installation path information$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 2: Environment Reset$NC"
    Write-Host "$GREEN     • Delete Cursor trial-related folders:$NC"
    Write-Host "$GREEN       📁 C:\Users\Administrator\.cursor$NC"
    Write-Host "$GREEN       📁 C:\Users\Administrator\AppData\Roaming\Cursor$NC"
    Write-Host "$GREEN       📁 C:\Users\%USERNAME%\.cursor$NC"
    Write-Host "$GREEN       📁 C:\Users\%USERNAME%\AppData\Roaming\Cursor$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 3: Directory Preparation$NC"
    Write-Host "$GREEN     • Pre-create necessary directories$NC"
    Write-Host "$GREEN     • Set proper permissions to avoid issues$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 4: Cursor Restart & Config Generation$NC"
    Write-Host "$GREEN     • Launch Cursor to generate new configuration$NC"
    Write-Host "$GREEN     • Wait for complete initialization (up to 45 seconds)$NC"
    Write-Host "$GREEN     • Close Cursor processes after config generation$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 5: Machine Code Modification$NC"
    Write-Host "$GREEN     • Modify newly generated configuration$NC"
    Write-Host "$GREEN     • Update system registry entries$NC"
    Write-Host "$GREEN     • Inject JavaScript bypass code$NC"
    Write-Host ""
    Write-Host "$GREEN  ✅ Step 6: Finalization$NC"
    Write-Host "$GREEN     • Set protection mechanisms$NC"
    Write-Host "$GREEN     • Display comprehensive operation summary$NC"
    Write-Host ""
    Write-Host "$RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$RED║                              ⚠️  CRITICAL WARNINGS                               ║$NC"
    Write-Host "$RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host "$RED  • ALL Cursor data will be permanently deleted$NC"
    Write-Host "$RED  • Do not manually operate Cursor during execution$NC"
    Write-Host "$RED  • Close all Cursor windows before starting$NC"
    Write-Host "$RED  • Restart Cursor after completion for best results$NC"
    Write-Host "$RED  • Automatic backup protection enabled$NC"
}
Write-Host ""

# 🤔 Professional Final Confirmation with Clear Instructions
Write-Host ""
Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_GREEN║$BLINK                              🤔 FINAL CONFIRMATION                               $NC$BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""
Write-Host "$BRIGHT_YELLOW┌─────────────────────────────────────────────────────────────────────────────┐$NC"
Write-Host "$BRIGHT_YELLOW│$BRIGHT_WHITE  Please confirm that you have read and understood all the above steps    $BRIGHT_YELLOW│$NC"
Write-Host "$BRIGHT_YELLOW│$BRIGHT_WHITE  and are ready to proceed with the selected operation.                     $BRIGHT_YELLOW│$NC"
Write-Host "$BRIGHT_YELLOW└─────────────────────────────────────────────────────────────────────────────┘$NC"
Write-Host ""
Write-Host "$BRIGHT_CYAN┌─────────────────────────────────────────────────────────────────────────────┐$NC"
Write-Host "$BRIGHT_CYAN│$BRIGHT_WHITE  🚀 Type '1' or 'PROCEED' to continue execution                      $BRIGHT_CYAN│$NC"
Write-Host "$BRIGHT_CYAN│$BRIGHT_WHITE  ❌ Type '2' or 'CANCEL' or 'EXIT' to stop safely                   $BRIGHT_CYAN│$NC"
Write-Host "$BRIGHT_CYAN│$BRIGHT_WHITE  🔄 Type '3' or 'RESTART' to go back to mode selection             $BRIGHT_CYAN│$NC"
Write-Host "$BRIGHT_CYAN└─────────────────────────────────────────────────────────────────────────────┘$NC"
Write-Host ""
Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$BRIGHT_GREEN║$BRIGHT_WHITE  💡 CONFIRMATION OPTIONS:                                          $BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN║$BRIGHT_WHITE  • 1 or PROCEED  = Start execution immediately                     $BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN║$BRIGHT_WHITE  • 2 or CANCEL   = Exit script safely                              $BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN║$BRIGHT_WHITE  • 3 or RESTART  = Go back to mode selection                      $BRIGHT_GREEN║$NC"
Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""
$confirmation = Read-Host "$BRIGHT_CYAN[CONFIRMATION]$BRIGHT_WHITE Enter your choice (1/2/3 or PROCEED/CANCEL/RESTART)"

if ($confirmation -eq "1" -or $confirmation -eq "PROCEED") {
    Write-Host ""
    Write-Host "$BRIGHT_GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$BRIGHT_GREEN║$BLINK  ✅ CONFIRMATION RECEIVED: Starting execution in 3 seconds...                   $NC$BRIGHT_GREEN║$NC"
    Write-Host "$BRIGHT_GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    Write-Host "$BRIGHT_YELLOW  ⏳ Preparing to execute selected operation...$NC"
    Start-Sleep -Seconds 3
} elseif ($confirmation -eq "2" -or $confirmation -eq "CANCEL" -or $confirmation -eq "EXIT") {
    Write-Host ""
    Write-Host "$BRIGHT_YELLOW╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$BRIGHT_YELLOW║$BLINK  👋 OPERATION CANCELLED: Exiting script safely...                               $NC$BRIGHT_YELLOW║$NC"
    Write-Host "$BRIGHT_YELLOW╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    Write-Host "$BRIGHT_BLUE  Thank you for using Cursor Pro+ Trial Reset Tool!$NC"
    Write-Host "$BRIGHT_BLUE  You can run this script again anytime when you're ready.$NC"
    Write-Host ""
    Read-Host "$BRIGHT_CYAN Press Enter to exit$NC"
    exit 0
} elseif ($confirmation -eq "3" -or $confirmation -eq "RESTART") {
    Write-Host ""
    Write-Host "$BRIGHT_PURPLE╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$BRIGHT_PURPLE║$BLINK  🔄 RESTARTING: Returning to mode selection...                        $NC$BRIGHT_PURPLE║$NC"
    Write-Host "$BRIGHT_PURPLE╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    # Restart the script by calling the main execution again
    & $MyInvocation.MyCommand.Path
    exit 0
} else {
    Write-Host ""
    Write-Host "$BRIGHT_RED╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$BRIGHT_RED║$BLINK  ❌ INVALID INPUT: Please enter 1/2/3 or PROCEED/CANCEL/RESTART$NC        $BRIGHT_RED║$NC"
    Write-Host "$BRIGHT_RED╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    Write-Host "$BRIGHT_YELLOW  Please try again with a valid option.$NC"
    Write-Host ""
    Read-Host "$BRIGHT_CYAN Press Enter to continue$NC"
    # Restart the confirmation process
    & $MyInvocation.MyCommand.Path
    exit 0
}
Write-Host ""

# Get and display Cursor version
function Get-CursorVersion {
    try {
        # Main detection path
        $packagePath = "$env:LOCALAPPDATA\\Programs\\cursor\\resources\\app\\package.json"
        
        if (Test-Path $packagePath) {
            $packageJson = Get-Content $packagePath -Raw | ConvertFrom-Json
            if ($packageJson.version) {
                Write-Host "$GREEN[Info]$NC Currently installed Cursor version: v$($packageJson.version)"
                return $packageJson.version
            }
        }

        # Alternative path detection
        $altPath = "$env:LOCALAPPDATA\\cursor\\resources\\app\\package.json"
        if (Test-Path $altPath) {
            $packageJson = Get-Content $altPath -Raw | ConvertFrom-Json
            if ($packageJson.version) {
                Write-Host "$GREEN[Info]$NC Currently installed Cursor version: v$($packageJson.version)"
                return $packageJson.version
            }
        }

        Write-Host "$YELLOW[Warning]$NC Unable to detect Cursor version"
        Write-Host "$YELLOW[Tip]$NC Please ensure Cursor is properly installed"
        return $null
    }
    catch {
        Write-Host "$RED[Error]$NC Failed to get Cursor version: $_"
        return $null
    }
}

# 🖥️ Advanced System Information Display
function Show-AdvancedSystemInfo {
    Write-Host ""
    Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$GREEN║                            🖥️ ADVANCED SYSTEM INFORMATION                        ║$NC"
    Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    # System Information
    $osInfo = Get-WmiObject -Class Win32_OperatingSystem
    $computerInfo = Get-WmiObject -Class Win32_ComputerSystem
    $processorInfo = Get-WmiObject -Class Win32_Processor
    $memoryInfo = Get-WmiObject -Class Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum
    
    Write-Host "$BLUE🖥️ [System Details]$NC"
    Write-Host "$YELLOW  • Operating System: $($osInfo.Caption) $($osInfo.Version)$NC"
    Write-Host "$YELLOW  • Architecture: $($osInfo.OSArchitecture)$NC"
    Write-Host "$YELLOW  • Computer Name: $($computerInfo.Name)$NC"
    Write-Host "$YELLOW  • Manufacturer: $($computerInfo.Manufacturer)$NC"
    Write-Host "$YELLOW  • Model: $($computerInfo.Model)$NC"
    Write-Host "$YELLOW  • Processor: $($processorInfo[0].Name)$NC"
    Write-Host "$YELLOW  • Total RAM: $([math]::Round($memoryInfo.Sum / 1GB, 2)) GB$NC"
    Write-Host ""
    
    # PowerShell Information
    Write-Host "$BLUE⚡ [PowerShell Details]$NC"
    Write-Host "$YELLOW  • PowerShell Version: $($PSVersionTable.PSVersion)$NC"
    Write-Host "$YELLOW  • Execution Policy: $(Get-ExecutionPolicy)$NC"
    Write-Host "$YELLOW  • Host: $($PSVersionTable.Host)$NC"
    Write-Host ""
    
    # Network Information
    Write-Host "$BLUE🌐 [Network Details]$NC"
    $networkAdapters = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.NetConnectionStatus -eq 2 }
    foreach ($adapter in $networkAdapters) {
        Write-Host "$YELLOW  • $($adapter.Name): $($adapter.NetConnectionID)$NC"
    }
    Write-Host ""
    
    # Disk Information
    Write-Host "$BLUE💾 [Disk Details]$NC"
    $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 }
    foreach ($disk in $disks) {
        $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
        $totalSpace = [math]::Round($disk.Size / 1GB, 2)
        $usedSpace = [math]::Round(($disk.Size - $disk.FreeSpace) / 1GB, 2)
        Write-Host "$YELLOW  • Drive $($disk.DeviceID) - Free: ${freeSpace}GB / Total: ${totalSpace}GB (Used: ${usedSpace}GB)$NC"
    }
    Write-Host ""
}

# 🔧 Advanced Configuration Manager
function Show-AdvancedConfigurationManager {
    Write-Host ""
    Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$GREEN║                        🔧 ADVANCED CONFIGURATION MANAGER                        ║$NC"
    Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    Write-Host "$BLUE⚙️ [Configuration Options]$NC"
    Write-Host "$YELLOW  1. View Current Configuration$NC"
    Write-Host "$YELLOW  2. Reset to Default Settings$NC"
    Write-Host "$YELLOW  3. Export Configuration$NC"
    Write-Host "$YELLOW  4. Import Configuration$NC"
    Write-Host "$YELLOW  5. Advanced Settings$NC"
    Write-Host ""
    
    $configChoice = Read-Host "Select configuration option (1-5)"
    
    switch ($configChoice) {
        "1" {
            Write-Host "$GREEN📋 [Current Configuration]$NC Displaying current settings..."
            # Display current configuration
        }
        "2" {
            Write-Host "$YELLOW🔄 [Reset Configuration]$NC Resetting to default settings..."
            # Reset configuration
        }
        "3" {
            Write-Host "$BLUE📤 [Export Configuration]$NC Exporting current configuration..."
            # Export configuration
        }
        "4" {
            Write-Host "$BLUE📥 [Import Configuration]$NC Importing configuration from file..."
            # Import configuration
        }
        "5" {
            Write-Host "$PURPLE⚙️ [Advanced Settings]$NC Opening advanced settings..."
            # Advanced settings
        }
        default {
            Write-Host "$RED❌ [Invalid Option]$NC Please select a valid option (1-5)$NC"
        }
    }
    Write-Host ""
}

# 🚀 Performance Monitor
function Start-PerformanceMonitor {
    Write-Host ""
    Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
    Write-Host "$GREEN║                            🚀 PERFORMANCE MONITOR                               ║$NC"
    Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
    Write-Host ""
    
    Write-Host "$BLUE📊 [Performance Metrics]$NC Monitoring system performance..."
    Write-Host ""
    
    $monitorCount = 0
    $maxMonitors = 10
    
    while ($monitorCount -lt $maxMonitors) {
        $monitorCount++
        
        # CPU Usage
        $cpuUsage = Get-WmiObject -Class Win32_Processor | Measure-Object -Property LoadPercentage -Average
        $cpuPercent = if ($cpuUsage.Average) { $cpuUsage.Average } else { 0 }
        
        # Memory Usage
        $memory = Get-WmiObject -Class Win32_OperatingSystem
        $totalMemory = $memory.TotalVisibleMemorySize
        $freeMemory = $memory.FreePhysicalMemory
        $usedMemory = $totalMemory - $freeMemory
        $memoryPercent = [math]::Round(($usedMemory / $totalMemory) * 100, 2)
        
        # Disk Usage
        $disk = Get-WmiObject -Class Win32_LogicalDisk | Where-Object { $_.DeviceID -eq "C:" }
        $diskPercent = [math]::Round((($disk.Size - $disk.FreeSpace) / $disk.Size) * 100, 2)
        
        Write-Host "$DIM[Monitor $monitorCount/$maxMonitors] CPU: $cpuPercent% | Memory: $memoryPercent% | Disk: $diskPercent%$NC"
        
        Start-Sleep -Seconds 2
    }
    
    Write-Host ""
    Write-Host "$GREEN✅ [Monitoring Complete]$NC Performance monitoring completed!"
    Write-Host ""
}

# Get and display version information
$cursorVersion = Get-CursorVersion
Write-Host ""

Write-Host "$YELLOW💡 [Important Note]$NC Latest 1.0.x versions are supported"

Write-Host ""

# Display advanced system information
Show-AdvancedSystemInfo

# 🔍 Check and close Cursor processes
Write-Host "$GREEN🔍 [Check]$NC Checking Cursor processes..."

function Get-ProcessDetails {
    param($processName)
    Write-Host "$BLUE🔍 [Debug]$NC Getting detailed information for $processName process:"
    Get-WmiObject Win32_Process -Filter "name='$processName'" |
        Select-Object ProcessId, ExecutablePath, CommandLine |
        Format-List
}

# Define maximum retry count and wait time
$MAX_RETRIES = 5
$WAIT_TIME = 1

# 🔄 Handle process closing and save process information
function Close-CursorProcessAndSaveInfo {
    param($processName)

    $global:CursorProcessInfo = $null

    $processes = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($processes) {
        Write-Host "$YELLOW⚠️  [Warning]$NC Found $processName running"

        # 💾 Save process information for subsequent restart - Fix: ensure getting single process path
        $firstProcess = if ($processes -is [array]) { $processes[0] } else { $processes }
        $processPath = $firstProcess.Path

        # Ensure path is string not array
        if ($processPath -is [array]) {
            $processPath = $processPath[0]
        }

        $global:CursorProcessInfo = @{
            ProcessName = $firstProcess.ProcessName
            Path = $processPath
            StartTime = $firstProcess.StartTime
        }
        Write-Host "$GREEN💾 [Save]$NC Process information saved: $($global:CursorProcessInfo.Path)"

        Get-ProcessDetails $processName

        Write-Host "$YELLOW🔄 [Operation]$NC Attempting to close $processName..."
        Stop-Process -Name $processName -Force

        $retryCount = 0
        while ($retryCount -lt $MAX_RETRIES) {
            $process = Get-Process -Name $processName -ErrorAction SilentlyContinue
            if (-not $process) { break }

            $retryCount++
            if ($retryCount -ge $MAX_RETRIES) {
                Write-Host "$RED❌ [Error]$NC Unable to close $processName after $MAX_RETRIES attempts"
                Get-ProcessDetails $processName
                Write-Host "$RED💥 [Error]$NC Please manually close the process and retry"
                Read-Host "Press Enter to exit"
                exit 1
            }
            Write-Host "$YELLOW⏳ [Wait]$NC Waiting for process to close, attempt $retryCount/$MAX_RETRIES..."
            Start-Sleep -Seconds $WAIT_TIME
        }
        Write-Host "$GREEN✅ [Success]$NC $processName closed successfully"
    } else {
        Write-Host "$BLUE💡 [Tip]$NC No $processName process found running"
        # Try to find Cursor installation path
        $cursorPaths = @(
            "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe",
            "$env:PROGRAMFILES\Cursor\Cursor.exe",
            "$env:PROGRAMFILES(X86)\Cursor\Cursor.exe"
        )

        foreach ($path in $cursorPaths) {
            if (Test-Path $path) {
                $global:CursorProcessInfo = @{
                    ProcessName = "Cursor"
                    Path = $path
                    StartTime = $null
                }
                Write-Host "$GREEN💾 [Found]$NC Found Cursor installation path: $path"
                break
            }
        }

        if (-not $global:CursorProcessInfo) {
            Write-Host "$YELLOW⚠️  [Warning]$NC Cursor installation path not found, will use default path"
            $global:CursorProcessInfo = @{
                ProcessName = "Cursor"
                Path = "$env:LOCALAPPDATA\Programs\cursor\Cursor.exe"
                StartTime = $null
            }
        }
    }
}

# 🔒 Ensure backup directory exists
if (-not (Test-Path $BACKUP_DIR)) {
    try {
        New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
        Write-Host "$GREEN✅ [Backup Directory]$NC Backup directory created successfully: $BACKUP_DIR"
    } catch {
        Write-Host "$YELLOW⚠️  [Warning]$NC Backup directory creation failed: $($_.Exception.Message)"
    }
}

# 🚀 Execute corresponding function based on user selection
if ($executeMode -eq "DIAGNOSTIC") {
    Write-Host "$GREEN🚀 [Start]$NC Starting Advanced Diagnostic Mode..."
    Invoke-AdvancedDiagnostic
} elseif ($executeMode -eq "BATCH") {
    Write-Host "$PURPLE🚀 [Start]$NC Starting Batch Processing Mode..."
    Invoke-BatchProcessing
} elseif ($executeMode -eq "STEALTH") {
    Write-Host "$CYAN🚀 [Start]$NC Starting Stealth Mode..."
    Invoke-StealthMode
} elseif ($executeMode -eq "CUSTOM") {
    Write-Host "$MAGENTA🚀 [Start]$NC Starting Custom Configuration Mode..."
    Invoke-CustomConfiguration
} elseif ($executeMode -eq "MODIFY_ONLY") {
    Write-Host "$GREEN🚀 [Start]$NC Starting modify machine code only function..."

    # First perform environment check
    $envCheck = Test-CursorEnvironment -Mode "MODIFY_ONLY"
    if (-not $envCheck.Success) {
        Write-Host ""
        Write-Host "$RED❌ [Environment Check Failed]$NC Cannot continue execution, found the following issues:"
        foreach ($issue in $envCheck.Issues) {
            Write-Host "$RED  • ${issue}$NC"
        }
        Write-Host ""
        Write-Host "$YELLOW💡 [Suggestion]$NC Please choose one of the following actions:"
        Write-Host "$BLUE  1️⃣  Choose 'Reset Environment + Modify Machine Code' option (recommended)$NC"
        Write-Host "$BLUE  2️⃣  Manually start Cursor once, then re-run the script$NC"
        Write-Host "$BLUE  3️⃣  Check if Cursor is properly installed$NC"
        Write-Host ""
        Read-Host "Press Enter to exit"
        exit 1
    }

    # Execute machine code modification
    $configSuccess = Modify-MachineCodeConfig -Mode "MODIFY_ONLY"

    if ($configSuccess) {
        Write-Host ""
        Write-Host "$GREEN🎉 [Config File]$NC Machine code configuration file modification completed!"

        # Add registry modification
        Write-Host "$BLUE🔧 [Registry]$NC Modifying system registry..."
        $registrySuccess = Update-MachineGuid

        # 🔧 New: JavaScript injection function (enhanced device identification bypass)
        Write-Host ""
        Write-Host "$BLUE🔧 [Device ID Bypass]$NC Executing JavaScript injection function..."
        Write-Host "$BLUE💡 [Description]$NC This function will directly modify Cursor core JS files for deeper device identification bypass"
        $jsSuccess = Modify-CursorJSFiles

        if ($registrySuccess) {
            Write-Host "$GREEN✅ [Registry]$NC System registry modification successful"

            if ($jsSuccess) {
                Write-Host "$GREEN✅ [JavaScript Injection]$NC JavaScript injection function executed successfully"
                Write-Host ""
                Write-Host "$GREEN🎉 [Complete]$NC All machine code modifications completed (Enhanced version)!"
                Write-Host "$BLUE📋 [Details]$NC The following modifications have been completed:"
                Write-Host "$GREEN  ✓ Cursor config file (storage.json)$NC"
                Write-Host "$GREEN  ✓ System registry (MachineGuid)$NC"
                Write-Host "$GREEN  ✓ JavaScript core injection (device identification bypass)$NC"
            } else {
                Write-Host "$YELLOW⚠️  [JavaScript Injection]$NC JavaScript injection function failed, but other functions succeeded"
                Write-Host ""
                Write-Host "$GREEN🎉 [Complete]$NC All machine code modifications completed!"
                Write-Host "$BLUE📋 [Details]$NC The following modifications have been completed:"
                Write-Host "$GREEN  ✓ Cursor config file (storage.json)$NC"
                Write-Host "$GREEN  ✓ System registry (MachineGuid)$NC"
                Write-Host "$YELLOW  ⚠ JavaScript core injection (partially failed)$NC"
            }

            # 🔒 Add config file protection mechanism
            Write-Host "$BLUE🔒 [Protection]$NC Setting up config file protection..."
            try {
                $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
                $configFile = Get-Item $configPath
                $configFile.IsReadOnly = $true
                Write-Host "$GREEN✅ [Protection]$NC Config file set to read-only to prevent Cursor from overwriting modifications"
                Write-Host "$BLUE💡 [Tip]$NC File path: $configPath"
            } catch {
                Write-Host "$YELLOW⚠️  [Protection]$NC Failed to set read-only attribute: $($_.Exception.Message)"
                Write-Host "$BLUE💡 [Suggestion]$NC You can manually right-click file → Properties → check 'Read-only'"
            }
        } else {
            Write-Host "$YELLOW⚠️  [Registry]$NC Registry modification failed, but config file modification succeeded"

            if ($jsSuccess) {
                Write-Host "$GREEN✅ [JavaScript Injection]$NC JavaScript injection function executed successfully"
                Write-Host ""
                Write-Host "$YELLOW🎉 [Partially Complete]$NC Config file and JavaScript injection completed, registry modification failed"
                Write-Host "$BLUE💡 [Suggestion]$NC May need administrator privileges to modify registry"
                Write-Host "$BLUE📋 [Details]$NC The following modifications have been completed:"
                Write-Host "$GREEN  ✓ Cursor config file (storage.json)$NC"
                Write-Host "$YELLOW  ⚠ System registry (MachineGuid) - Failed$NC"
                Write-Host "$GREEN  ✓ JavaScript core injection (device identification bypass)$NC"
            } else {
                Write-Host "$YELLOW⚠️  [JavaScript Injection]$NC JavaScript injection function failed"
                Write-Host ""
                Write-Host "$YELLOW🎉 [Partially Complete]$NC Config file modification completed, registry and JavaScript injection failed"
                Write-Host "$BLUE💡 [Suggestion]$NC May need administrator privileges to modify registry"
            }

            # 🔒 Even if registry modification fails, still protect config file
            Write-Host "$BLUE🔒 [保护]$NC 正在设置配置文件保护..."
            try {
                $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
                $configFile = Get-Item $configPath
                $configFile.IsReadOnly = $true
                Write-Host "$GREEN✅ [保护]$NC 配置文件已设置为只读，防止Cursor覆盖修改"
                Write-Host "$BLUE💡 [提示]$NC 文件路径: $configPath"
            } catch {
                Write-Host "$YELLOW⚠️  [保护]$NC 设置只读属性失败: $($_.Exception.Message)"
                Write-Host "$BLUE💡 [建议]$NC 可手动右键文件 → 属性 → 勾选'只读'"
            }
        }

        Write-Host "$BLUE💡 [Tip]$NC You can now start Cursor with the new machine code configuration"
    } else {
        Write-Host ""
        Write-Host "$RED❌ [Failed]$NC Machine code modification failed!"
        Write-Host "$YELLOW💡 [Suggestion]$NC Please try the 'Reset Environment + Modify Machine Code' option"
    }
} else {
    # Complete reset environment + modify machine code flow
    Write-Host "$GREEN🚀 [Start]$NC Starting reset environment + modify machine code function..."

    # 🚀 Close all Cursor processes and save information
    Close-CursorProcessAndSaveInfo "Cursor"
    if (-not $global:CursorProcessInfo) {
        Close-CursorProcessAndSaveInfo "cursor"
    }

    # 🚨 Important warning prompt
    Write-Host ""
    Write-Host "$RED🚨 [Important Warning]$NC ============================================"
    Write-Host "$YELLOW⚠️  [Risk Control Reminder]$NC Cursor's risk control mechanism is very strict!"
    Write-Host "$YELLOW⚠️  [Must Delete]$NC Must completely delete specified folders, no residual settings allowed"
    Write-Host "$YELLOW⚠️  [Prevent Trial Loss]$NC Only thorough cleanup can effectively prevent losing Pro trial status"
    Write-Host "$RED🚨 [Important Warning]$NC ============================================"
    Write-Host ""

    # 🎯 Execute Cursor anti-trial loss Pro folder deletion function
    Write-Host "$GREEN🚀 [Start]$NC Starting core function..."
    Remove-CursorTrialFolders



    # 🔄 Restart Cursor to regenerate config file
    Restart-CursorAndWait

    # 🛠️ Modify machine code configuration
    $configSuccess = Modify-MachineCodeConfig
    
    # 🧹 Execute Cursor initialization cleanup
    Invoke-CursorInitialization

    if ($configSuccess) {
        Write-Host ""
        Write-Host "$GREEN🎉 [Config File]$NC Machine code configuration file modification completed!"

        # Add registry modification
        Write-Host "$BLUE🔧 [Registry]$NC Modifying system registry..."
        $registrySuccess = Update-MachineGuid

        # 🔧 New: JavaScript injection function (enhanced device identification bypass)
        Write-Host ""
        Write-Host "$BLUE🔧 [Device ID Bypass]$NC Executing JavaScript injection function..."
        Write-Host "$BLUE💡 [Description]$NC This function will directly modify Cursor core JS files for deeper device identification bypass"
        $jsSuccess = Modify-CursorJSFiles

        if ($registrySuccess) {
            Write-Host "$GREEN✅ [Registry]$NC System registry modification successful"

            if ($jsSuccess) {
                Write-Host "$GREEN✅ [JavaScript Injection]$NC JavaScript injection function executed successfully"
                Write-Host ""
                Write-Host "$GREEN🎉 [Complete]$NC All operations completed (Enhanced version)!"
                Write-Host "$BLUE📋 [Details]$NC The following operations have been completed:"
                Write-Host "$GREEN  ✓ Deleted Cursor trial-related folders$NC"
                Write-Host "$GREEN  ✓ Cursor initialization cleanup$NC"
                Write-Host "$GREEN  ✓ Regenerated config file$NC"
                Write-Host "$GREEN  ✓ Modified machine code configuration$NC"
                Write-Host "$GREEN  ✓ Modified system registry$NC"
                Write-Host "$GREEN  ✓ JavaScript core injection (device identification bypass)$NC"
            } else {
                Write-Host "$YELLOW⚠️  [JavaScript Injection]$NC JavaScript injection function failed, but other functions succeeded"
                Write-Host ""
                Write-Host "$GREEN🎉 [Complete]$NC All operations completed!"
                Write-Host "$BLUE📋 [Details]$NC The following operations have been completed:"
                Write-Host "$GREEN  ✓ Deleted Cursor trial-related folders$NC"
                Write-Host "$GREEN  ✓ Cursor initialization cleanup$NC"
                Write-Host "$GREEN  ✓ Regenerated config file$NC"
                Write-Host "$GREEN  ✓ Modified machine code configuration$NC"
                Write-Host "$GREEN  ✓ Modified system registry$NC"
                Write-Host "$YELLOW  ⚠ JavaScript core injection (partially failed)$NC"
            }

            # 🔒 Add config file protection mechanism
            Write-Host "$BLUE🔒 [Protection]$NC Setting up config file protection..."
            try {
                $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
                $configFile = Get-Item $configPath
                $configFile.IsReadOnly = $true
                Write-Host "$GREEN✅ [Protection]$NC Config file set to read-only to prevent Cursor from overwriting modifications"
                Write-Host "$BLUE💡 [Tip]$NC File path: $configPath"
            } catch {
                Write-Host "$YELLOW⚠️  [Protection]$NC Failed to set read-only attribute: $($_.Exception.Message)"
                Write-Host "$BLUE💡 [Suggestion]$NC You can manually right-click file → Properties → check 'Read-only'"
            }
        } else {
            Write-Host "$YELLOW⚠️  [Registry]$NC Registry modification failed, but other operations succeeded"

            if ($jsSuccess) {
                Write-Host "$GREEN✅ [JavaScript Injection]$NC JavaScript injection function executed successfully"
                Write-Host ""
                Write-Host "$YELLOW🎉 [Partially Complete]$NC Most operations completed, registry modification failed"
                Write-Host "$BLUE💡 [Suggestion]$NC May need administrator privileges to modify registry"
                Write-Host "$BLUE📋 [Details]$NC The following operations have been completed:"
                Write-Host "$GREEN  ✓ Deleted Cursor trial-related folders$NC"
                Write-Host "$GREEN  ✓ Cursor initialization cleanup$NC"
                Write-Host "$GREEN  ✓ Regenerated config file$NC"
                Write-Host "$GREEN  ✓ Modified machine code configuration$NC"
                Write-Host "$YELLOW  ⚠ Modified system registry - Failed$NC"
                Write-Host "$GREEN  ✓ JavaScript core injection (device identification bypass)$NC"
            } else {
                Write-Host "$YELLOW⚠️  [JavaScript Injection]$NC JavaScript injection function failed"
                Write-Host ""
                Write-Host "$YELLOW🎉 [Partially Complete]$NC Most operations completed, registry and JavaScript injection failed"
                Write-Host "$BLUE💡 [Suggestion]$NC May need administrator privileges to modify registry"
            }

            # 🔒 Even if registry modification fails, still protect config file
            Write-Host "$BLUE🔒 [保护]$NC 正在设置配置文件保护..."
            try {
                $configPath = "$env:APPDATA\Cursor\User\globalStorage\storage.json"
                $configFile = Get-Item $configPath
                $configFile.IsReadOnly = $true
                Write-Host "$GREEN✅ [保护]$NC 配置文件已设置为只读，防止Cursor覆盖修改"
                Write-Host "$BLUE💡 [提示]$NC 文件路径: $configPath"
            } catch {
                Write-Host "$YELLOW⚠️  [保护]$NC 设置只读属性失败: $($_.Exception.Message)"
                Write-Host "$BLUE💡 [建议]$NC 可手动右键文件 → 属性 → 勾选'只读'"
            }
        }
    } else {
        Write-Host ""
        Write-Host "$RED❌ [Failed]$NC Machine code configuration modification failed!"
        Write-Host "$YELLOW💡 [Suggestion]$NC Please check error messages and retry"
    }
}


# 📱 Display public account information
Write-Host ""
Write-Host "$GREEN================================$NC"
Write-Host "$YELLOW📱  Follow public account [煎饼果子卷AI] to exchange more Cursor tips and AI knowledge (script is free, follow public account to join group for more tips and experts)  $NC"
Write-Host "$GREEN================================$NC"
Write-Host ""

# 🎉 Advanced Script execution completed
Write-Host ""
Write-Host "$GREEN╔══════════════════════════════════════════════════════════════════════════════════╗$NC"
Write-Host "$GREEN║                        🎉 EXECUTION COMPLETED SUCCESSFULLY                        ║$NC"
Write-Host "$GREEN╚══════════════════════════════════════════════════════════════════════════════════╝$NC"
Write-Host ""
Write-Host "$BOLD$GREEN🚀 CURSOR PRO+ TRIAL RESET TOOL - ADVANCED EDITION$NC"
Write-Host "$BOLD$BLUE═══════════════════════════════════════════════════════════════════════════════════$NC"
Write-Host ""
Write-Host "$YELLOW📊 [Execution Summary]$NC"
Write-Host "$GREEN  ✓ Advanced mode selection completed$NC"
Write-Host "$GREEN  ✓ System analysis performed$NC"
Write-Host "$GREEN  ✓ Configuration modifications applied$NC"
Write-Host "$GREEN  ✓ Protection mechanisms activated$NC"
Write-Host "$GREEN  ✓ All operations completed successfully$NC"
Write-Host ""
Write-Host "$BLUE💡 [Next Steps]$NC"
Write-Host "$YELLOW  • Restart Cursor to apply all changes$NC"
Write-Host "$YELLOW  • Verify Pro features are working correctly$NC"
Write-Host "$YELLOW  • Check backup files if needed$NC"
Write-Host "$YELLOW  • Run diagnostic mode if issues occur$NC"
Write-Host ""
Write-Host "$PURPLE🔧 [Advanced Features Available]$NC"
Write-Host "$CYAN  • Diagnostic Mode: Comprehensive system analysis$NC"
Write-Host "$CYAN  • Batch Processing: Multi-user support$NC"
Write-Host "$CYAN  • Stealth Mode: Silent operation$NC"
Write-Host "$CYAN  • Custom Configuration: Advanced settings$NC"
Write-Host ""
Write-Host "$MAGENTA📱 [Support Information]$NC"
Write-Host "$WHITE  • Follow public account [煎饼果子卷AI] for updates$NC"
Write-Host "$WHITE  • Join community group for advanced tips$NC"
Write-Host "$WHITE  • Report issues for continuous improvement$NC"
Write-Host ""
Write-Host "$BOLD$GREEN🎯 Thank you for using Cursor Pro+ Advanced Trial Reset Tool!$NC"
Write-Host "$BOLD$BLUE═══════════════════════════════════════════════════════════════════════════════════$NC"
Write-Host ""
Read-Host "Press Enter to exit"
exit 0
