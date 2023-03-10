FROM node:18

RUN git clone https://github.com/ioanmo226/chatgpt-web-application /GPTWebApp

WORKDIR /GPTWebApp
RUN npm install

RUN echo "OPENAI_API_KEY=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" > .env

EXPOSE 3001
CMD ["node", "index.js"]

# docker build -t chatgpt:web -f test.dockerfile .
# docker run -dp 3001:3001 chatgpt:web