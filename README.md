# SUI

```ruby
wget -O sui_update.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/sui_update.sh && chmod +x sui_update.sh && ./sui_update.sh
```

# SUI DB reset

```ruby
wget -O sui_db_clear.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/suidb_update.sh && chmod +x sui_db_clear.sh && ./sui_db_clear.sh

```

```ruby
wget -O sui_reload.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/sui_reload.sh && chmod +x sui_reload.sh && ./sui_reload.sh

```

# Gear

```ruby
wget -O gear_update.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/gear_update.sh && chmod +x gear_update.sh && ./gear_update.sh
```

Version 2

```ruby
wget -O gear-update-2.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/gear-update-2.sh && chmod +x gear-update-2.sh && ./gear-update-2.sh
```

# Minima

```ruby
wget -O minima_update.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/minima_update.sh && chmod +x minima_update.sh && ./minima_update.sh
```

Для того, чтобы убедиться в том, что Вы находитесь в правильной сети, а не форке необходимо сравнить номер блока в сети с другими участниками. На данный момент это значение составляет 39799
Для проверки можно использовать следующую команду

```ruby
curl 127.0.0.1:9002/status | jq | grep block
```

# Starknet

```ruby
wget -O starknet_update.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/starknet_update.sh && chmod +x starknet_update.sh && ./starknet_update.sh
```

# Lukso

CLI update

```ruby
wget -O lukso_update_cli.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/lukso_update_cli.sh && chmod +x lukso_update_cli.sh && ./lukso_update_cli.sh
```

# Bundlr

```ruby
wget -O bundlr_update.sh https://raw.githubusercontent.com/vmorgunov/nodes_update/main/bundlr_update.sh && chmod +x bundlr_update.sh && ./bundlr_update.sh
```
