# 重构文档结构：将单个文件从子文件夹移动到父目录

$rootPath = Resolve-Path "./frontend"

# 获取所有只有单个文件的文件夹
$folders = Get-ChildItem -Path $rootPath -Recurse -Directory | Where-Object { 
    (Get-ChildItem -Path $_.FullName -File | Measure-Object).Count -eq 1 
}

foreach ($folder in $folders) {
    # 获取文件夹中的文件
    $file = Get-ChildItem -Path $folder.FullName -File
    
    # 提取父目录
    $parentFolder = Split-Path -Path $folder.FullName -Parent
    
    # 构建新的文件路径（保留原始文件名）
    $newFilePath = Join-Path -Path $parentFolder -ChildPath $file.Name
    
    Write-Host "移动文件：$($file.FullName) -> $newFilePath"
    
    # 移动文件
    Move-Item -Path $file.FullName -Destination $newFilePath -Force
    
    # 删除空文件夹
    Remove-Item -Path $folder.FullName -Force
}

Write-Host "重构完成！"
