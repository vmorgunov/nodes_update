#!/bin/bash

# Название приложения для мониторинга
APP_NAME="Shardeum"

# Сколько времени нужно подождать между проверками состояния приложения (в секундах)
CHECK_INTERVAL=1800

# APP_STATUS=$(operator-cli status | grep -o stopped)
APP_STATUS=$(pgrep -c "node /home/node")
  
# Бесконечный цикл для мониторинга состояния приложения
while true
do
  # Выполнить команду для проверки состояния приложения
  #if [ "$APP_STATUS" != "stopped" ]; then
  if [ $APP_STATUS -eq 0 ]; then
   # Приложение не работает
     echo "$(date) - $APP_NAME is not running. Restarting..."
     START_COMMAND="operator-cli start"
     $START_COMMAND
     sleep 10
  else
# Приложение работает
     echo "$(date) - $APP_NAME is running"
    # Подождать некоторое время перед следующей проверкой состояния приложения
     sleep 10
  fi
  
  # Подождать указанное количество времени перед следующей проверкой состояния приложения
  sleep $CHECK_INTERVAL
done

