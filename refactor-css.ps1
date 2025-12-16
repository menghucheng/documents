# CSS目录文档重构脚本

$cssPath = "frontend/css"

# 定义CSS目录下的所有子文件夹
$cssSubDirs = @(
    "动画与过渡",
    "响应式设计",
    "基础概念",
    "最佳实践",
    "盒模型",
    "语法",
    "选择器"
)

foreach ($subDir in $cssSubDirs) {
    $sourcePath = Join-Path -Path $cssPath -ChildPath "$subDir\$subDir.md"
    $destPath = Join-Path -Path $cssPath -ChildPath "$subDir.md"
    $dirPath = Join-Path -Path $cssPath -ChildPath $subDir
    
    Write-Host "移动文件: $sourcePath -> $destPath"
    Move-Item -Path $sourcePath -Destination $destPath -Force
    
    Write-Host "删除空文件夹: $dirPath"
    Remove-Item -Path $dirPath -Force
}

Write-Host "\nCSS目录重构完成!"
