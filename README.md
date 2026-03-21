# IdeaOrganizer - Plataforma de Fábrica de Ideias

## O que é o IdeaOrganizer?
IdeaOrganizer é uma plataforma completa e autônoma de captação, refinamento e gestão de ideias de software e produtos. O sistema funciona como uma "Fábrica de Apps" rodando 24/7, utilizando inteligência artificial com uma arquitetura de múltiplos agentes (Multi-Agent System) para evoluir um simples pensamento inicial em um plano descritivo e estruturado pronto para desenvolvimento técnico.

A plataforma resolve o problema do "bloqueio criativo" e da desorganização de insights, permitindo que a entrada de ideias seja feita através de texto, voz ou num bate-papo interativo com um Agente Co-criador focado em inovação.

## Funcionalidades Principais

* **Agente Co-criador Interativo:** Um chat de IA embarcado na interface onde o usuário conversa, sofre questionamentos para aprimorar a ideia, recebe dicas de mercado e ao final transforma o resumo do bate-papo em uma ideia sólida no quadro geral com o botão "Salvar Ideia no Board".
* **Fábrica de Ideias Multi-Agente:** Arquitetura inteligente que utiliza múltiplos "Especialistas" e um "Orquestrador". Ao adicionar uma ideia bruta, a IA categoriza, cria projetos organizacionais automaticamente (se necessário) e escala o melhor agente para descrever a ideia em formato JSON (título, descrição, prioridade, próximos passos).
* **Roteador Inteligente e Failover Contínuo (CallCascata):** Conta com mecanismo de tolerância a falhas. Se a cota da Gemini API estourar, o sistema testa a OpenAI, Groq e Anthropic em cascata, garantindo que o cérebro da plataforma nunca pare.
* **Múltiplas Formas de Exibição:** Interface responsiva que permite visualizar as ideias processadas através de 3 formatos alternáveis:
  * **Grid (Cards):** Visão moderna e atraente. Estilizada com Glassmorphism.
  * **Lista (Tabela):** Uma visão densa e informativa ideal para bater o olho rápido no meio de dezenas de insights.
  * **Kanban (Board por Status):** Distribuição em colunas acompanhando o progresso da ideia ("Caixa de Entrada", "Pronto", etc).
* **Entrada Rápida via Voz do Navegador:** Integração nativa de Speech-to-Text em ambos formulário rápido e chat de co-criação.
* **Capacidade de Multiprojetos:** O usuário constrói 'Squads' separando a sua mente engarrafada em contêineres e projetos únicos na visualização lateral.
* **Anexos e Suporte a Preview Visual:** O app possibilita o encadeamento de arquivos (incluindo renderização de thumbnails nas caixinhas).

## O Que Falta Implementar (Próximos Passos & O Que Deve Ser Feito a Seguir)

Conforme a análise do projeto e evolução no `task.md`, este repositório está apto, porém as seguintes Epicas requerem trabalho arquitetural nas próximas fases:

1. **Processamento Real de Anexos no Back-end (Server.js):** 
   - Hoje os anexos são convertidos em Base64 e guardados no Front/SQLite, com preview estético.
   - O Orquestrador no Back-end precisa começar a interceptar os blobs em base64 e enviar para APIs Vision (ex: Gemini Flash) ou bibliotecas de parse de TXT/CSV, a fim de que a IA possa analisar a imagem de um rascunho de caderno do usuário e extrair o wireframe.
2. **Orquestração Sub-Agente Dinâmica Absoluta:** 
   - Em vez de um pipeline estático no Orquestrador para o Especialista, a plataforma deve conseguir paralisar a esteira, delegar instâncias "sob-demanda" e esperar retornos complexos. 
3. **Agente de Tradução (Pronto para Antigravity):**
   - Agente de conversão de metadados: Vai converter o JSON detalhado em um artefato real físico de Setup (`arquitetura_de_software_x.md`) ou repassar prompt exato pro Agente Mestre injetar código no diretório.
4. **Drag & Drop no Modo Kanban:**
   - Possibilidade do usuário clicar num card de "Caixa de Entrada", segurar, arrastar para a coluna "Validando", disparando atualização de estado no SQLite.
5. **Agente Auditor de Alucinação & Aprendizado Contínuo:** 
   - Step validatório ao fim do processo da "Fabrica" e criação de indexação Vector para as ideias já analisadas a fim de gerar RAG em cima da carteira de projetos atuais do usuário.
