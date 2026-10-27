---
name: context-management
description: >-
  Aplica as melhores práticas empíricas de gerenciamento de contexto para agentes de código (T4: Elisão, Recall e Sumarização).
  Use quando o contexto estiver crescendo além dos limites, ao inspecionar históricos longos, ao projetar harnesses de execução,
  ou quando for necessário comprimir saídas volumosas de ferramentas e manter resumos incrementais de progresso.
---

# Context Management for Coding Agents (T4 Staged Policy)

Esta skill orienta o Antigravity a gerenciar o histórico de conversação e ferramentas de acordo com a arquitetura **T4 (Staged Elision + Recall + Summarization)** comprovada no artigo *"An Empirical Study of Harness Design for Coding Agents"* (Fan et al., 2026).

## Princípios Centrais

1. **Zoneamento do Histórico**:
   - **Preamble (Imutável)**: System prompt, regras de segurança, esquemas de ferramentas e a descrição original da tarefa.
   - **Middle Region ($M$, Compactável)**: Turnos intermediários de exploração, leituras e comandos antigos. Esta é a única região sujeita a corte.
   - **Recent Window (Verbatim)**: Preserva rigorosamente as últimas rodadas (mínimo de 2 turnos inteiros ou até 30% da janela utilizável) com fidelidade absoluta de tokens.

2. **Estágio 1 — Elisão Heurística Antecipada (M1 + M2)**:
   - Disparada no **Soft Threshold ($B_1 \approx 60\%$ da janela)**.
   - Observações volumosas de ferramentas têm seu corpo substituído pelo stub:
     ```text
     [tool output elided: {N_LINES} lines / {N_CHARS} chars. Use recall_event({EVENT_ID}) for the full output, or re-read/re-run.]
     ```
   - O conteúdo original é armazenado em arquivo local (`.harness/events/event_{id}.log`).

3. **Estágio 2 — Sumarização Incremental via LLM (M3)**:
   - Disparada apenas no **Hard Threshold ($B_2 \approx 85\%$ da janela)** se a elisão não foi suficiente.
   - Compacta os eventos mais antigos da região $M$ nos 7 tópicos padronizados:
     `## Goal`, `## Files touched`, `## Done`, `## Pending`, `## Errors & fixes`, `## Current state`, `## Next step`.
   - O resumo é injetado como `<context-summary>` logo após o Preamble.

4. **Recuperação Sob Demanda (Recall M2)**:
   - Disponibiliza a ferramenta `recall_event(id)` para deselidir saídas sob demanda.
