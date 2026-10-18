# Antigravity Global Configuration (r2s2)

Repositório pessoal de configurações globais, plugins, regras e servidores MCP para o Google Antigravity.

## Conteúdo Versionado
- global_workflows/: Workflows globais reutilizáveis
- plugins/: Plugins e skills globais instalados
- mcp_config.json: Servidores MCP (Model Context Protocol)
- config.json: Configurações gerais da IDE

## Como Restaurar em uma Nova Máquina
No PowerShell:
```powershell
cd $HOME\.gemini
git clone https://github.com/r2s2/antigravity-config.git config
```

## Como Sincronizar Novas Alterações
```powershell
cd $HOME\.gemini\config
git add .
git commit -m "feat(config): atualiza configuracoes globais"
git push
```
