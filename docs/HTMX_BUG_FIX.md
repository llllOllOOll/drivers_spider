# Bug: HTMX Partial Rendering via Traefik

## Problema

Quando um usuário clicava em um link da sidebar na documentação do Spider (ex: "Router", "PostgreSQL"), o HTMX recebia a **página inteira** (HTML completo com nav, sidebar, footer) e injetava dentro da área de conteúdo `#doc-content`, causando um layout quebrado.

### Comportamento Esperado
- Click em "Router" → apenas o conteúdo do doc carrega dentro de `#doc-content`
- Sidebar e layout permanecem estáticos

### Comportamento Real
- Click em "Router" → página inteira era injetada dentro de `#doc-content`
- Resultado: layout duplicado, sidebar aparecendo duas vezes

## Diagnóstico

### 1. Teste Local vs Produção

```bash
# Local (funciona)
curl -H "HX-Request: true" http://localhost:3000/docs/router
# Retorna: apenas o conteúdo do doc (<h1>Router</h1>...)

# Produção (não funciona)
curl -H "HX-Request: true" https://www.spiderme.org/docs/router
# Retorna: página HTML completa (<!DOCTYPE html>...<nav>...<sidebar>...)
```

### 2. Header HTMX Perdido

O servidor local recebia o header `HX-Request: true` corretamente, mas o servidor de produção não.

**Causa:** O Traefik (proxy reverso) estava **removendo ou não passando** o header `HX-Request` para o backend.

### 3. Tentativas de Solução

#### Tentativa 1: Middleware Traefik com customRequestHeaders
```yaml
# /storage/traefik-app/config/middlewares.yml
http:
  middlewares:
    spider-headers:
      headers:
        customRequestHeaders:
          X-HX-Request: "*"
```

**Resultado:** Traefik crashava ao carregar o middleware.

#### Tentativa 2: Labels Docker para Middleware
```bash
--label "traefik.http.routers.spiderme.middlewares=spider-headers"
--label "traefik.http.middlewares.spider-headers.headers.customRequestHeaders.X-HX-Request=*"
```

**Resultado:** Labels não criavam o middleware. Traefik Docker Provider não suporta criar middlewares via labels - só aceita referências `@file` ou `@docker`.

## Solução Final

Usar `hx-select` no **client side** para extrair apenas o conteúdo desejado da resposta.

### Implementação

Em `layout_docs.html`, adicionar `hx-select="#doc-content"` em todos os links da sidebar:

```html
<!-- Antes -->
<a hx-get="/docs/router" hx-target="#doc-content" hx-swap="innerHTML">Router</a>

<!-- Depois -->
<a hx-get="/docs/router" hx-target="#doc-content" hx-swap="innerHTML" hx-select="#doc-content">Router</a>
```

### Como Funciona

1. HTMX faz request para `/docs/router`
2. Backend retorna **página HTML completa** (não detecta HTMX)
3. HTMX usa `hx-select="#doc-content"` para extrair **apenas** o elemento com ID `doc-content` da resposta
4. O conteúdo extraído é injetado no target `#doc-content` na página atual

### Vantagens

- **Simples:** Não precisa de configuração no Traefik
- **Confiável:** Funciona independente do proxy reverso
- **Compatible:** Funciona em qualquer ambiente (Cloudflare, nginx, etc)

## Conclusão

O problema era que o Traefik não conseguia passar o header `HX-Request` para o backend, impossibilitando renderização parcial server-side.

A solução `hx-select` é client-side e não depende de headers HTTP customizados, tornando-a portable e fácil de implementar.
