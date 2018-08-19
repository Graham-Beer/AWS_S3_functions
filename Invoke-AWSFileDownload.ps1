
filter Invoke-AWSFileDownload {
    [CmdletBinding()]
    param (
        [parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [Amazon.S3.Model.S3Object] $AWSFiles,

        [parameter()]
        [System.IO.DirectoryInfo] $Destination
    )
    try {
        $AWSFiles | ForEach-Object {
            $downLoad = @{
                File = '{0}\{1}' -f $Destination, ($_.Key -split '/')[-1]
            }
            $null = $_ | Read-S3Object @downLoad
        }
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}