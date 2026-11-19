const http = require('http');
const port = process.env.PORT || 8080;
const env = process.env.ENVIRONMENT || 'local';
const storage = process.env.STORAGE_ACCOUNT || 'not-configured';
http.createServer((req,res) => {
  if (req.url === '/health') { res.writeHead(200,{'Content-Type':'application/json'}); return res.end(JSON.stringify({status:'ok',environment:env})); }
  if (req.url === '/') { res.writeHead(200,{'Content-Type':'text/html; charset=utf-8'}); return res.end(`<!doctype html><html><head><title>LAB 11 Multi-Environment</title><style>body{font-family:system-ui;margin:4rem;background:#eef5ff;color:#123}article{background:white;padding:2rem;border-radius:12px;max-width:680px}</style></head><body><article><h1>LAB 11 — Project 07</h1><h2>Environment: ${env}</h2><p>Storage account: ${storage}</p><p><a href="/health">Health endpoint</a></p></article></body></html>`); }
  res.writeHead(404);res.end('Not found');
}).listen(port, '0.0.0.0');
