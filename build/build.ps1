param (
	[switch]$Debug,
	[string]$VisualStudioVersion = "12.0"
)

# build the solution
$SolutionPath = "..\System.Net.Http\System.Net.Http-net_4_5.sln"

# make sure the script was run from the expected path
if (!(Test-Path $SolutionPath)) {
	$host.ui.WriteErrorLine('The script was run from an invalid working directory.')
	exit 1
}

. .\version.ps1

If ($Debug) {
	$BuildConfig = 'Debug'
} Else {
	$BuildConfig = 'Release'
}

# build the main project
$msbuild = "$env:windir\Microsoft.NET\Framework64\v4.0.30319\msbuild.exe"

&$msbuild '/nologo' '/m' '/nr:false' '/t:rebuild' "/p:Configuration=$BuildConfig" "/p:VisualStudioVersion=$VisualStudioVersion" $SolutionPath
if ($LASTEXITCODE -ne 0) {
	$host.ui.WriteErrorLine('Build failed, aborting!')
	exit $p.ExitCode
}

if (-not (Test-Path 'nuget')) {
	mkdir "nuget"
}

..\System.Net.Http\.nuget\NuGet.exe 'pack' '..\System.Net.Http\Rackspace.HttpClient35.nuspec' '-OutputDirectory' 'nuget' '-Prop' "Configuration=$BuildConfig" '-Version' "$Version" '-Symbols'
