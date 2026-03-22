# Auditoria Tecnica e Registro de Implantacao - fabrica-ia-api

Data: 2026-03-22
Repositorio: fabrica-ia-api

## Resumo executivo
- Arquitetura simples e funcional em Express + Supabase.
- Endpoint gateway da Fabrica presente e integrado via chave dedicada (`x-chave-fabrica`).
- Boa base para operacao, mas com pontos importantes de hardening e observabilidade.

## Estado atual

### Stack
- Node.js + Express
- Supabase SDK
- CORS com allowlist

### Endpoints relevantes
- `/api/status`
- CRUD de projetos/ideias/agentes/skills/memorias
- `/api/orquestrar-ideia` (protegido por chave de fabrica)
- `/api/cocriador-para-fabrica` (protegido por chave de fabrica)
- `/api/analisar-conversa`
- `/api/cron`

## Pontos fortes
- Integracao direta com Supabase
- CORS configurado com origens permitidas
- Middleware de chave da Fabrica para rotas sensiveis
- Middleware de autenticacao com token Supabase em rotas `/api` (com excecao de status)

## Riscos e lacunas

1) Validacao de payload insuficiente em varias rotas
- risco de entrada inconsistente e erro em runtime
- acao: padronizar validacao (schema por rota)

2) Segregacao de permissao por endpoint
- algumas rotas criticas podem precisar RBAC mais fino
- acao: separar perfis `admin`, `operator`, `service`

3) Observabilidade
- falta padrao de tracing/correlation id
- acao: incluir request-id e logs estruturados

4) Resiliencia
- timeouts/retries externalizados parcialmente
- acao: aplicar circuit-breaker para chamadas externas

5) Testes automatizados
- sem suite de testes formal no repositorio
- acao: adicionar smoke tests e testes de contrato API

## Recomendacao de implantacao

P0
- Validacao de payload para todas as rotas de escrita
- Hardening de auth nas rotas de orquestracao e cron
- Logging estruturado com correlation id

P1
- Testes automatizados (smoke + contrato)
- Dashboard de erro e latencia (Sentry/metrics)

P2
- Canario de deploy e rollback automatizado
- Regra de bloqueio de release por regressao

## Integracao com qg-ia-nexus
- Manter contrato estavel em:
  - `/api/status`
  - `/api/pipeline/iniciar` (consumido pelo plugin do Nexus)
  - `/api/pipeline/:id/stream`
- Versionar contrato e documentar breaking changes

## Conclusao
O repositório esta operacional e util para o pipeline atual. Para escalar com segurança, o foco imediato deve ser validacao rigorosa, RBAC por rota e trilho minimo de testes automatizados.
