# Note: these values may only change during minor release
$Keys = @{
	'net35' = '96b63ce1c6ee6e39'
}

function Resolve-FullPath() {
	param([string]$Path)
	[System.IO.Path]::GetFullPath((Join-Path (pwd) $Path))
}
