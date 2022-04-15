FROM nginx:1.20.2-alpine

WORKDIR /usr/share/nginx/html/

COPY index.html /usr/share/nginx/html/ 
COPY style.css ./

CMD ["nginx", "-g", "daemon off;"]
