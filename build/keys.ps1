# Note: these values may only change during major release

If ($Version.Contains('-')) {

	# Use the development keys
	$Keys = @{
		'net35' = 'c2814533e73a79ce'
	}

} Else {

	# Use the final release keys
	$Keys = @{
		'net35' = '9f4d6a8a33d00520'
	}

}

function Resolve-FullPath() {
	param([string]$Path)
	[System.IO.Path]::GetFullPath((Join-Path (pwd) $Path))
}
