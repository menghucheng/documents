# 带调试信息的文档重构脚本

$frontendPath = "frontend"

Write-Host "=== 开始重构文档结构 ==="
Write-Host "前端目录: $frontendPath"
Write-Host "目录是否存在: $(Test-Path -Path $frontendPath -PathType Container)"

# 获取frontend目录下的所有直接子目录
$directories = Get-ChildItem -Path $frontendPath -Directory
Write-Host "\n frontend目录下的子目录:"
foreach ($dir in $directories) {
    Write-Host "  - $($dir.Name)"
}

foreach ($dir in $directories) {
    $fullPath = $dir.FullName
    Write-Host "\n=== 处理目录: $fullPath ==="
    
    # 获取该目录下的所有子文件夹
    $subDirs = Get-ChildItem -Path $fullPath -Directory
    Write-Host "  子文件夹数量: $($subDirs.Count)"
    
    foreach ($subDir in $subDirs) {
        Write-Host "\n  处理子文件夹: $($subDir.Name)"
        
        # 获取子文件夹中的文件
        $files = Get-ChildItem -Path $subDir.FullName -File
        Write-Host "    文件数量: $($files.Count)"
        
        foreach ($file in $files) {
            Write-Host "    文件: $($file.Name)"
        }
        
        if ($files.Count -eq 1) {
            # 只有单个文件，移动到父目录
            $file = $files[0]
            $newPath = Join-Path -Path $fullPath -ChildPath $file.Name
            
            Write-Host "    移动到: $newPath"
            Write-Host "    执行命令: Move-Item -Path '$($file.FullName)' -Destination '$newPath' -Force"
            
            # 移动文件
            Move-Item -Path $file.FullName -Destination $newPath -Force
            
            # 删除空文件夹
            Write-Host "    删除空文件夹: $($subDir.FullName)"
            Remove-Item -Path $subDir.FullName -Force
            Write-Host "    ✅ 完成!"
        }
    }
}

Write-Host "\n=== 重构完成! ==="
