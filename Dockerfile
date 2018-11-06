FROM                        eb-docker:base

# /srv/projects 폴더 내부에 복사
COPY                        ./ /srv/projects

# STATIC 파일 설정
WORKDIR                     /srv/projects/app
RUN                         python3 manage.py collectstatic --noinput

# Nginx 설정파일 옮기기
RUN                         rm -rf /etc/nginx/sites-available/* && \
                            rm -rf /etc/nginx/sites-enabled/* && \
                            cp -f /srv/projects/.config/app.nginx /etc/nginx/sites-available/ && \
                            ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx

# 80번 포트 열기
EXPOSE                      80

# supervisord 설정
RUN                         cp -f /srv/projects/.config/supervisord.conf /etc/supervisor/conf.d/
CMD                         supervisord -n
