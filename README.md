## Репозиторий для материалов курса [_OTUS. ML Professional_](https://otus.ru/learning/300381/)

### Подготовка к запуску блокнотов Jupyter

#### Создание виртуального окружения:
```
conda create --name otus-ml python=3.12.12
```
В случае ошибки вида `CondaSSLError: Encountered an SSL error. Most likely a certificate verification issue` помогло отключение безопасности соединения:
```
conda config --set ssl_verify false
```

#### Активация окружения
```
conda activate otus-ml
```
В случае множественной ошибки вида `CondaError: Run 'conda init' before 'conda activate'` помогла комбинация команд:
```
conda init --all
```
Перезапуск консоли, далее:
```
conda activate base
conda activate otus-ml
```

#### Установка пакетов в окружение

Пример установки пакетов:

```
conda install -n otus-ml lightgbm catboost
```

#### Миграция окружения
Для полного переноса окружения на другую машину можно сначала использовать альтернативные команды по выгрузки окружения в файл:
```
conda export -n otus-ml --file=./environment.yaml

conda list -n otus-ml --export > ./package-list.txt
```

Затем для воссоздания из файла использовать команду:
```
conda env create --name otus-ml --file ./environment.yaml
``` 