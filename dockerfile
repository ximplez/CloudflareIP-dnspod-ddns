# --- 阶段 1: 构建器 (Builder) ---
# 使用官方 Node.js Alpine 镜像作为构建环境。Alpine 版本非常轻量。
# 我们使用一个明确的版本（如 20）以保证构建的可复现性。
FROM node:20-alpine AS builder

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json
COPY package*.json ./

# 安装所有依赖
RUN npm install

# 复制所有源代码到工作目录
COPY . .


# --- 阶段 2: 运行器 (Runner) ---
# 同样使用轻量的 Node.js Alpine 镜像作为最终的运行环境
FROM node:20-alpine

# 设置环境变量为生产环境
ENV NODE_ENV=production

# --- 新增：设置时区 ---
# 1. 安装 tzdata 包，这是 Alpine Linux 管理时区信息的官方方式。
# 2. 设置 TZ 环境变量为 "Asia/Shanghai"。容器启动时，系统会根据这个变量来配置时区。
#    我们使用 apk --no-cache 来避免缓存索引文件，保持镜像精简。
RUN apk --no-cache add tzdata
ENV TZ="Asia/Shanghai"
# --- 时区设置结束 ---

# 创建并设置工作目录
WORKDIR /app

# 再次复制 package.json 和 package-lock.json
COPY package*.json ./

# 只安装生产环境所需的依赖
RUN npm install --omit=dev

# 从构建器阶段复制应用程序源代码
COPY --chown=node:node . .

# 切换到内置的、权限较低的 'node' 用户，增强安全性
USER node

# 暴露应用程序监听的端口（根据项目代码，默认为 52100）
EXPOSE 52100

# 设置容器启动时执行的命令
CMD [ "node", "src/app.js" ]
