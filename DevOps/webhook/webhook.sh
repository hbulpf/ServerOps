npm init 
npm install  gitee-webhook-handler --save 

npm install -g pm2
pm2 start webhook.js
pm2 monit 