param (
    [string]$Mensagem = "feat(config): atualiza configuracoes globais do antigravity"
)

$configDir = "$HOME\.gemini\config"
Set-Location $configDir

Write-Host "Verificando alteracoes em $configDir..." -ForegroundColor Cyan
git add .
$status = git status --porcelain
if ($status) {
    git commit -m $Mensagem
    git push origin main
    Write-Host "Configuracoes sincronizadas com sucesso no GitHub!" -ForegroundColor Green
} else {
    Write-Host "Nenhuma alteracao detectada. Tudo ja esta atualizado." -ForegroundColor Yellow
}
