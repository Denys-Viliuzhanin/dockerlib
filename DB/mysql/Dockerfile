FROM mysql:8.0.32

RUN mkdir /app
RUN mkdir /app/db
RUN mkdir /app/db/locks

COPY ./app /app/db  
RUN chmod -R +x /app/db

ENTRYPOINT [ "/app/db/entry.sh" ]

