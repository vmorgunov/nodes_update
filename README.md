# nodes script tutorial for update

# SUI

```ruby
wget -O sui_update.sh https://raw.githubusercontent.com/vmorgunov/nodes/main/sui_update.sh && chmod +x sui_update.sh && ./sui_update.sh
```

# Gear

```ruby
wget -O gear_update.sh https://raw.githubusercontent.com/vmorgunov/nodes/main/gear_update.sh && chmod +x gear_update.sh && ./gear_update.sh
```

# Minima

```ruby
wget -O minima_update.sh https://raw.githubusercontent.com/vmorgunov/nodes/main/minima_update.sh && chmod +x minima_update.sh && ./minima_update.sh
```

Для того, чтобы убедиться в том, что Вы находитесь в правильной сети, а не форке необходимо сравнить номер блока в сети с другими участниками. На данный момент это значение составляет 39799
Для проверки можно использовать следующую команду

```ruby
curl 127.0.0.1:9002/status | jq | grep block
```
