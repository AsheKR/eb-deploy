FROM                        python:3.6.7-slim
MAINTAINER                  ex@ex.com

# 배포환경, 개발환경 환경설정
ENV                         LAGN                    c.UTF-8

# 기본 패키지 설치 및 업데이트
RUN                         apt -y update
RUN                         apt -y dist-upgrade
RUN                         apt -y install gcc nginx supervisor

# uWSGI
RUN                         pip3 install uwsgi

# requirements 설치
COPY                        requirements.txt /tmp/
RUN                         pip3 install -r /tmp/requirements.txt

# /srv/projects 폴더 내부에 복사
COPY                        ./ /srv/projects

# STATIC 파일 설정
WORKDIR                     /srv/projects/app
RUN                         python3 manage.py collectstatic --noinput

# Nginx 설정파일 옮기기
RUN                         rm -rf /etc/nginx/sites-available/*
RUN                         rm -rf /etc/nginx/sites-enabled/*
RUN                         cp -f /srv/projects/.config/app.nginx /etc/nginx/sites-available/
RUN                         ln -sf /etc/nginx/sites-available/app.nginx /etc/nginx/sites-enabled/app.nginx

# supervisord 설정
RUN                         cp -f /srv/projects/.config/supervisord.conf /etc/supervisor/conf.d/
CMD                         supervisord -n
