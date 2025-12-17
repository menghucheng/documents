# 简单的文档重构脚本

$frontendPath = "frontend"

# 手动处理每个主要目录
$directories = @(
    "angularjs",
    "css",
    "html",
    "javascript",
    "markdown",
    "nextjs",
    "tools",
    "wechat-miniprogram"
)

foreach ($dir in $directories) {
    $fullPath = Join-Path -Path $frontendPath -ChildPath $dir
    
    if (Test-Path -Path $fullPath -PathType Container) {
        # 获取该目录下的所有子文件夹
        $subDirs = Get-ChildItem -Path $fullPath -Directory
        
        foreach ($subDir in $subDirs) {
            # 获取子文件夹中的文件
            $files = Get-ChildItem -Path $subDir.FullName -File
            
            if ($files.Count -eq 1) {
                # 只有单个文件，移动到父目录
                $file = $files[0]
                $newPath = Join-Path -Path $fullPath -ChildPath $file.Name
                
                Write-Host "Moving: $($file.FullName) -> $newPath"
                Move-Item -Path $file.FullName -Destination $newPath -Force
                
                # 删除空文件夹
                Remove-Item -Path $subDir.FullName -Force
            }
        }
    }
}

Write-Host "Refactor completed!"
