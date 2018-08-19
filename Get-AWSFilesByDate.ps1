filter Get-AWSFilesByDate {
    [CmdletBinding()]
    [OutputType([Amazon.S3.Model.S3Object])]
    param (
        [parameter()]
        [String] $Bucket,

        [parameter()]
        [String] $Prefix,

        [Parameter()]
        [scriptblock] $Filter = {
            $_.LastModified -lt (Get-Date) -and $_.LastModified -ge (Get-Date).AddHours(-4)
        }
    )
    if ($bucket | Test-S3Bucket) {
        Get-S3Bucket -BucketName $Bucket |
            Get-S3Object -KeyPrefix $Prefix |
            Where-Object { [IO.Path]::GetExtension($_.Key) } |
            Where-Object $Filter
    }
    else {
        Throw "Bucket $Bucket does not exist"
    }
}