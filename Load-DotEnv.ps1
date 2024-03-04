<#
.SYNOPSIS
This PowerShell script is designed to load environment variables from a file, typically named .env. This is a common practice in software development to manage environment-specific settings.


.DESCRIPTION
The script starts by defining a parameter $Path with a default value of .env. This parameter represents the path to the file containing the environment variables.

.PARAMETER Path
This parameter represents the Path in which the .env file is located. If no value is provided, the script will default to the current directory.

.EXAMPLE
Load-DotEnv.ps1 -Path "C:\path\to\file\.env"

.NOTES
Author: Sergio Madrigal
Date: 04/03/2024
Version: 1.0
#>


param (
    [string]$Path = ".env"
)

if (Test-Path $Path) {
    Get-Content $Path | ForEach-Object {
        if ($_ -match '^\s*#') {
            return
        }

        $keyValue = $_ -split '=', 2
        if ($keyValue.Count -eq 2) {
            $key = $keyValue[0].Trim()
            $value = $keyValue[1].Trim()
            [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
            Write-Host "Loaded env variable: $key"
        }
    }
} else {
    Write-Error "The file '$Path' does not exist."
}
